import 'package:decorator_admin/shared/constants.dart';
import 'package:decorator_admin/view/home/home_drawer.dart';
import 'package:decorator_admin/view/home/home_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomeDrawer(),
      appBar: AppBar(
        title: const Text("Home"),
        actions: <Widget>[
          IconButton(
              onPressed: () => showCupertinoDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (context) => const UserGuideDialog(),
                  ),
              icon: const Icon(Icons.info)),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              text: "Pending",
            ),
            Tab(
              text: "Approved",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          HomeList(filtered: true, approved: false),
          HomeList(filtered: true, approved: true),
        ],
      ),
    );
  }
}

class UserGuideDialog extends StatelessWidget {
  const UserGuideDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text("Usage guide"),
      content: Column(
        children: <Widget>[
          const SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              const Icon(Icons.pending_actions),
              const SizedBox(width: 10.0),
              Flexible(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black87),
                    children: <InlineSpan>[
                      TextSpan(
                          text: STATUSES[0],
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const TextSpan(
                        text: ", order is pending any action by the admin.",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              const Icon(Icons.check_circle),
              const SizedBox(width: 10.0),
              Flexible(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black87),
                    children: <InlineSpan>[
                      TextSpan(
                          text: STATUSES[2],
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const TextSpan(
                        text: ", order has been approved but isn't active yet.",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              const Icon(Icons.schedule),
              const SizedBox(width: 10.0),
              Flexible(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black87),
                    children: <InlineSpan>[
                      TextSpan(
                          text: STATUSES[1],
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const TextSpan(
                        text: ", order has been approved and is active.",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              const Icon(Icons.fact_check),
              const SizedBox(width: 10.0),
              Flexible(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black87),
                    children: <InlineSpan>[
                      TextSpan(
                          text: STATUSES[3],
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const TextSpan(
                        text: ", order has been edited and is pending.",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              const Icon(Icons.rule),
              const SizedBox(width: 10.0),
              Flexible(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black87),
                    children: <InlineSpan>[
                      TextSpan(
                          text: STATUSES[4],
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const TextSpan(
                        text:
                            ", admin has requested the employee to accept a modified order.",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              const Icon(Icons.cancel),
              const SizedBox(width: 10.0),
              Flexible(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black87),
                    children: <InlineSpan>[
                      TextSpan(
                          text: STATUSES[5],
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const TextSpan(
                        text: ", order has been rejected.",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
