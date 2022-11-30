import 'package:easyfit_app/components/button/customcheckbutton.dart';
import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/data/personalize/personalizedata.dart';
import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:flutter/material.dart';

typedef InitCallback(bool state);

class AccountStep2 extends StatefulWidget {
  final InitCallback isAnyChecked;
  const AccountStep2({
    Key? key,
    required this.isAnyChecked,
  }) : super(key: key);

  @override
  State<AccountStep2> createState() => _AccountStep2State();
}

class _AccountStep2State extends State<AccountStep2> {
  bool _isActive = false;

  final List<bool> _selections = List.generate((goals.length), (_) => false);

  onChanged(value) {
    setState(() {
      _isActive = value;
    });
  }

  _check() {
    bool result = _selections.isNotEmpty;
    widget.isAnyChecked(result);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const double itemHeight = kToolbarHeight;
    final double itemWidth = size.width * 0.42;

    var counter = 0;

    return Column(
      children: [
        TextPoppins(
          text: "What is your goal?",
          fontSize: 24,
          align: TextAlign.center,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        const SizedBox(
          height: 24.0,
        ),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 12.0,
          crossAxisSpacing: 12.0,
          childAspectRatio: (itemWidth / itemHeight),
          children: [
            for (var i = 0; i < goals.length; i++)
              Container(
                width: MediaQuery.of(context).size.width * 0.35,
                height: 275,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        goals[i].image,
                        height: 28,
                        width: 28,
                        fit: BoxFit.contain,
                      ),
                      Text(
                        goals[i].title,
                      ),
                    ],
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
                _check();
              }),
              children: [widget.value],
            );
          }).toList(),
        ),
      ],
    );
  }
}
