import 'package:nyumbayo_app/widgets/CustomRichText.dart';

import '/views/Inventory/Preview.dart';
import '/views/reports/GraphicalReport.dart';
import '/exports/exports.dart';
import 'widgets/DashboardHeader.dart';
import 'widgets/MiniDashboard.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, value: 0, duration: const Duration(seconds: 1));
    _controller?.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // dashboard header
          const DashboardHeader(),
          // end of dashboard header
          const MiniDashBoard(),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Recent Transactions",
                    style: Theme.of(context).textTheme.titleMedium!),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Text("View all"),
                  label: const Icon(Icons.arrow_forward),
                )
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.fromLTRB(20, 14, 10, 0),
            child: SizedBox(
              height: 140,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("  AMOUNT PAID"),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.close, color: Colors.red),
                              const SizedBox.square(dimension: 10),
                              Text("Incomplete",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .apply(color: Colors.red)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
                    child: Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("  AMOUNT PAID"),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.close, color: Colors.red),
                              const SizedBox.square(dimension: 10),
                              Text("Incomplete",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .apply(color: Colors.red)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton.extended(
                heroTag: null,
                icon: const Icon(Icons.analytics),
                onPressed: () => Routes.push(const GraphicalReport(), context),
                label: const Text("Analytics"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton.extended(
                heroTag: null,
                onPressed: () => Routes.push(const Preview(), context),
                label: const Text("Inventory"),
                icon: const Icon(Icons.inventory),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
