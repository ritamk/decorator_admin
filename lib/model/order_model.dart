import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String? ref;
  final String? uid;
  final String? empName;
  final String? empPhone;
  final String? cltName;
  final String? cltPhone;
  final String? cltAddress;
  final Map<String, dynamic>? item;
  final Timestamp? startDate;
  final Timestamp? endDate;
  final Timestamp? orderDate;
  final Timestamp? editDate;
  final Timestamp? approveDate;
  final String? status;
  final String? amount;
  final String? note;

  OrderModel({
    this.ref,
    this.uid,
    this.empName,
    this.empPhone,
    this.orderDate,
    this.editDate,
    this.startDate,
    this.endDate,
    this.approveDate,
    this.amount,
    this.cltName,
    this.cltPhone,
    this.cltAddress,
    this.item,
    this.status,
    this.note,
  });
}

class CompletedOrderModel {
  final String? ref;
  final String? uid;
  final String? empName;
  final String? empPhone;
  final String? cltName;
  final String? cltPhone;
  final String? cltAddress;
  final Map<String, dynamic>? item;
  final Timestamp? startDate;
  final Timestamp? endDate;
  final Timestamp? orderDate;
  final Timestamp? editDate;
  final Timestamp? approveDate;
  final Timestamp? completionDate;
  final String? status;
  final String? amount;
  final String? note;

  CompletedOrderModel({
    this.ref,
    this.uid,
    this.empName,
    this.empPhone,
    this.orderDate,
    this.editDate,
    this.startDate,
    this.endDate,
    this.completionDate,
    this.approveDate,
    this.amount,
    this.cltName,
    this.cltPhone,
    this.cltAddress,
    this.item,
    this.status,
    this.note,
  });
}
