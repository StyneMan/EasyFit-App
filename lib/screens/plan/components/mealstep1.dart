import 'package:easyfit_app/components/button/customcheckbutton.dart';
import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/data/personalize/personalizedata.dart';
import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:flutter/material.dart';

typedef InitCallback(bool state);

class MealStep1 extends StatefulWidget {
  final InitCallback isAnyChecked;
  const MealStep1({
    Key? key,
    required this.isAnyChecked,
  }) : super(key: key);

  @override
  State<MealStep1> createState() => _MealStep1State();
}

class _MealStep1State extends State<MealStep1> {
  bool _isActive = false;
  int _selectionCount = 0;
  List<dynamic> _selectedMonths = [];
  List<bool> _selections = List.generate((months.length), (_) => false);

  onChanged(value) {
    setState(() {
      _isActive = value;
    });
    widget.isAnyChecked(value);
  }

  _check(value) {
    widget.isAnyChecked(value);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const double itemHeight = kToolbarHeight;
    final double itemWidth = size.width * 0.42;

    var counter = 0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextPoppins(
          text: "Customize your plan",
          fontSize: 24,
          align: TextAlign.start,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        TextPoppins(
          text:
              "How many months a year do you want your food delivered to you?",
          fontSize: 13,
          align: TextAlign.start,
        ),
        const SizedBox(
          height: 28.0,
        ),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: (itemWidth / itemHeight),
          children: [
            for (var i = 0; i < months.length; i++)
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                height: 108,
                child: Center(
                  child: Text(
                    months[i],
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

                print("COUNTER:: ${count.length}");

                setState(() {
                  _selectionCount = count.length;
                  // _selectedMonths = months.where((element) => _selections[widget.key] == true);
                });
              }),
              children: [widget.value],
            );
          }).toList(),
        ),
        const SizedBox(
          height: 21.0,
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
                  color: Color(0x14D9F0F0).withOpacity(0.6),
                ),
                child: TextPoppins(
                  text:
                      "You will receive your meal ${pluralizer(3)} in a year in the months of June, July and August",
                  fontSize: 12,
                  align: TextAlign.start,
                  color: Constants.primaryColor,
                ),
              ),
      ],
    );
  }

  pluralizer(int count) {
    return count > 1 ? "$count months" : "$count month";
  }
}
