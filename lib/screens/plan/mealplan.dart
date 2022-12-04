import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:easyfit_app/helper/preference/preference_manager.dart';
import 'package:easyfit_app/helper/state/state_manager.dart';
import 'package:easyfit_app/screens/plan/components/mealstep1.dart';
import 'package:easyfit_app/screens/plan/components/plan_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:page_transition/page_transition.dart';

import 'components/mealstep2.dart';
import 'components/mealstep3.dart';

class MealPlan extends StatefulWidget {
  final PreferenceManager manager;
  const MealPlan({
    Key? key,
    required this.manager,
  }) : super(key: key);

  @override
  State<MealPlan> createState() => _MealPlanState();
}

class _MealPlanState extends State<MealPlan> {
  int _currentStep = 0;

  bool _isstep1AnyActive = false;

  bool _isstep2AnyActive = false;

  final _controller = Get.find<StateController>();

  PreferenceManager? _manager;

  _step1Check(bool value) {
    setState(() {
      _isstep1AnyActive = value;
    });
  }

  _step2Check(bool value) {
    setState(() {
      _isstep2AnyActive = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      CupertinoIcons.arrow_left_circle_fill,
                      color: Colors.black,
                      size: 36,
                    ),
                  ),
                  TextPoppins(
                    text: "MEAL PLAN",
                    fontSize: 21,
                    color: Colors.black,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    width: 36,
                    color: Colors.transparent,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Form(
                child: Stepper(
                  type: StepperType.horizontal,
                  currentStep: _currentStep,
                  controlsBuilder: (context, details) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 36.0,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          child: ElevatedButton(
                            onPressed: _currentStep == 0
                                ? _isstep1AnyActive
                                    ? () {
                                        setState(() {
                                          _currentStep = _currentStep + 1;
                                        });
                                      }
                                    : null
                                : _currentStep == 1
                                    ? _isstep2AnyActive
                                        ? () {
                                            setState(() {
                                              _currentStep = _currentStep + 1;
                                            });
                                          }
                                        : null
                                    : () {
                                        showBarModalBottomSheet(
                                          expand: false,
                                          context: context,
                                          topControl: ClipOval(
                                            child: Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  20,
                                                ),
                                              ),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.close,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                          ),
                                          backgroundColor: Colors.transparent,
                                          builder: (context) => SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.625,
                                            child: PlanBottomSheet(
                                              manager: widget.manager,
                                            ),
                                          ),
                                        );
                                        // showBottomSheet(context: context, builder: builder)
                                      },
                            child: TextPoppins(
                              text: "Continue",
                              fontSize: 14,
                              color: Colors.white,
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Constants.primaryColor,
                              onPrimary: Colors.white,
                              padding: const EdgeInsets.all(12.0),
                              elevation: 0.2,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                      ],
                    );
                  },
                  onStepCancel: () => _currentStep == 0
                      ? null
                      : setState(() {
                          _currentStep -= 1;
                        }),
                  onStepContinue: () {
                    bool isLastStep = (_currentStep == getSteps().length - 1);
                    if (isLastStep) {
                      //Do something with this information
                    } else {
                      setState(() {
                        _currentStep += 1;
                      });
                    }
                  },
                  onStepTapped: (step) => setState(() {
                    _currentStep = step;
                  }),
                  steps: getSteps(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Step> getSteps() {
    return <Step>[
      Step(
        state: _currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: _currentStep >= 0,
        title: const Text(""),
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: MealStep1(isAnyChecked: _step1Check),
        ),
      ),
      Step(
        state: _currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: _currentStep >= 1,
        title: const Text(""),
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: MealStep2(
            isAnyChecked: _step2Check,
          ),
        ),
      ),
      Step(
        state: _currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: _currentStep >= 2,
        title: const Text(""),
        content: const Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: MealStep3(),
        ),
      ),
    ];
  }
}
