import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../components/text_components.dart';
import '../../../helper/constants/constants.dart';

typedef InitCallback(bool state);

class MealStep3 extends StatefulWidget {
  final List<Map<String, dynamic>> mealsArr;
  String totalMeal;
  int selectedPlan;
  MealStep3({
    Key? key,
    required this.mealsArr,
    required this.totalMeal,
    required this.selectedPlan,
  }) : super(key: key);

  @override
  State<MealStep3> createState() => _MealStep3State();
}

class _MealStep3State extends State<MealStep3> {
  bool _isActive = false;
  int _counter = 1;
  DateTime _dateTime = DateTime.now();
  String _deliveryTime = "Morning (8am - 10am)";
  String _deliveryTime2 = "Morning (8am - 10am)";
  String _deliveryTime3 = "Morning (8am - 10am)";
  final List<String> _periods = [
    "Morning (08am - 10am)",
    "Afternoon (12pm - 01pm)",
    "Evening (04pm - 06pm)",
  ];

  @override
  void initState() {
    super.initState();
    print("MEALS DATA:: ${widget.mealsArr.toString()}");
    // _filterList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextPoppins(
          text: "Delivery schedule",
          fontSize: 24,
          align: TextAlign.start,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        TextPoppins(
          text: "What time do you want your food delivered for each day?",
          fontSize: 13,
          align: TextAlign.start,
        ),
        const SizedBox(
          height: 36.0,
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            String val = "$index$_deliveryTime";
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextPoppins(
                        text: widget.mealsArr[index]['day'],
                        fontSize: 13,
                        color: Constants.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      TextPoppins(
                        text:
                            "${widget.mealsArr[index]['quantity']} meal${_pluralize(widget.mealsArr[index]['quantity'])}",
                        fontSize: 13,
                        color: Constants.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                      ),
                      child: DropdownButton(
                        hint: TextPoppins(
                            text: index == 0
                                ? _deliveryTime
                                : index == 1
                                    ? _deliveryTime2
                                    : _deliveryTime3,
                            fontSize: 13),
                        items: _periods.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          );
                        }).toList(),
                        // value: _selectedDay,
                        onChanged: (newValue) {
                          if (index == 0) {
                            setState(() {
                              _deliveryTime = (newValue as String?)!;
                            });
                          } else if (index == 1) {
                            setState(() {
                              _deliveryTime2 = (newValue as String?)!;
                            });
                          } else {
                            setState(() {
                              _deliveryTime3 = (newValue as String?)!;
                            });
                          }
                          // setState(() {
                          //   val = "$index${(newValue as String?)}";

                          //   // _dayQuantity = quans![0].quantity;
                          //   // _selectedCity = _cities[0]['cities'][0];
                          // });
                        },
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 34,
                        isExpanded: true,
                        underline: const SizedBox(),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, i) => const Divider(),
          itemCount: widget.mealsArr.length,
        ),
        const SizedBox(
          height: 28.0,
        ),

        const SizedBox(
          height: 16.0,
        ),
        // TextPoppins(
        //   text: "Number of meals per delivery",
        //   fontSize: 16,
        // ),
        // const SizedBox(
        //   height: 4.0,
        // ),
        // SizedBox(
        //   width: double.infinity,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       TextButton(
        //         onPressed: () {
        //           if (_counter > 1) {
        //             setState(() {
        //               _counter = _counter - 1;
        //             });
        //           }
        //         },
        //         child: Container(
        //           padding: const EdgeInsets.all(6.0),
        //           decoration: BoxDecoration(
        //             border: Border.all(
        //               width: 1.0,
        //               color: Colors.black,
        //             ),
        //             borderRadius: BorderRadius.circular(5.0),
        //             color: Colors.white,
        //           ),
        //           child: const Icon(
        //             CupertinoIcons.minus,
        //             color: Colors.black,
        //           ),
        //         ),
        //         style: TextButton.styleFrom(
        //           padding: const EdgeInsets.all(0.0),
        //         ),
        //       ),
        //       const SizedBox(
        //         width: 8.0,
        //       ),
        //       Expanded(
        //         child: Container(
        //           padding: const EdgeInsets.all(6.0),
        //           decoration: BoxDecoration(
        //             border: Border.all(
        //               width: 1.0,
        //               color: Colors.black,
        //             ),
        //             borderRadius: BorderRadius.circular(5.0),
        //             color: Colors.white,
        //           ),
        //           child: Center(
        //             child: TextPoppins(
        //               text: "$_counter",
        //               fontSize: 18,
        //               fontWeight: FontWeight.bold,
        //               color: Colors.black,
        //             ),
        //           ),
        //         ),
        //       ),
        //       const SizedBox(
        //         width: 8.0,
        //       ),
        //       TextButton(
        //         onPressed: () {
        //           setState(() {
        //             _counter = _counter + 1;
        //           });
        //         },
        //         child: Container(
        //           padding: const EdgeInsets.all(6.0),
        //           decoration: BoxDecoration(
        //             border: Border.all(
        //               width: 1.0,
        //               color: Colors.black,
        //             ),
        //             borderRadius: BorderRadius.circular(5.0),
        //             color: Colors.white,
        //           ),
        //           child: const Icon(
        //             CupertinoIcons.add,
        //             color: Colors.black,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // const SizedBox(
        //   height: 64.0,
        // ),
        // Center(
        //   child: TextPoppins(
        //     text: "You will receive $_counter ${_pluralize(_counter)} a week",
        //     fontSize: 14,
        //     align: TextAlign.center,
        //   ),
        // ),
        // const SizedBox(
        //   height: 24.0,
        // ),
      ],
    );
  }

  _pluralize(int count) {
    return count > 1 ? "s" : "";
  }
}
