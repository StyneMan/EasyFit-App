import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/data/personalize/personalizedata.dart';
import 'package:easyfit_app/helper/state/state_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

typedef CallbackFunc(String day, int quantity);

class AssignDialog extends StatelessWidget {
  final int index;
  final CallbackFunc onAssigned;
  final String totalMeals;
  AssignDialog({
    Key? key,
    required this.index,
    required this.totalMeals,
    required this.onAssigned,
  }) : super(key: key);

  final _dailyController = TextEditingController();
  final _controller = Get.find<StateController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 192,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          TextPoppins(
            text:
                "How many meal(s) for ${weekDays[index]}? ${int.parse(totalMeals) - int.parse(_controller.mealsLeft.value.isEmpty ? "0" : _controller.mealsLeft.value)} already assigned, ${_controller.mealsLeft.value.isEmpty ? totalMeals : _controller.mealsLeft.value} left",
            fontSize: 14,
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(0.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                gapPadding: 1.0,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                gapPadding: 1.0,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                gapPadding: 1.0,
              ),
              filled: false,
              hintText: 'Enter number',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please type password';
              }
              return null;
            },
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
            onChanged: (val) {
              print("Changed to :: $val");
            },
            onEditingComplete: () {
              print("Complete");
            },
            controller: _dailyController,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 18.0,
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                onAssigned(weekDays[index], int.parse(_dailyController.text));
                Navigator.of(context).pop();
              },
              child: TextPoppins(
                text: "Done",
                fontSize: 14,
              ),
            ),
          )
        ],
      ),
    );
  }
}
