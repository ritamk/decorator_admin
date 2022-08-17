import 'package:decorator_admin/controller/auth.dart';
import 'package:decorator_admin/controller/shared_pref.dart';
import 'package:decorator_admin/shared/constants.dart';
import 'package:decorator_admin/shared/loading.dart';
import 'package:decorator_admin/shared/snackbar.dart';
import 'package:decorator_admin/shared/widget_des.dart';
import 'package:decorator_admin/view/home/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String mail = "";
  String pass = "";
  bool _hidePassword = true;
  bool loading = false;
  final FocusNode _passFocusNode = FocusNode();
  final FocusNode _mailFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign-In"),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                // email form field
                TextFormField(
                  decoration:
                      authTextInputDecoration("Email", Icons.mail, null),
                  focusNode: _mailFocusNode,
                  validator: (val) =>
                      val!.isEmpty ? "Please enter your email" : null,
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
                  validator: (val) =>
                      val!.isEmpty ? "Please enter your password" : null,
                  onChanged: (val) => pass = val,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (val) => FocusScope.of(context).unfocus(),
                  obscureText: _hidePassword,
                ),
                // forgot password button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      style: const ButtonStyle(
                          splashFactory: NoSplash.splashFactory),
                      onPressed: () {},
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40.0),
                // sign in button
                TextButton(
                  style: authSignInBtnStyle(),
                  onPressed: () => signInLogic(
                    () {
                      if (!mounted) return;
                      Navigator.of(context).pushAndRemoveUntil(
                          CupertinoPageRoute(
                              builder: (context) => const HomePage()),
                          (route) => false);
                    },
                    () {
                      if (!mounted) return;
                      commonSnackbar(STH_WENT_WRONG, context);
                    },
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: loading
                        ? const Loading(
                            white: true,
                          )
                        : const Text(
                            "Sign-in",
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

  @override
  void dispose() {
    _passFocusNode.dispose();
    _mailFocusNode.dispose();
    super.dispose();
  }

  Future<void> signInLogic(VoidCallback route, VoidCallback snackbar) async {
    if (_formKey.currentState!.validate()) {
      setState(() => loading = true);
      try {
        dynamic result =
            await AuthenticationController().signInWithMailPass(mail, pass);
        if (result != STH_WENT_WRONG) {
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
}
