import 'package:nyumbayo_app/models/UserAccountModel.dart';

import '/exports/exports.dart';

class DashboardHeader extends StatefulWidget {
  const DashboardHeader({super.key});

  @override
  State<DashboardHeader> createState() => _DashboardHeaderState();
}

class _DashboardHeaderState extends State<DashboardHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.all(18.0),
              child: Text(
                "Hi ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Text("Power Status", style: TextStyles(context).getBoldStyle()),
          // power status
        ],
      ),
    );
  }
}
