import 'package:decorator_admin/model/order_model.dart';
import 'package:decorator_admin/shared/constants.dart';
import 'package:decorator_admin/shared/widget_des.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({
    Key? key,
    required this.order,
    required this.cltCall,
    required this.empCall,
  }) : super(key: key);
  final OrderModel order;
  final VoidCallback cltCall;
  final VoidCallback empCall;

  @override
  Widget build(BuildContext context) {
    final List<Widget> statusIcon = <Widget>[
      Tooltip(
          message: STATUSES[0],
          child: const Icon(Icons.pending_actions, size: 32.0)),
      Tooltip(
          message: STATUSES[2],
          child: const Icon(Icons.check_circle, size: 32.0)),
      Tooltip(
          message: STATUSES[1], child: const Icon(Icons.schedule, size: 32.0)),
      Tooltip(
          message: STATUSES[3],
          child: const Icon(Icons.fact_check, size: 32.0)),
      Tooltip(message: STATUSES[4], child: const Icon(Icons.rule, size: 32.0)),
      Tooltip(
          message: STATUSES[5], child: const Icon(Icons.cancel, size: 32.0)),
    ];

    return Card(
      shadowColor: const Color.fromARGB(100, 0, 0, 0),
      elevation: 6.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                statusIcon[
                    STATUSES.indexWhere((element) => element == order.status)],
                const SizedBox(width: 10.0),
                Expanded(
                  child: InkWell(
                    onTap: () => cltCall.call(),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            order.cltName!,
                            style: const TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        const Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.phone,
                                size: 28.0, color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Text(
                  "₹ ${order.amount}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 5.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(order.cltAddress!),
            ),
            const SizedBox(height: 10.0),
            divider(2.0, double.infinity),
            const SizedBox(height: 10.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (int i = 0; i < order.item!.length; i++)
                        Text(
                          "• ${order.item!.keys.toList()[i]}(s): "
                          "${order.item!.values.toList()[i]}",
                          style: const TextStyle(fontSize: 16.0),
                        ),
                    ],
                  ),
                  const SizedBox(width: 10.0),
                  const SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                          "order date:\n"
                          "${DateFormat("dd/MM/yyyy").format((order.orderDate!.toDate()))}",
                          textAlign: TextAlign.end),
                      order.editDate != null
                          ? Text(
                              "(edited: "
                              "${DateFormat("dd/MM/yyyy").format((order.editDate!.toDate()))})",
                              textAlign: TextAlign.end)
                          : const SizedBox(height: 0.0, width: 0.0),
                      Text(
                          "\n${DateFormat("dd/MM/yyyy").format((order.startDate!.toDate()))}\n"
                          "- to -\n"
                          "${DateFormat("dd/MM/yyyy").format((order.endDate!.toDate()))}",
                          textAlign: TextAlign.center),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            divider(2.0, double.infinity),
            const SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: () => empCall.call(),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                            child: Text(
                          order.empName!,
                          style: const TextStyle(fontSize: 18.0),
                        )),
                        const SizedBox(width: 10.0),
                        const Icon(Icons.phone,
                            size: 28.0, color: Colors.green),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                order.approveDate != null
                    ? Text(
                        "approved: ${DateFormat("dd/MM/yyyy").format((order.approveDate!.toDate()))}")
                    : const SizedBox(height: 0.0, width: 0.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
