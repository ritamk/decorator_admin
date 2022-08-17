import 'package:decorator_admin/model/order_model.dart';

class EmployeeModel {
  final String? uid;
  final String? name;
  final String? phone;
  final String? email;
  final List<OrderModel>? orders;

  EmployeeModel({
    this.uid,
    this.name,
    this.email,
    this.phone,
    this.orders,
  });
}
