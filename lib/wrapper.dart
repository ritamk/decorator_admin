import 'package:decorator_admin/controller/auth.dart';
import 'package:decorator_admin/controller/shared_pref.dart';
import 'package:decorator_admin/shared/constants.dart';
import 'package:decorator_admin/shared/loading.dart';
import 'package:decorator_admin/shared/snackbar.dart';
import 'package:decorator_admin/view/auth/auth_page.dart';
import 'package:decorator_admin/view/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Wrapper extends ConsumerStatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  ConsumerState<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends ConsumerState<Wrapper> {
  bool timeOut = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2))
        .then((value) => setState(() => timeOut = true));
  }

  @override
  Widget build(BuildContext context) {
    if (timeOut) {
      return const HomePage();
    } else {
      return const WrapperBody();
    }
  }
}

class WrapperBody extends StatelessWidget {
  const WrapperBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Center(child: decoratorText),
          SizedBox(height: 40.0),
          Loading(white: false, rad: 14.0),
        ],
      ),
    );
  }
}
