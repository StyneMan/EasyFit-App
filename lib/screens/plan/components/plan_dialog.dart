import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/instance_manager.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
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
                "You’re a few clicks away to staying on track with your nutrition goals. \n Select a meal plan that best suits your need.",
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
                showBarModalBottomSheet(
                  expand: false,
                  context: context,
                  topControl: ClipOval(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            16,
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
                  ),
                  backgroundColor: Colors.transparent,
                  builder: (context) => SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 21.0,
                      ),
                      children: [
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextPoppins(
                          text: "Delivery Date",
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Constants.primaryColor,
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        TextPoppins(
                          text: "Select a delivery date and explore our menu",
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              DatePicker.showDateTimePicker(
                                context,
                                showTitleActions: true,
                                theme: const DatePickerTheme(
                                  doneStyle: TextStyle(
                                    color: Constants.primaryColor,
                                  ),
                                ),
                                onChanged: (date) {
                                  print('change $date in time zone ' +
                                      date.timeZoneOffset.inHours.toString());
                                },
                                onConfirm: (date) {
                                  print('confirm $date');
                                  _controller.saveNoPlanDeliveryDate("$date");

                                  // NOw go to menu to expore meals
                                  // Future.delayed(const Duration(seconds: 1),
                                  //     () {
                                  _controller.jumpTo(2);
                                  // });
                                },
                                currentTime: DateTime.now(),
                                minTime: DateTime.now(),
                              );
                            },
                            child: TextPoppins(
                              text: "Select Date",
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
                // Future.delayed(const Duration(seconds: 1), () {
                //   DatePicker.showDateTimePicker(
                //     context,
                //     showTitleActions: true,
                //     theme: const DatePickerTheme(doneStyle: TextStyle(color: Constants.primaryColor)),
                //     onChanged: (date) {
                //       print('change $date in time zone ' +
                //           date.timeZoneOffset.inHours.toString());
                //     },
                //     onConfirm: (date) {
                //       print('confirm $date');
                //     },
                //     currentTime: DateTime(2008, 12, 31, 23, 12, 34),
                //   );
                // });
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
