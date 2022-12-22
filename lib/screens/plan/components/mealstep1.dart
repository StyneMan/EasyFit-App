import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../components/text_components.dart';
import '../../../data/personalize/personalizedata.dart';
import '../../../helper/constants/constants.dart';

typedef InitCallback(int plan);

class MealStep1 extends StatefulWidget {
  final InitCallback setPlan;
  const MealStep1({
    Key? key,
    required this.setPlan,
  }) : super(key: key);

  @override
  State<MealStep1> createState() => _MealStep1State();
}

class _MealStep1State extends State<MealStep1> {
  final _planController = TextEditingController();
  // int _selectionCount = 0;
  final List<bool> _selections = List.generate((weekDays.length), (_) => false);

  @override
  void initState() {
    super.initState();
    setState(() {
      _planController.text = "1";
    });
  }

  _setPlan(value) {
    widget.setPlan(value);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const double itemHeight = kToolbarHeight - 10;
    final double itemWidth = size.width * 0.42;

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
          text: "Select the meal plan that is best for you",
          fontSize: 13,
          align: TextAlign.start,
        ),
        const SizedBox(
          height: 18.0,
        ),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(0.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.0,
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                ),
                child: TextButton(
                  onPressed: () {
                    if (int.parse(_planController.text) > 1) {
                      setState(() {
                        _planController.text =
                            "${int.parse(_planController.text) - 1}";
                      });
                      _setPlan(int.parse(_planController.text));
                    }
                  },
                  child: const Icon(
                    CupertinoIcons.minus,
                    color: Colors.black,
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0.0),
                  ),
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
                    child: TextFormField(
                      decoration: const InputDecoration(
                        isDense: true,
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
                          borderSide: BorderSide.none,
                          gapPadding: 1.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          borderSide: BorderSide.none,
                          gapPadding: 1.0,
                        ),
                        filled: false,
                        hintText: 'Type here',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please type days';
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
                        //Now refresh all data
                        // _controller.setMealsLeft("");
                        setState(() {
                          _planController.text = (val);
                        });
                        _setPlan(int.parse(val));
                      },
                      onEditingComplete: () {
                        print("Complete");
                      },
                      controller: _planController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Container(
                padding: const EdgeInsets.all(0.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.0,
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                ),
                child: TextButton(
                  onPressed: () {
                    if (int.parse(_planController.text) < 7) {
                      setState(() {
                        _planController.text =
                            "${int.parse(_planController.text) + 1}";
                      });
                      _setPlan(int.parse(_planController.text));
                    }
                  },
                  child: const Icon(
                    CupertinoIcons.add,
                    color: Colors.black,
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Expanded(
        //       child: TextButton(
        //         onPressed: () {
        //           setState(() {
        //             _is5Days = true;
        //             _setPlan(5);
        //           });
        //         },
        //         child: Card(
        //           elevation: _is5Days ? 1.0 : 0.0,
        //           color: _is5Days ? Constants.primaryColor : Colors.grey,
        //           child: Container(
        //             padding: const EdgeInsets.symmetric(
        //               horizontal: 8.0,
        //               vertical: 12.0,
        //             ),
        //             child: Center(
        //               child: TextPoppins(
        //                 text: "5 days plan",
        //                 color: _is5Days ? Colors.white : Colors.black,
        //                 fontSize: 14,
        //               ),
        //             ),
        //           ),
        //         ),
        //         style: TextButton.styleFrom(padding: const EdgeInsets.all(0.0)),
        //       ),
        //     ),
        //     const SizedBox(
        //       width: 16.0,
        //     ),
        //     Expanded(
        //       child: TextButton(
        //         onPressed: () {
        //           setState(() {
        //             _is5Days = false;
        //             _setPlan(7);
        //           });
        //         },
        //         child: Card(
        //           elevation: !_is5Days ? 1.0 : 0.0,
        //           color: !_is5Days ? Constants.primaryColor : Colors.grey,
        //           child: Container(
        //             padding: const EdgeInsets.symmetric(
        //               horizontal: 8.0,
        //               vertical: 12.0,
        //             ),
        //             child: Center(
        //               child: TextPoppins(
        //                 text: "7 days plan",
        //                 color: !_is5Days ? Colors.white : Colors.black,
        //                 fontSize: 14,
        //               ),
        //             ),
        //           ),
        //         ),
        //         style: TextButton.styleFrom(padding: const EdgeInsets.all(0.0)),
        //       ),
        //     ),
        //   ],
        // ),
        const SizedBox(
          height: 10.0,
        ),
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: (itemWidth / itemHeight),
          children: [
            for (var i = 0; i < weekDays.length; i++)
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.40,
                height: 286,
                child: Center(
                  child: Text(weekDays[i],
                      style:
                          // _is5Days
                          //     ?
                          TextStyle(
                        fontSize: 14,
                        color: i < int.parse(_planController.text)
                            ? Constants.primaryColor
                            : Colors.grey,
                      )
                      // : const TextStyle(
                      //     fontSize: 14,
                      //     color: Constants.primaryColor,
                      //   ),
                      ),
                ),
              )
          ].asMap().entries.map((
            widget,
          ) {
            // final index = ++counter - 1;

            return widget.key < int.parse(_planController.text)
                ? ToggleButtons(
                    selectedColor: Constants.primaryColor,
                    isSelected: [_selections[widget.key]],
                    onPressed: null,
                    children: [widget.value],
                  )
                : ToggleButtons(
                    selectedColor: Constants.primaryColor,
                    isSelected: [_selections[widget.key]],
                    onPressed: (int index) {},
                    children: [widget.value],
                  );
          }).toList(),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
          width: double.infinity,
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
                "You have opted to receive meals on a ${_planController.text} days plan",
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
