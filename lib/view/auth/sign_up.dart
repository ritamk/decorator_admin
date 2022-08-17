import 'package:decorator_admin/controller/auth.dart';
import 'package:decorator_admin/controller/shared_pref.dart';
import 'package:decorator_admin/shared/constants.dart';
import 'package:decorator_admin/shared/loading.dart';
import 'package:decorator_admin/shared/snackbar.dart';
import 'package:decorator_admin/shared/widget_des.dart';
import 'package:decorator_admin/view/home/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String name = "";
  String mail = "";
  String phone = "";
  String pass = "";
  bool _hidePassword = true;
  bool loading = false;
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _passFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _mailFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign-up"),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Form(
            key: _globalKey,
            child: Column(
              children: <Widget>[
                // name form field
                TextFormField(
                  decoration:
                      authTextInputDecoration("Name", Icons.person, null),
                  focusNode: _nameFocusNode,
                  validator: (val) =>
                      val!.isEmpty ? "Please enter your name" : null,
                  onChanged: (val) => name = val,
                  maxLength: 20,
                  keyboardType: TextInputType.name,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (val) =>
                      FocusScope.of(context).requestFocus(_phoneFocusNode),
                ),
                const SizedBox(height: 20.0),
                // phone form field
                TextFormField(
                  decoration:
                      authTextInputDecoration("Phone", Icons.phone, "+91 "),
                  focusNode: _phoneFocusNode,
                  validator: (val) =>
                      val!.isEmpty ? "Please enter your phone number" : null,
                  onChanged: (val) => phone = val,
                  maxLength: 10,
                  keyboardType: TextInputType.phone,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (val) =>
                      FocusScope.of(context).requestFocus(_mailFocusNode),
                ),
                const SizedBox(height: 20.0),
                // email form field
                TextFormField(
                  decoration:
                      authTextInputDecoration("Email", Icons.mail, null),
                  focusNode: _mailFocusNode,
                  validator: (val) =>
                      val!.isEmpty ? "Please enter a valid email" : null,
                  onChanged: (val) => mail = val,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (val) =>
                      FocusScope.of(context).requestFocus(_passFocusNode),
                ),
                const SizedBox(height: 20.0),
                // password form field
                TextFormField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20.0),
                    fillColor: formFieldCol,
                    filled: true,
                    prefixIcon: const Icon(Icons.vpn_key),
                    labelText: "Password",
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: textFieldBorder(),
                    focusedBorder: textFieldBorder(),
                    errorBorder: textFieldBorder(),
                    suffixIcon: IconButton(
                        onPressed: () => setState(
                              () => _hidePassword = !_hidePassword,
                            ),
                        icon: (_hidePassword)
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off)),
                  ),
                  focusNode: _passFocusNode,
                  validator: (val) => (val!.length < 6)
                      ? "Please enter a password with\nmore than 6 characters"
                      : null,
                  onChanged: (val) => pass = val,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (val) => FocusScope.of(context).unfocus(),
                  obscureText: _hidePassword,
                ),
                const SizedBox(height: 40.0),
                // sign up button
                TextButton(
                  style: authSignInBtnStyle(),
                  onPressed: () => signUpLogic(
                    () {
                      if (!mounted) return;
                      Navigator.of(context).pushAndRemoveUntil(
                          CupertinoPageRoute(
                              builder: (context) => const HomePage()),
                          (route) => false);
                    },
                    () {
                      if (!mounted) return;
                      commonSnackbar(
                        "Couldn't sign-up, please try again later.\n"
                        "Please check credentials and/or network connection.",
                        context,
                      );
                    },
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: loading
                        ? const Loading(
                            white: true,
                          )
                        : const Text(
                            "Sign-up",
                            style:
                                TextStyle(color: buttonTextCol, fontSize: 18.0),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signUpLogic(VoidCallback route, VoidCallback snackbar) async {
    if (_globalKey.currentState!.validate()) {
      setState(() => loading = true);
      try {
        dynamic result = await AuthenticationController()
            .registerWithMailPass(name, phone, mail, pass);
        if (result != null) {
          await UserSharedPreferences.setUid(result)
              .then((value) => value ? null : snackbar.call());
          await UserSharedPreferences.setLoggedIn(true)
              .then((value) => value ? null : snackbar.call());
          loading = false;
          route.call();
        } else {
          setState(() => loading = false);
          snackbar.call();
        }
      } catch (e) {
        snackbar.call();
      }
    }
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _phoneFocusNode.dispose();
    _passFocusNode.dispose();
    _mailFocusNode.dispose();
    super.dispose();
  }
}
