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
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // dashboard header
          DashboardHeader(),
          // end of dashboard header
          MiniDashBoard(),
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
