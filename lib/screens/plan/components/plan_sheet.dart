import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:easyfit_app/helper/preference/preference_manager.dart';
import 'package:easyfit_app/helper/state/state_manager.dart';
import 'package:easyfit_app/screens/account/account.dart';
import 'package:easyfit_app/screens/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class PlanBottomSheet extends StatelessWidget {
  final PreferenceManager manager;
  PlanBottomSheet({
    Key? key,
    required this.manager,
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
                text: "Customize your plan",
                fontSize: 21,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              TextPoppins(
                text:
                    "Below is a summary of your food plan if you would like to make any changes, you can go back.",
                fontSize: 14,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16.0,
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
                    text: "Delivery Frequency",
                    fontSize: 13,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  TextPoppins(
                    text: "twice a week",
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
                    text: "Meals Per Delivery",
                    fontSize: 13,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  TextPoppins(
                    text: "4",
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
                    text: "Delivery Days",
                    fontSize: 13,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  TextPoppins(
                    text: "Mon & Wed",
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
                    text: "Amount",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  TextPoppins(
                    text:
                        "${Constants.nairaSign(context).currencySymbol}80,000/4 weeks",
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Future.delayed(const Duration(seconds: 1), () {
                _controller.jumpTo(3);
              });
            },
            child: Container(
              padding: const EdgeInsets.all(10.0),
              width: double.infinity,
              child: TextPoppins(
                text: "Complete plan setup",
                fontSize: 16,
                align: TextAlign.center,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                text: "Take a look at our menu",
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
