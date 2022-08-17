import 'package:decorator_admin/controller/database.dart';
import 'package:decorator_admin/controller/shared_pref.dart';
import 'package:decorator_admin/model/employee_model.dart';
import 'package:decorator_admin/shared/constants.dart';
import 'package:decorator_admin/shared/loading.dart';
import 'package:decorator_admin/shared/snackbar.dart';
import 'package:decorator_admin/shared/widget_des.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _uploading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _nameController.text =
        UserSharedPreferences.getDetailedUseData()?.name ?? "";
    _phoneController.text =
        UserSharedPreferences.getDetailedUseData()?.phone ?? "";
    _emailController.text =
        UserSharedPreferences.getDetailedUseData()?.email ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Padding(
          padding: pagePadding,
          child: SingleChildScrollView(
            physics: bouncingScroll,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // name
                  TextFormField(
                    controller: _nameController,
                    decoration:
                        authTextInputDecoration("Name", Icons.person, null),
                    focusNode: _nameFocus,
                    validator: (val) =>
                        val!.isEmpty ? "Please enter your name" : null,
                    maxLength: 20,
                    keyboardType: TextInputType.name,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (val) =>
                        FocusScope.of(context).requestFocus(_phoneFocus),
                  ),
                  const SizedBox(height: 20.0),
                  // phone
                  TextFormField(
                    controller: _phoneController,
                    decoration:
                        authTextInputDecoration("Phone", Icons.phone, "+91 "),
                    focusNode: _phoneFocus,
                    validator: (val) =>
                        val!.isEmpty ? "Please enter your phone number" : null,
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (val) => FocusScope.of(context).unfocus(),
                  ),
                  const SizedBox(height: 20.0),
                  // email
                  TextFormField(
                    controller: _emailController,
                    decoration:
                        authTextInputDecoration("Email", Icons.mail, null),
                    enabled: false,
                  ),
                  const SizedBox(height: 40.0),
                  Consumer(builder: (context, ref, _) {
                    return TextButton(
                      style: authSignInBtnStyle(),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => _uploading = true);
                          try {
                            await DatabaseController(
                                    uid: UserSharedPreferences.getUid())
                                .editEmployeeData(EmployeeModel(
                              name: _nameController.text,
                              phone: _phoneController.text,
                            ))
                                .whenComplete(() {
                              UserSharedPreferences.setDetailedUserData(
                                  EmployeeModel(
                                      uid: UserSharedPreferences.getUid(),
                                      name: _nameController.text,
                                      phone: _phoneController.text,
                                      email: _emailController.text));
                              commonSnackbar(
                                  "Updated data successfully", context);
                            });
                          } catch (e) {
                            commonSnackbar("Failed to update data", context);
                          }
                          setState(() => _uploading = false);
                        }
                      },
                      child: !_uploading
                          ? const Text("Update",
                              style: TextStyle(
                                  color: buttonTextCol, fontSize: 18.0))
                          : const Loading(white: true),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
