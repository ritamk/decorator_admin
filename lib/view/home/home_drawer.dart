import 'package:decorator_admin/controller/database.dart';
import 'package:decorator_admin/controller/shared_pref.dart';
import 'package:decorator_admin/shared/constants.dart';
import 'package:decorator_admin/shared/loading.dart';
import 'package:decorator_admin/shared/snackbar.dart';
import 'package:decorator_admin/shared/widget_des.dart';
import 'package:decorator_admin/view/extras/completed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  bool _loadingCount = true;
  bool _errorCount = false;

  Map<String, int> countMap = <String, int>{};
  Map<String, int> rateMap = <String, int>{};
  Map<String, int> remMap = <String, int>{};

  @override
  void initState() {
    super.initState();
    loadCount(() {
      if (!mounted) return;
      commonSnackbar("Couldn't load item count", context);
    }).whenComplete(() => setState(() => _loadingCount = false));
  }

  Future<void> loadCount(VoidCallback snackbar) async {
    try {
      countMap = await DatabaseController().getItemCount();
      remMap = await DatabaseController().getItemRem();
      rateMap = await DatabaseController().getItemRate();
    } catch (e) {
      snackbar.call();
      setState(() => _errorCount = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: buttonCol,
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: !_errorCount
                ? !_loadingCount
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text("Item counts:\n",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15.0)),
                          for (int i = 0; i < ITEMS.length; i++)
                            Text(
                              "${ITEMS[i]}(s): ${remMap[ITEMS[i]]}/${countMap[ITEMS[i]]}",
                              style: const TextStyle(color: Colors.white),
                            ),
                        ],
                      )
                    : const Loading(white: true)
                : Row(
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
          divider(2.0, double.infinity, false),
          ListTile(
              textColor: buttonTextCol,
              iconColor: buttonTextCol,
              trailing: const Icon(Icons.done),
              title: const Text("    Completed Orders Page"),
              onTap: () => Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) => const CompletedOrdersPage()))),
        ],
      ),
    );
  }
}
