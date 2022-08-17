import 'package:decorator_admin/model/order_model.dart';
import 'package:flutter/material.dart';

class CompletedOrdersPage extends StatefulWidget {
  const CompletedOrdersPage({Key? key}) : super(key: key);

  @override
  State<CompletedOrdersPage> createState() => _CompletedOrdersPageState();
}

class _CompletedOrdersPageState extends State<CompletedOrdersPage> {
  bool _loading = true;

  List<CompletedOrderModel> _orderList = <CompletedOrderModel>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Completed Orders"),
      ),
    );
  }
}
