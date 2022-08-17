import 'package:decorator_admin/controller/auth.dart';
import 'package:decorator_admin/controller/shared_pref.dart';
import 'package:decorator_admin/model/employee_model.dart';
import 'package:decorator_admin/shared/constants.dart';
import 'package:decorator_admin/shared/loading.dart';
import 'package:decorator_admin/view/extras/completed.dart';
import 'package:decorator_admin/view/extras/profile.dart';
import 'package:decorator_admin/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  bool _signingOut = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: buttonCol,
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  UserSharedPreferences.getDetailedUseData()?.name ?? "",
                  style: const TextStyle(
                      color: buttonTextCol,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10.0),
                Text(
                  UserSharedPreferences.getDetailedUseData()?.phone ?? "",
                  style: const TextStyle(color: buttonTextCol),
                ),
                Text(
                  UserSharedPreferences.getDetailedUseData()?.email ?? "",
                  style: const TextStyle(color: buttonTextCol),
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
              textColor: buttonTextCol,
              iconColor: buttonTextCol,
              trailing: const Icon(Icons.person),
              title: const Text("    Profile Page"),
              onTap: () => Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) => const ProfilePage()))),
          ListTile(
              textColor: buttonTextCol,
              iconColor: buttonTextCol,
              trailing: const Icon(Icons.done),
              title: const Text("    Completed Orders Page"),
              onTap: () => Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) => const CompletedOrdersPage()))),
          Expanded(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: ListTile(
              textColor: buttonTextCol,
              iconColor: buttonTextCol,
              trailing: const Icon(Icons.logout),
              title: !_signingOut
                  ? const Text("    Sign out")
                  : const Loading(white: true),
              onTap: () => signOutLogic(() {
                if (!mounted) return;
                Navigator.of(context).pushAndRemoveUntil(
                    CupertinoPageRoute(
                      builder: (context) => const Wrapper(),
                    ),
                    (route) => false);
              }),
            ),
          )),
        ],
      ),
    );
  }

  Future<void> signOutLogic(VoidCallback route) async {
    setState(() => _signingOut = true);
    await UserSharedPreferences.setLoggedIn(false);
    await UserSharedPreferences.setUid("");
    await UserSharedPreferences.setDetailedUserData(EmployeeModel(name: null));
    await AuthenticationController().signOut();
    route.call();
  }
}
