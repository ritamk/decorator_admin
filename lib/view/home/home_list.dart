import 'package:decorator_admin/controller/database.dart';
import 'package:decorator_admin/controller/shared_pref.dart';
import 'package:decorator_admin/model/employee_model.dart';
import 'package:decorator_admin/model/order_model.dart';
import 'package:decorator_admin/shared/constants.dart';
import 'package:decorator_admin/shared/loading.dart';
import 'package:decorator_admin/shared/snackbar.dart';
import 'package:decorator_admin/view/home/edit_order.dart';
import 'package:decorator_admin/view/home/home_order_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeList extends ConsumerStatefulWidget {
  const HomeList({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeList> createState() => _HomeListState();
}

class _HomeListState extends ConsumerState<HomeList> {
  bool _loadingUserData = true;
  bool _loading = true;
  bool _error = false;

  List<OrderModel> _orderList = <OrderModel>[];

  @override
  void initState() {
    super.initState();
    if (UserSharedPreferences.getDetailedUseData() != null) {
      setState(() => _loadingUserData = false);
    } else {
      loadUserData(
        () {
          if (!mounted) return;
          commonSnackbar("Could not load user data", context);
        },
      ).whenComplete(() => setState(() => _loadingUserData = false));
    }
    loadOrderData().whenComplete(() => setState(() => _loading = false));
  }

  Future<void> loadOrderData() async {
    try {
      await DatabaseController(uid: UserSharedPreferences.getUid())
          .getOrderData()
          .then((value) => value != null
              ? setState(() => _orderList = value)
              : setState(() => _error = true))
          .timeout(
            const Duration(seconds: 20),
            onTimeout: () => setState(() => _error = true),
          );
    } catch (e) {
      try {
        await DatabaseController(uid: UserSharedPreferences.getUid())
            .getOrderData()
            .then((value) => value != null
                ? _orderList = value
                : setState(() => _error = true));
      } catch (e) {
        setState(() => _error = true);
      }
    }
  }

  void call(String num) {
    try {
      launchUrl(Uri(scheme: "tel", path: "+91$num"));
    } catch (e) {
      ClipboardData(text: "+91$num");
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: bouncingScroll,
      slivers: <Widget>[
        CupertinoSliverRefreshControl(
          onRefresh: () async => await loadOrderData(),
        ),
        SliverToBoxAdapter(
          child: !_error
              ? Padding(
                  padding: pagePadding,
                  child: !_loading && !_loadingUserData
                      ? _orderList.isNotEmpty
                          ? ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: _orderList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    (_orderList[index].status! != STATUSES[1] ||
                                            _orderList[index].status! !=
                                                STATUSES[1])
                                        ? Navigator.of(context).push(
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    EditOrderPage(
                                                        order:
                                                            _orderList[index])))
                                        : commonSnackbar(
                                            "Order cannot be edited now",
                                            context);
                                  },
                                  child: OrderTile(
                                    order: _orderList[index],
                                    cltCall: () {
                                      if (!mounted) return;
                                      call(_orderList[index].cltPhone!);
                                    },
                                    empCall: () {
                                      if (!mounted) return;
                                      call(_orderList[index].empPhone!);
                                    },
                                  ),
                                );
                              },
                              clipBehavior: Clip.none,
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 24.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Icon(Icons.cancel, color: buttonCol),
                                  SizedBox(width: 10.0),
                                  Text("No incomplete orders"),
                                ],
                              ),
                            )
                      : const Center(child: Loading(white: false, rad: 14.0)),
                )
              : Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(Icons.error, color: Colors.red),
                      SizedBox(width: 10.0),
                      Text(
                        "Something went wrong, couldn't load data\n"
                        "Please try again later.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }

  Future<void> loadUserData(VoidCallback snackbar) async {
    try {
      final EmployeeModel? employeeModel =
          await DatabaseController(uid: UserSharedPreferences.getUid())
              .getEmployeeData();

      if (employeeModel != null) {
        UserSharedPreferences.setDetailedUserData(employeeModel);
      }
    } catch (e) {
      try {
        final EmployeeModel? employeeModel =
            await DatabaseController(uid: UserSharedPreferences.getUid())
                .getEmployeeData();
        if (employeeModel != null) {
          UserSharedPreferences.setDetailedUserData(employeeModel);
        }
      } catch (e) {
        snackbar.call();
      }
    }
  }
}
