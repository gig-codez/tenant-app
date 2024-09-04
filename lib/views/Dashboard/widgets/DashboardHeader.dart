import 'package:nyumbayo_app/models/UserAccountModel.dart';

import '../../../widgets/CustomRichText.dart';
import '/exports/exports.dart';

class DashboardHeader extends StatefulWidget {
  const DashboardHeader({super.key});

  @override
  State<DashboardHeader> createState() => _DashboardHeaderState();
}

class _DashboardHeaderState extends State<DashboardHeader> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainController>(builder: (context, controller, child) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: CustomRichText(
                  children: [
                    const TextSpan(
                      text: "Hello, \n",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                      text: "${controller.userData['name']}, ",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TapEffect(
                  onClick: () {},
                  child: SvgPicture.asset("assets/svg/notification.svg")),
            ),
            // power status
          ],
        ),
      );
    });
  }
}
