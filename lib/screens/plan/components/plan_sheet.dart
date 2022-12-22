import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../../../components/text_components.dart';
import '../../../helper/constants/constants.dart';
import '../../../helper/preference/preference_manager.dart';
import '../../../helper/state/state_manager.dart';

class PlanBottomSheet extends StatelessWidget {
  final PreferenceManager manager;
  final List<Map<String, dynamic>> mealsArr;
  String totalMeal;
  final List<dynamic> selectedDays;
  int selectedPlan;
  PlanBottomSheet({
    Key? key,
    required this.manager,
    required this.mealsArr,
    required this.totalMeal,
    required this.selectedPlan,
    required this.selectedDays,
  }) : super(key: key);

  final _controller = Get.find<StateController>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8.0,
              ),
              TextPoppins(
                text: "Plan summary",
                fontSize: 21,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              TextPoppins(
                text: "Below is the summary of your plan",
                fontSize: 14,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
          color: const Color(0x14D9F0F0).withOpacity(0.6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextPoppins(
                    text: "Selected plan",
                    fontSize: 13,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  TextPoppins(
                    text: "$selectedPlan days plan",
                    color: Colors.black,
                    fontSize: 13,
                  ),
                ],
              ),
              const SizedBox(
                height: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextPoppins(
                    text: "Selected days",
                    fontSize: 13,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  Center(
                    child: SizedBox(
                      height: 21,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: selectedDays.length,
                        itemBuilder: (context, index) => TextPoppins(
                          text: "${selectedDays[index]}".substring(0, 3) +
                              "${index == (selectedDays.length - 1) ? "" : ", "}",
                          color: Colors.black,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextPoppins(
                    text: "Total meals",
                    fontSize: 13,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  TextPoppins(
                    text: totalMeal,
                    color: Colors.black,
                    fontSize: 13,
                  ),
                ],
              ),
              const SizedBox(
                height: 5.0,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     TextPoppins(
              //       text: "Amount",
              //       fontSize: 14,
              //       fontWeight: FontWeight.w600,
              //       color: Colors.black,
              //     ),
              //     const SizedBox(
              //       width: 4.0,
              //     ),
              //     Text(
              //       "${Constants.nairaSign(context).currencySymbol}80,000/4 weeks",
              //       style: const TextStyle(
              //         color: Colors.black,
              //         fontSize: 14,
              //         fontWeight: FontWeight.w600,
              //       ),
              //     )
              //   ],
              // ),
            ],
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        // Padding(
        //   padding: const EdgeInsets.all(16.0),
        //   child: ElevatedButton(
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //       Navigator.of(context).pop();
        //       Future.delayed(const Duration(milliseconds: 300), () {
        //         _controller.jumpTo(3);
        //       });
        //     },
        //     child: Container(
        //       padding: const EdgeInsets.all(10.0),
        //       width: double.infinity,
        //       child: TextPoppins(
        //         text: "Complete plan setup",
        //         fontSize: 16,
        //         align: TextAlign.center,
        //       ),
        //     ),
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Constants.primaryColor),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Future.delayed(const Duration(seconds: 1), () {
                  _controller.jumpTo(2);
                });
              },
              child: TextPoppins(
                text: "Continue to menu",
                fontSize: 16,
                align: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
