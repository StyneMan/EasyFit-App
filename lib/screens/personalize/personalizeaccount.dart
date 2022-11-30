import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:easyfit_app/screens/personalize/components/step1.dart';
import 'package:easyfit_app/screens/personalize/components/step2.dart';
import 'package:flutter/material.dart';

class PersonalizeAccount extends StatefulWidget {
  const PersonalizeAccount({Key? key}) : super(key: key);

  @override
  State<PersonalizeAccount> createState() => _PersonalizeAccountState();
}

class _PersonalizeAccountState extends State<PersonalizeAccount> {
  int currentStep = 0;

  bool _isstep1AnyActive = false;
  bool _isstep2AnyActive = false;

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
        child: Form(
          child: Stepper(
            type: StepperType.horizontal,
            currentStep: currentStep,
            controlsBuilder: (context, details) {
              return Column(
                children: [
                  const SizedBox(
                    height: 36.0,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Constants.primaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: currentStep == 0
                          ? _isstep1AnyActive
                              ? () {}
                              : null
                          : _isstep2AnyActive
                              ? () {}
                              : null,
                      child: TextPoppins(
                        text: "Continue",
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Constants.primaryColor,
                        onPrimary: Colors.white,
                        padding: const EdgeInsets.all(4.0),
                        elevation: 0.2,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {},
                      child: TextPoppins(
                        text: "Skip",
                        fontSize: 14,
                      ),
                      style: TextButton.styleFrom(
                        primary: Constants.primaryColor,
                        padding: const EdgeInsets.all(4.0),
                      ),
                    ),
                  )
                ],
              );
            },
            onStepCancel: () => currentStep == 0
                ? null
                : setState(() {
                    currentStep -= 1;
                  }),
            onStepContinue: () {
              bool isLastStep = (currentStep == getSteps().length - 1);
              if (isLastStep) {
                //Do something with this information
              } else {
                setState(() {
                  currentStep += 1;
                });
              }
            },
            onStepTapped: (step) => setState(() {
              currentStep = step;
            }),
            steps: getSteps(),
          ),
        ),
      ),
    );
  }

  List<Step> getSteps() {
    return <Step>[
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const Text(""),
        content: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: AccountStep1(isAnyChecked: _step1Check),
        ),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const Text(""),
        content: Padding(
          padding: EdgeInsets.all(10.0),
          child: AccountStep2(
            isAnyChecked: _step2Check,
          ),
        ),
      ),
    ];
  }
}
