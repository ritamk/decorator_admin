import 'package:decorator_admin/controller/database.dart';
import 'package:decorator_admin/model/order_model.dart';
import 'package:decorator_admin/shared/constants.dart';
import 'package:decorator_admin/shared/loading.dart';
import 'package:decorator_admin/shared/snackbar.dart';
import 'package:decorator_admin/shared/widget_des.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderTile extends StatefulWidget {
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
  State<OrderTile> createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  bool _approving = false;

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
                statusIcon[STATUSES
                    .indexWhere((element) => element == widget.order.status)],
                const SizedBox(width: 10.0),
                Expanded(
                  child: InkWell(
                    onTap: () => widget.cltCall.call(),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            widget.order.cltName!,
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
                  "₹ ${widget.order.amount}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 5.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(widget.order.cltAddress!),
            ),
            const SizedBox(height: 10.0),
            divider(2.0, double.infinity, true),
            const SizedBox(height: 10.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (int i = 0; i < widget.order.item!.length; i++)
                        Text(
                          "• ${widget.order.item!.keys.toList()[i]}(s): "
                          "${widget.order.item!.values.toList()[i]}",
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
                          "${DateFormat("dd/MM/yyyy").format((widget.order.orderDate!.toDate()))}",
                          textAlign: TextAlign.end),
                      widget.order.editDate != null
                          ? Text(
                              "(edited: "
                              "${DateFormat("dd/MM/yyyy").format((widget.order.editDate!.toDate()))})",
                              textAlign: TextAlign.end)
                          : const SizedBox(height: 0.0, width: 0.0),
                      Text(
                          "\n${DateFormat("dd/MM/yyyy").format((widget.order.startDate!.toDate()))}\n"
                          "- to -\n"
                          "${DateFormat("dd/MM/yyyy").format((widget.order.endDate!.toDate()))}",
                          textAlign: TextAlign.center),
                    ],
                  ),
                ],
              ),
            ),
            if (widget.order.note!.isNotEmpty) const SizedBox(height: 10.0),
            if (widget.order.note!.isNotEmpty)
              divider(2.0, double.infinity, true),
            if (widget.order.note!.isNotEmpty) const SizedBox(height: 10.0),
            if (widget.order.note!.isNotEmpty)
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Note: ${widget.order.note!}")),
            const SizedBox(height: 10.0),
            divider(2.0, double.infinity, true),
            const SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: () => widget.empCall.call(),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                            child: Text(
                          widget.order.empName!,
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
                widget.order.approveDate != null
                    ? Text(
                        "approved: ${DateFormat("dd/MM/yyyy").format((widget.order.approveDate!.toDate()))}")
                    : const SizedBox(height: 0.0, width: 0.0),
              ],
            ),
            const SizedBox(height: 10.0),
            MaterialButton(
              elevation: 0.0,
              minWidth: double.infinity,
              color: buttonCol,
              textColor: buttonTextCol,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              onPressed: () {
                showCupertinoDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (context) => const ItemCountDialog(),
                );
              },
              child: const Text("Check item count",
                  style: TextStyle(fontSize: 18.0)),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemCountDialog extends StatefulWidget {
  const ItemCountDialog({Key? key}) : super(key: key);

  @override
  State<ItemCountDialog> createState() => _ItemCountDialogState();
}

class _ItemCountDialogState extends State<ItemCountDialog> {
  bool _loadingCount = true;
  bool _errorCount = false;

  Map<String, int> countMap = <String, int>{};
  Map<String, int> rateMap = <String, int>{};
  Map<String, int> remMap = <String, int>{};

  @override
  void initState() {
    super.initState();
    loadCount(() {
      if (!mounted) return;
      commonSnackbar("Something went wrong, couldn't load item count", context);
    }).whenComplete(() => setState(() => _loadingCount = false));
  }

  Future<void> loadCount(VoidCallback snackbar) async {
    try {
      countMap = await DatabaseController().getItemCount();
      remMap = await DatabaseController().getItemRem();
      rateMap = await DatabaseController().getItemRate();
    } catch (e) {
      snackbar.call();
      setState(() => _errorCount = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
        content: !_errorCount
            ? !_loadingCount
                ? Column(
                    children: <Widget>[
                      const Text(
                        "Current count:",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      for (int i = 0; i < ITEMS.length; i++)
                        Text(
                            "${ITEMS[i]}(s): ${remMap[ITEMS[i]]}/${countMap[ITEMS[i]]}"),
                      const Text(
                        "\nUpdated count:",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      for (int i = 0; i < ITEMS.length; i++)
                        Text(
                            "${ITEMS[i]}(s): ${remMap[ITEMS[i]]}/${countMap[ITEMS[i]]}"),
                    ],
                  )
                : const Loading(white: false)
            : const Text("Something went wrong, couldn't load item count.\n"
                "Please try again"));
  }
}
