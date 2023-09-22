import 'package:nyumbayo_app/models/Payment.dart';
import 'package:nyumbayo_app/models/UserModel.dart';

import '../../controllers/PaymentController.dart';
import '/views/Inventory/Preview.dart';
import '/views/reports/GraphicalReport.dart';

import '../../controllers/PowerBillController.dart';
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
    // BlocProvider.of<UserdataController>(context).getUserData();
    // context
    //     .read<MainController>()
    //     .setPower(context.read<UserdataController>().state);
    context.read<MainController>().fetchPowerConsumed();
    // BlocProvider.of<TenantController>(context)
    //     .fetchTenants(context.read<UserdataController>().state);
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
    BlocProvider.of<UserAccountController>(context).getUserData();
    String userId = context.read<UserAccountController>().state.userId;
    BlocProvider.of<PaymentController>(context).fetchLastPayment(userId);
    BlocProvider.of<TenantController>(context).fetchTenantData(userId);
    // settings power status

    BlocProvider.of<PowerBillController>(context).getSavePowerBill();

    // computations for balance
    // int balance = int.parse(context.read<TenantController>().state['balance']);
    int amountPaid = context.read<PaymentController>().state.amountPaid;
    int amountToPay = context.read<TenantController>().state.monthlyRent;
    // computes percentage
    double percentage = ((amountPaid) / (amountToPay)) * 100;

    // logic for tunning on or off power
    if ((percentage.isNaN == false &&
        percentage >=
            80 /*&& context.read<PowerBillController>().state < 5000*/)) {
      // Provider.of<MainController>(context, listen: true).controlPower(
      //     context.read<UserdataController>().state, percentage.toInt(),
      //     x: 1);
    } else if ((percentage.isNaN == false &&
        percentage <
            80 /* && context.read<PowerBillController>().state > 5000*/)) {
      // Provider.of<MainController>(context, listen: true).controlPower(
      //     context.read<UserdataController>().state, percentage.toInt(),
      //     x: 0);
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: BlocBuilder<PaymentController, PaymentModel>(
          builder: (context, payment) {
            return BlocBuilder<TenantController, UserModel>(
              builder: (context, user) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // dashboard header
                    const DashboardHeader(),
                    // end of dashboard header
                    const MiniDashBoard(),
                    // mini dashboard

                    // end of mini dashboard
                    // pending balances
                    const Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Text(
                        "Payment Summary",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 19),
                      ),
                    ),
                    if (payment.balance != 0)
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Card(
                          child: ListTile(
                            leading: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "${percentage.toStringAsFixed(1)} %",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                            ),
                            title: const Text(
                              "Rent Payment",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 17,
                              ),
                            ),
                            subtitle: const Text("Pay your dues"),
                            trailing: RichText(
                              text: TextSpan(
                                text: "Paid",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
                                children: [
                                  TextSpan(
                                    text:
                                        "\t UGX ${separateZerosWithCommas((payment.amountPaid + context.read<TenantController>().state.powerFee).toString())}",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: "",
                                    //  "\n${formatDate(
                                    //     DateTime.parse(
                                    //       context
                                    //           .read<TenantController>()
                                    //           .state['date'],
                                    //     ),
                                    //   )}"
                                    // : "",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (context.read<PowerBillController>().state > 0)
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Card(
                          child: ListTile(
                            leading: Icon(
                              Icons.electric_bolt_sharp,
                              color: Colors.blue.shade600,
                              size: 40,
                            ),
                            title: const Text(
                              "Electricity Payment",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            ),
                            subtitle: const Text("Please pay your dues"),
                            trailing: RichText(
                              text: TextSpan(
                                text: "Paid",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
                                children: [
                                  TextSpan(
                                    text: "\t UGX ${user.powerFee}",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: "",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (payment.balance == 0)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "No pending balance",
                            style: TextStyle(
                              fontSize: 19,
                            ),
                          ),
                        ),
                      ),
                    const Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Text(
                        "Completed Balance",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 19,
                        ),
                      ),
                    ),
                    if (payment.balance == 0)
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          child: ListTile(
                            leading: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text("$percentage%"),
                            ),
                            title: const Text(
                              "Rent Payment",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                            subtitle: const Text(
                              "Thank you for paying",
                            ),
                            trailing: const Text(
                              "UGX 0",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (user.powerFee != 0)
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          child: ListTile(
                            leading: Icon(
                              Icons.electric_bolt_sharp,
                              color: Colors.blue.shade600,
                              size: 40,
                            ),
                            title: const Text(
                              "Electricity Payment",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                            subtitle: const Text(
                              "Thank you for paying",
                            ),
                            trailing: Text(
                              "UGX ${user.powerFee}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (payment.balance != 0)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "No completed balance",
                            style:
                                TextStyles(context).getRegularStyle().copyWith(
                                      fontSize: 20,
                                    ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            );
          },
        ),
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
