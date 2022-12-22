import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:page_transition/page_transition.dart';

import '../../../components/text_components.dart';
import '../../../helper/constants/constants.dart';
import '../../../helper/preference/preference_manager.dart';
import '../../../helper/state/state_manager.dart';
import '../mealplan.dart';

class PlanDialog extends StatefulWidget {
  final PreferenceManager manager;
  PlanDialog({
    Key? key,
    required this.manager,
  }) : super(key: key);

  @override
  State<PlanDialog> createState() => _PlanDialogState();
}

class _PlanDialogState extends State<PlanDialog> {
  final _controller = Get.find<StateController>();

  String _fname = '';

  _init() {
    final _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      var arr = _user.displayName?.split(' ');
      setState(() {
        _fname = arr![0];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 4.0,
          ),
          TextPoppins(
            text: "Hey, $_fname",
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
                      manager: widget.manager,
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
