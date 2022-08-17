import 'package:flutter/cupertino.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key, required this.white, this.rad}) : super(key: key);
  final bool white;
  final double? rad;

  @override
  Widget build(BuildContext context) {
    return white
        ? CupertinoTheme(
            data: const CupertinoThemeData(brightness: Brightness.dark),
            child: CupertinoActivityIndicator(radius: rad ?? 10.0))
        : CupertinoTheme(
            data: const CupertinoThemeData(brightness: Brightness.light),
            child: CupertinoActivityIndicator(radius: rad ?? 10.0));
  }
}
