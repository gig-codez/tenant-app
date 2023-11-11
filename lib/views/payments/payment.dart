// ignore_for_file: use_build_context_synchronously

import 'package:nyumbayo_app/models/Payment.dart';
import 'package:nyumbayo_app/models/UserModel.dart';
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
    EdgeInsets padding = MediaQuery.of(context)
        .padding
        .copyWith(top: 10, bottom: 10, left: 10, right: 10);

    return Scaffold(
      body: BottomTopMoveAnimationView(
        animationController: _controller!,
        child: SingleChildScrollView(
          child: Column(
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
                            titleText: "Rent: UGX: ${0}",
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
                          CommonButton(
                            padding: padding,
                            buttonText: "Proceed to payment",
                            onTap: () {
                              if (electricController.text.isEmpty ||
                                  rentController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Please fill in one of these feilds"),
                                    backgroundColor: Colors.redAccent,
                                    // behavior: SnackBarBehavior.floating,
                                    duration: Duration(milliseconds: 3000),
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
                              // phoneNumberController =
                              //     TextEditingController(
                              //         ; // mtn number
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
                                    TextEditingController(); // airtel number
                              });
                            },
                            child: SizedBox(
                                width: 60,
                                height: 60,
                                child: Image.asset("assets/airtel.jpeg")))
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
                            onTap: () {},
                          )
                        ],
                      ),
                    ),
                    isActive: step3,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
