import 'package:nyumbayo_app/widgets/CustomRichText.dart';

import '../../payments/payment.dart';
import '/exports/exports.dart';

class MiniDashBoard extends StatefulWidget {
  const MiniDashBoard({super.key});

  @override
  State<MiniDashBoard> createState() => _MiniDashBoardState();
}

class _MiniDashBoardState extends State<MiniDashBoard> {
  @override
  Widget build(BuildContext context) {
    // computes percentage

    return
        // complaint tab
        TapEffect(
      onClick: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const PaymentScreen(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 19.0, right: 19.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width * 0.3683,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).primaryColor.withAlpha(255),
                    Theme.of(context).primaryColor.withAlpha(140),
                    Theme.of(context).primaryColor,
                  ],
                  stops: const [
                    0.0,
                    0.5,
                    1
                  ]),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(28.0, 28.0, 18.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomRichText(
                        children: [
                          TextSpan(
                            text: "Balance\n",
                            style: TextStyles(context)
                                .getRegularStyle()
                                .copyWith(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                          ),
                          TextSpan(
                            text: "\$ 400\n",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w900),
                          ),
                          TextSpan(
                            text: "Tap here to make payment\n",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w200),
                          )
                        ],
                      ),
                      SvgPicture.asset("assets/svg/money.svg",
                          color: Colors.white, width: 50, height: 50)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // end of complaint tab
  }
}
