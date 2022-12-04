import 'package:easyfit_app/components/button/customcheckbutton.dart';
import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/data/personalize/personalizedata.dart';
import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef InitCallback(bool state);

class MealStep3 extends StatefulWidget {
  // final InitCallback isAnyChecked;
  const MealStep3({
    Key? key,
    // required this.isAnyChecked,
  }) : super(key: key);

  @override
  State<MealStep3> createState() => _MealStep3State();
}

class _MealStep3State extends State<MealStep3> {
  bool _isActive = false;
  int _counter = 1;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        TextPoppins(
          text: "How many meals?",
          fontSize: 24,
          align: TextAlign.start,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        TextPoppins(
          text: "How many meals do you want to receive per delivery?",
          fontSize: 13,
          align: TextAlign.start,
        ),
        const SizedBox(
          height: 36.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                child: TextPoppins(
                  text: "Receive thesame number of meals per delivery?",
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            CupertinoSwitch(
              value: _isActive,
              activeColor: Constants.primaryColor,
              onChanged: (val) {
                setState(() {
                  _isActive = val;
                });
              },
            ),
          ],
        ),
        const SizedBox(
          height: 32.0,
        ),
        TextPoppins(
          text: "Number of meals per delivery",
          fontSize: 16,
        ),
        const SizedBox(
          height: 4.0,
        ),
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  if (_counter > 1) {
                    setState(() {
                      _counter = _counter - 1;
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.0,
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white,
                  ),
                  child: const Icon(
                    CupertinoIcons.minus,
                    color: Colors.black,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(0.0),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.0,
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: TextPoppins(
                      text: "$_counter",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _counter = _counter + 1;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.0,
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white,
                  ),
                  child: const Icon(
                    CupertinoIcons.add,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 64.0,
        ),
        Center(
          child: TextPoppins(
            text: "You will receive $_counter ${_pluralize(_counter)} a week",
            fontSize: 14,
            align: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 24.0,
        ),
      ],
    );
  }

  _pluralize(int count) {
    return count > 1 ? "meals" : "meal";
  }
}
