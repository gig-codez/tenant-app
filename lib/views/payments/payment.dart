// ignore_for_file: use_build_context_synchronously

import 'package:nyumbayo_app/models/Payment.dart';
import 'package:nyumbayo_app/models/UserModel.dart';

import '../../controllers/PaymentController.dart';
import '/controllers/PowerBillController.dart';
import '/exports/exports.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    BlocProvider.of<UserAccountController>(context).getUserData();

    // BlocProvider.of<TenantController>(context)
    //     .fetchTenants(context.read<UserAccountController>().state);
    super.initState();
    _controller = AnimationController(
      vsync: this,
      value: 0,
      duration: const Duration(milliseconds: 900),
    );
    _controller?.forward();
  }

  int _currentStep = 0;
  final rentController = TextEditingController();
  final electricController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  String errorText1 = '';
  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  //stream error
  StepState assignState({required int index}) {
    if (_currentStep == index) {
      return StepState.editing;
    } else if (_currentStep > index) {
      return StepState.complete;
    } else {
      return StepState.indexed;
    }
  }

  bool step1 = true;
  bool step2 = false;
  bool step3 = false;
  int mode = 0;
  int airtel = 0;
  int _index = 0;
  final _amountPayKey = GlobalKey<FormState>();
  final phoneFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserAccountController>(context).getUserData();
    String userId = context.read<UserAccountController>().state.userId;
    BlocProvider.of<PaymentController>(context).fetchLastPayment(userId);
    BlocProvider.of<TenantController>(context).fetchTenantData(userId);
    EdgeInsets padding = MediaQuery.of(context)
        .padding
        .copyWith(top: 10, bottom: 10, left: 10, right: 10);

    context.watch<MainController>().fetchPowerConsumed();

    return Scaffold(
      body: BottomTopMoveAnimationView(
        animationController: _controller!,
        child: SingleChildScrollView(
          child: BlocBuilder<PaymentController, PaymentModel>(
            builder: (context, payment) {
              return BlocBuilder<TenantController, UserModel>(
                builder: (context, user) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CommonAppbarView(
                        titleText: "Payment Process",
                        titlePadding: const EdgeInsets.only(top: 20, left: 20),
                        iconData: Icons.arrow_back_ios,
                        onBackClick: () => Navigator.pop(context),
                        topPadding: 30,
                      ),
                      Stepper(
                        currentStep: _currentStep,
                        onStepCancel: step3 == true
                            ? null
                            : () {
                                setState(() {
                                  _index = 0;
                                  _currentStep > 0
                                      ? _currentStep -= 1
                                      : _currentStep = 0;
                                });
                              },
                        onStepContinue: step3 == true
                            ? null
                            : () {
                                setState(() {
                                  _currentStep < 2
                                      ? _currentStep += 1
                                      : _currentStep = 0;
                                  if (_currentStep == 1) {
                                    step1 = false;
                                    step3 = false;
                                    step2 = true;
                                  } else if (_currentStep == 2) {
                                    step3 = true;
                                    step1 = false;
                                    step2 = false;
                                  } else if (_currentStep == 0) {
                                    step1 = true;
                                    step3 = false;
                                    step2 = false;
                                  }
                                });
                              },
                        steps: [
                          Step(
                            state: assignState(index: _index),
                            title: const Text('Amount To Pay'),
                            content: Form(
                              key: _amountPayKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  CommonTextField(
                                    padding: padding,
                                    enableBorder: true,
                                    hintText: "e.g UGX 100,000",
                                    controller: rentController,
                                    titleText: "Rent: UGX: ${payment.balance}",
                                    validate: (valid) {
                                      setState(() {
                                        errorText1 =
                                            "The rent amount field is required";
                                      });
                                      return null;
                                    },
                                    // validate: (p) => p!.isEmpty ? "Rent amount is required" : null,
                                    icon: Icons.attach_money_outlined,
                                    keyboardType: TextInputType.number,
                                  ),
                                  CommonTextField(
                                    padding: padding,
                                    enableBorder: true,
                                    controller: electricController,
                                    hintText: "e.g 8,000",
                                    titleText:
                                        "Electricity: UGX:${context.read<PowerBillController>().state}",
                                    validate: (valid) {
                                      setState(() {
                                        errorText1 =
                                            "Electricity amount is required";
                                      });
                                      return null;
                                    },
                                    icon: Icons.attach_money_outlined,
                                    keyboardType: TextInputType.number,
                                  ),
                                  CommonButton(
                                    padding: padding,
                                    buttonText: "Proceed to payment",
                                    onTap: () {
                                      if (electricController.text.isEmpty ||
                                          rentController.text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                "Please fill in one of these feilds"),
                                            backgroundColor: Colors.redAccent,
                                            // behavior: SnackBarBehavior.floating,
                                            duration:
                                                Duration(milliseconds: 3000),
                                          ),
                                        );
                                      } else {
                                        setState(() {
                                          _currentStep += 1;
                                          step1 = true;
                                          step3 = false;
                                          step2 = false;
                                        });
                                      }
                                    },
                                  )
                                ],
                              ),
                            ),
                            isActive: step1,
                          ),
                          Step(
                            state: assignState(index: 1),
                            title: const Text('Select payment option'),
                            content: Row(
                              children: [
                                RadioMenuButton(
                                  value: mode,
                                  groupValue: 1,
                                  onChanged: (v) {
                                    setState(() {
                                      mode = 1;
                                      phoneNumberController =
                                          TextEditingController(
                                              text: user.phone); // mtn number
                                    });
                                  },
                                  child: SizedBox(
                                      width: 60,
                                      height: 60,
                                      child: Image.asset("assets/mtn.jpeg")),
                                ),
                                RadioMenuButton(
                                    value: mode,
                                    groupValue: 0,
                                    onChanged: (v) {
                                      setState(() {
                                        mode = 0;
                                        phoneNumberController =
                                            TextEditingController(
                                                text: user
                                                    .phone); // airtel number
                                      });
                                    },
                                    child: SizedBox(
                                        width: 60,
                                        height: 60,
                                        child:
                                            Image.asset("assets/airtel.jpeg")))
                              ],
                            ),
                            isActive: step2,
                          ),
                          Step(
                            state: assignState(index: 2),
                            title: const Text('Paying with this number '),
                            content: Form(
                              key: phoneFormKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  CommonTextField(
                                    padding: padding,
                                    titleText: "Phone Number",
                                    keyboardType: TextInputType.phone,
                                    hintText: "e.g 07xxxxxxx",
                                    enableBorder: true,
                                    icon: Icons.phone,
                                    contentPadding: const EdgeInsets.only(
                                      left: 26,
                                      right: 26,
                                      top: 90,
                                      bottom: 0,
                                    ),
                                    maxLength: 10,
                                    controller: phoneNumberController,
                                  ),
                                  CommonButton(
                                    buttonText: "Make Payment",
                                    onTap: () {
                                      // if (phoneNumberController.text.isEmpty == false) {
                                      //   if (context
                                      //               .read<TenantController>()
                                      //               .state['contact'] ==
                                      //           phoneNumberController.text ||
                                      //       context
                                      //               .read<TenantController>()
                                      //               .state['acontact'] ==
                                      //           phoneNumberController.text) {
                                      //     //  show payment loader
                                      //     showProgressLoader(context);

                                      //     FirebaseFirestore.instance
                                      //         .collection("tenants")
                                      //         .doc(context
                                      //             .read<UserdataController>()
                                      //             .state)
                                      //         .update({
                                      //       "amountPaid": rentController.text.isEmpty
                                      //           ? context
                                      //               .read<TenantController>()
                                      //               .state['amountPaid']
                                      //           : (int.parse(context
                                      //                       .read<TenantController>()
                                      //                       .state['amountPaid']) +
                                      //                   int.parse(rentController.text))
                                      //               .toString(),
                                      //       "balance": (int.parse(context
                                      //                   .read<TenantController>()
                                      //                   .state['balance']) -
                                      //               int.parse(rentController.text))
                                      //           .toString(),
                                      //       "power_fee": electricController.text.isEmpty
                                      //           ? context
                                      //               .read<TenantController>()
                                      //               .state['power_fee']
                                      //           : (int.parse(context
                                      //                       .read<TenantController>()
                                      //                       .state['power_fee']) -
                                      //                   int.parse(
                                      //                       electricController.text))
                                      //               .toString(),
                                      //     }).then((event) {
                                      //       Routes.pop(context);
                                      //       showDialog(
                                      //           context: context,
                                      //           builder: (context) {
                                      //             return AlertDialog(
                                      //               title:
                                      //                   const Text("Confirm payment"),
                                      //               content: TextFormField(
                                      //                 maxLength: 4,
                                      //                 keyboardType:
                                      //                     TextInputType.number,
                                      //                 textInputAction:
                                      //                     TextInputAction.done,
                                      //                 controller:
                                      //                     TextEditingController(),
                                      //                 decoration: const InputDecoration(
                                      //                     hintText: "####",
                                      //                     labelText: "Enter your pin",
                                      //                     labelStyle:
                                      //                         TextStyle(fontSize: 17)),
                                      //               ),
                                      //               actions: [
                                      //                 TextButton(
                                      //                   onPressed: () {
                                      //                     // record payment
                                      //                     Payments.makePayments(
                                      //                       context
                                      //                           .read<
                                      //                               UserdataController>()
                                      //                           .state,
                                      //                       Payment(
                                      //                         status: "",
                                      //                         paymentMode: mode == 0
                                      //                             ? "Airtel"
                                      //                             : "MTN",
                                      //                         amount: rentController
                                      //                                 .text.isEmpty
                                      //                             ? context
                                      //                                     .read<
                                      //                                         TenantController>()
                                      //                                     .state[
                                      //                                 'amountPaid']
                                      //                             : (int.parse(context
                                      //                                             .read<
                                      //                                                 TenantController>()
                                      //                                             .state[
                                      //                                         'amountPaid']) +
                                      //                                     int.parse(
                                      //                                         rentController
                                      //                                             .text))
                                      //                                 .toString(),
                                      //                         balance: context
                                      //                             .read<
                                      //                                 TenantController>()
                                      //                             .state['balance'],
                                      //                         property: context
                                      //                             .read<
                                      //                                 TenantController>()
                                      //                             .state['property'],
                                      //                         date: DateTime.now()
                                      //                             .toString(),
                                      //                         tenantName: context
                                      //                             .read<
                                      //                                 TenantController>()
                                      //                             .state['name'],
                                      //                         electricityBill:
                                      //                             "${context.read<MainController>().computeBill(context.read<MainController>().powerConsumed)}",
                                      //                       ),
                                      //                     ).then((x) {
                                      //                       Routes.push(
                                      //                           const Dashboard(),
                                      //                           context);

                                      //                       // save payment details
                                      //                       showMessage(
                                      //                           context: context,
                                      //                           msg:
                                      //                               "Payment made successfully",
                                      //                           type: 'success');
                                      //                       // trigger notification
                                      //                       sendNotification(
                                      //                         title: "Payment",
                                      //                         body:
                                      //                             "Payment made successfully",
                                      //                       );
                                      //                     });
                                      //                   },
                                      //                   child: Text(
                                      //                     "Confirm",
                                      //                     style: TextStyle(
                                      //                         color: Theme.of(context)
                                      //                             .primaryColor),
                                      //                   ),
                                      //                 ),
                                      //                 TextButton(
                                      //                   onPressed: () =>
                                      //                       Routes.pop(context),
                                      //                   child: const Text(
                                      //                     "Cancel",
                                      //                     style: TextStyle(
                                      //                         color: Colors.red),
                                      //                   ),
                                      //                 )
                                      //               ],
                                      //             );
                                      //           });

                                      //       // navigate to dashboard
                                      //     });
                                      //   } else {
                                      //     ScaffoldMessenger.of(context).showSnackBar(
                                      //       SnackBar(
                                      //         content: Text(
                                      //           "Phone number does not match",
                                      //           style: TextStyles(context)
                                      //               .getRegularStyle(),
                                      //         ),
                                      //         backgroundColor: Colors.redAccent,
                                      //         // behavior: SnackBarBehavior.floating,
                                      //         duration:
                                      //             const Duration(milliseconds: 1900),
                                      //       ),
                                      //     );
                                      //   }
                                      // } else {
                                      //   ScaffoldMessenger.of(context).showSnackBar(
                                      //     SnackBar(
                                      //       content: Text(
                                      //         "Phone number required",
                                      //         style:
                                      //             TextStyles(context).getRegularStyle(),
                                      //       ),
                                      //       backgroundColor: Colors.redAccent,
                                      //       // behavior: SnackBarBehavior.floating,
                                      //       duration:
                                      //           const Duration(milliseconds: 1900),
                                      //     ),
                                      //   );
                                      // }
                                    },
                                  )
                                ],
                              ),
                            ),
                            isActive: step3,
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
