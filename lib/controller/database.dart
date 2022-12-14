import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decorator_admin/model/employee_model.dart';
import 'package:decorator_admin/model/order_model.dart';
import 'package:decorator_admin/shared/constants.dart';

class DatabaseController {
  final String? uid;

  DatabaseController({this.uid});

  final CollectionReference _employeeCollection =
      FirebaseFirestore.instance.collection("Employee");

  final CollectionReference _orderCollection =
      FirebaseFirestore.instance.collection("Order");

  final CollectionReference _completedCollection =
      FirebaseFirestore.instance.collection("Completed");

  final CollectionReference _adminCollection =
      FirebaseFirestore.instance.collection("Admin");

  Future<EmployeeModel?> getEmployeeData() async {
    try {
      final DocumentSnapshot docSnap = await _employeeCollection.doc(uid).get();
      final dynamic data = docSnap.data();
      return EmployeeModel(
        name: data["name"],
        email: data["email"],
        phone: data["phone"],
      );
    } catch (e) {
      print("getEmployeeData: ${e.toString()}");
      throw STH_WENT_WRONG;
    }
  }

  Future<void> editOrderData(OrderModel order) async {
    try {
      print(order.ref);
      await _orderCollection.doc(order.ref).update({
        "empName": order.empName,
        "empPhone": order.empPhone,
        "cltName": order.cltName,
        "cltPhone": order.cltPhone,
        "cltAddress": order.cltAddress,
        "amount": order.amount,
        "item": order.item,
        "editDate": order.editDate,
        "startDate": order.startDate,
        "endDate": order.endDate,
        "approveDate": order.approveDate,
        "status": order.status,
        "note": order.note,
      });
    } catch (e) {
      print("editOrderData: ${e.toString()}");
      throw STH_WENT_WRONG;
    }
  }

  Future<List<OrderModel>?> getOrderData(bool filtered, bool approved) async {
    try {
      final QuerySnapshot docSnap = !filtered
          ? await _orderCollection.get()
          : approved
              ? await _orderCollection
                  .where("status", isEqualTo: "Approved")
                  .get()
              : await _orderCollection
                  .where("status", isNotEqualTo: "Approved")
                  .get();
      return docSnap.docs
          .map(
            (QueryDocumentSnapshot e) => OrderModel(
              ref: e["ref"],
              uid: e["uid"],
              empName: e["empName"],
              empPhone: e["empPhone"],
              orderDate: e["orderDate"],
              editDate: e["editDate"],
              startDate: e["startDate"],
              endDate: e["endDate"],
              approveDate: e["approveDate"],
              amount: e["amount"],
              cltName: e["cltName"],
              cltAddress: e["cltAddress"],
              cltPhone: e["cltPhone"],
              item: e["item"],
              status: e["status"],
              note: e["note"],
            ),
          )
          .toList();
    } catch (e) {
      print("getOrderData: ${e.toString()}");
      throw STH_WENT_WRONG;
    }
  }

  Future<Map<String, int>> getItemCount() async {
    try {
      Map<String, int> map = <String, int>{};
      final DocumentSnapshot docSnap =
          await _adminCollection.doc("itemCount").get();
      for (int i = 0; i < ITEMS.length; i++) {
        map[ITEMS[i]] = docSnap["${ITEMS[i]}Total"];
      }
      return map;
    } catch (e) {
      print("getItemCount: ${e.toString()}");
      throw STH_WENT_WRONG;
    }
  }

  Future<Map<String, int>> getItemRem() async {
    try {
      Map<String, int> map = <String, int>{};
      final DocumentSnapshot docSnap =
          await _adminCollection.doc("itemRem").get();
      for (int i = 0; i < ITEMS.length; i++) {
        map[ITEMS[i]] = docSnap["${ITEMS[i]}Rem"];
      }
      return map;
    } catch (e) {
      print("getItemRem: ${e.toString()}");
      throw STH_WENT_WRONG;
    }
  }

  Future<Map<String, int>> getItemRate() async {
    try {
      Map<String, int> map = <String, int>{};
      final DocumentSnapshot docSnap =
          await _adminCollection.doc("itemRate").get();
      for (int i = 0; i < ITEMS.length; i++) {
        map[ITEMS[i]] = docSnap["${ITEMS[i]}Rate"];
      }
      return map;
    } catch (e) {
      print("getItemRate: ${e.toString()}");
      throw STH_WENT_WRONG;
    }
  }
}
