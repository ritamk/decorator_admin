import 'package:decorator_admin/wrapper.dart';
import 'package:decorator_admin/shared/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Decorator App',
      theme: mainTheme(),
      color: buttonCol,
      home: const Wrapper(),
    );
  }
}

ThemeData mainTheme() {
  return ThemeData(
    fontFamily: "Montserrat",
    dividerColor: const Color.fromARGB(0, 0, 0, 0),
    // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    //   backgroundColor: Color.fromARGB(76, 255, 255, 255),
    //   elevation: 0.0,
    // ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        fontSize: 20.0,
        color: buttonTextCol,
        fontWeight: FontWeight.bold,
        fontFamily: "Montserrat",
      ),
      backgroundColor: buttonCol,
      foregroundColor: buttonTextCol,
    ),
    primarySwatch: Colors.red,
  );
}
