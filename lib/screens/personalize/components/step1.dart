import 'package:easyfit_app/components/button/customcheckbutton.dart';
import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/data/personalize/personalizedata.dart';
import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:flutter/material.dart';

typedef InitCallback(bool state);

class AccountStep1 extends StatefulWidget {
  final InitCallback isAnyChecked;
  const AccountStep1({
    Key? key,
    required this.isAnyChecked,
  }) : super(key: key);

  @override
  State<AccountStep1> createState() => _AccountStep1State();
}

class _AccountStep1State extends State<AccountStep1> {
  bool _isActive = false;

  List<bool> _selections =
      List.generate((personalizeList.length), (_) => false);

  onChanged(value) {
    setState(() {
      _isActive = value;
    });
    // print("CURR:: $value");
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
          text: "Are you allergic to any product?",
          fontSize: 24,
          align: TextAlign.center,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        const SizedBox(
          height: 16.0,
        ),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          childAspectRatio: (itemWidth / itemHeight),
          children: [
            for (var i = 0; i < personalizeList.length; i++)
              Container(
                width: MediaQuery.of(context).size.width * 0.38,
                height: 100,
                child: Center(
                  child: Text(
                    personalizeList[i],
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
        // ToggleButtons(children: children, isSelected: isSelected, )
        // GridView.builder(
        //   shrinkWrap: true,
        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2,
        //     mainAxisSpacing: 16.0,
        //     crossAxisSpacing: 16.0,
        //     childAspectRatio: (itemWidth / itemHeight),
        //   ),
        //   itemBuilder: (context, i) {
        //     return CheckButton(
        //       onChanged: onChanged,
        //       title: personalizeList[i],
        //       isActive: _isActive,
        //     );
        //   },
        //   itemCount: personalizeList.length,
        // )
      ],
    );
  }
}
