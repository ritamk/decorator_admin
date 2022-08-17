import 'package:decorator_admin/controller/database.dart';
import 'package:decorator_admin/model/employee_model.dart';
import 'package:decorator_admin/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> signInWithMailPass(String mail, String pass) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: mail, password: pass);

      return userCredential.user?.uid;
    } catch (e) {
      print("signInWithMailPass: ${e.toString()}");
      throw STH_WENT_WRONG;
    }
  }

  Future<String?> registerWithMailPass(
      String name, String phone, String mail, String pass) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: mail, password: pass);
      User? user = userCredential.user;

      if (user != null) {
        await DatabaseController(uid: user.uid).setEmployeeData(EmployeeModel(
          uid: user.uid,
          name: name,
          phone: phone,
          email: mail,
        ));
      } else {
        return null;
      }

      return userCredential.user?.uid;
    } catch (e) {
      print("registerWithMailPass: ${e.toString()}");
      throw STH_WENT_WRONG;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print("signOut: ${e.toString()}");
      throw STH_WENT_WRONG;
    }
  }

  Future<String> currentUser() async {
    try {
      return _firebaseAuth.currentUser?.uid ?? "";
    } catch (e) {
      print("currentUser: ${e.toString()}");
      throw "";
    }
  }
}
