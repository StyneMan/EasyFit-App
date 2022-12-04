import 'package:easyfit_app/components/button/customcheckbutton.dart';
import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/data/personalize/personalizedata.dart';
import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:flutter/material.dart';

typedef InitCallback(bool state);

class MealStep2 extends StatefulWidget {
  final InitCallback isAnyChecked;
  const MealStep2({
    Key? key,
    required this.isAnyChecked,
  }) : super(key: key);

  @override
  State<MealStep2> createState() => _MealStep2State();
}

class _MealStep2State extends State<MealStep2> {
  bool _isActive = false, _isSunday = false;
  int _selectionCount = 0;
  final List<bool> _selections = List.generate((weekDays.length), (_) => false);

  onChanged(value) {
    setState(() {
      _isActive = value;
    });
  }

  _check(value) {
    widget.isAnyChecked(value);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const double itemHeight = kToolbarHeight;
    final double itemWidth = size.width * 0.32;

    var counter = 0;

    return ListView(
      shrinkWrap: true,
      children: [
        TextPoppins(
          text: "Customize your plan",
          fontSize: 24,
          align: TextAlign.start,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        TextPoppins(
          text: "How many days a week do you want your food delivered to you?",
          fontSize: 13,
          align: TextAlign.start,
        ),
        const SizedBox(
          height: 16.0,
        ),
        SizedBox(
          height: 100,
          child: ListWheelScrollView(
            itemExtent: 32,
            children: [
              for (var i = 0; i < 6; i++)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextPoppins(
                        text: "${i + 1}",
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      TextPoppins(
                        text: i == 0 ? "day a week" : "days a week",
                        fontSize: 12,
                      )
                    ],
                  ),
                )
            ],
            useMagnifier: true,
            magnification: 1.5,
            onSelectedItemChanged: (value) {},
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 3,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: (itemWidth / itemHeight),
          children: [
            for (var i = 0; i < weekDays.length; i++)
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                height: 275,
                child: Center(
                  child: Text(
                    weekDays[i],
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
              )
          ].asMap().entries.map((
            widget,
          ) {
            final index = ++counter - 1;

            return ToggleButtons(
              selectedColor: Constants.primaryColor,
              isSelected: [_selections[widget.key]],
              onPressed: (int index) => setState(() {
                _selections[widget.key] = !_selections[widget.key];
                _check(_selections[widget.key]);
                var count = _selections
                    .where((element) => _selections[widget.key] == true);

                // print("COUNTER:: ${count.length}");

                setState(() {
                  _selectionCount = count.length;
                });
              }),
              children: [widget.value],
            );
          }).toList(),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: ToggleButtons(
                selectedColor: Constants.primaryColor,
                isSelected: [_isSunday],
                onPressed: (int index) => setState(() {
                  _isSunday = !_isSunday;
                  _check(_isSunday);
                }),
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: 18.5,
                    child: const Center(
                      child: Text(
                        "Sunday",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 18.0,
        ),
        _selectionCount < 1
            ? const SizedBox()
            : Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Constants.primaryColor,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                  color: const Color(0x14D9F0F0).withOpacity(0.6),
                ),
                child: TextPoppins(
                  text:
                      "You will receive your food 2 days a week on Mondays and Wednesdays",
                  fontSize: 13,
                  align: TextAlign.center,
                  color: Constants.primaryColor,
                ),
              ),
      ],
    );
  }
}
