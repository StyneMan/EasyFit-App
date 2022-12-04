import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:easyfit_app/helper/preference/preference_manager.dart';
import 'package:easyfit_app/helper/state/state_manager.dart';
import 'package:easyfit_app/screens/plan/mealplan.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:page_transition/page_transition.dart';

class PlanDialog extends StatelessWidget {
  final PreferenceManager manager;
  PlanDialog({
    Key? key,
    required this.manager,
  }) : super(key: key);

  final _controller = Get.find<StateController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset("assets/images/weight_gain.png"),
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextPoppins(
            text: "Hey, Arinola",
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Constants.primaryColor,
          ),
          const SizedBox(
            height: 16.0,
          ),
          TextPoppins(
            text:
                "You're one step away from enjoying the delicious, healthy and convenient meals. Select a meal plan that best suits your need.",
            fontSize: 14,
            align: TextAlign.center,
          ),
          const SizedBox(
            height: 28,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: ElevatedButton(
              onPressed: () {
                _controller.setShowPlan(false);
                Navigator.of(context).pushReplacement(
                  PageTransition(
                    type: PageTransitionType.size,
                    alignment: Alignment.bottomCenter,
                    child: MealPlan(
                      manager: manager,
                    ),
                  ),
                );
              },
              child: TextPoppins(
                text: "Select plan",
                fontSize: 14,
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(12.0),
              ),
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: TextPoppins(
                text: "Continue",
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
