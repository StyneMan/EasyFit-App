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
  bool _isActive = false, _showTextField = false;
  final _othersController = TextEditingController();
  List<bool> _selections =
      List.generate((personalizeList.length), (_) => false);

  onChanged(value) {
    setState(() {
      _isActive = value;
    });
    widget.isAnyChecked(value);
    // print("CURR:: $value");
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
                _check(_selections[widget.key]);
                if (index == (personalizeList.length - 1) ||
                    _selections[personalizeList.length - 1]) {
                  setState(() {
                    _showTextField = true;
                  });
                }
              }),
              children: [widget.value],
            );
          }).toList(),
        ),
        const SizedBox(
          height: 8.0,
        ),
        _showTextField
            ? TextFormField(
                controller: _othersController,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  filled: false,
                  hintText: 'Please specify',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field must not be empty!';
                  }
                  return null;
                },
              )
            : const SizedBox()
      ],
    );
  }
}
