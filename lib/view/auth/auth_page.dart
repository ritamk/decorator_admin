import 'package:decorator_admin/shared/constants.dart';
import 'package:decorator_admin/shared/widget_des.dart';
import 'package:decorator_admin/view/auth/sign_in.dart';
import 'package:decorator_admin/view/auth/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Center(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Center(child: decoratorText),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).push(
                          CupertinoPageRoute(
                              builder: (builder) => const SignUpPage())),
                      style: authSignInBtnStyle(),
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          "Sign-up",
                          style: TextStyle(
                              fontSize: 17.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).push(
                          CupertinoPageRoute(
                              builder: (builder) => const SignInPage())),
                      style: authSignInBtnStyle(),
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          "Sign-in",
                          style: TextStyle(
                              fontSize: 17.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
