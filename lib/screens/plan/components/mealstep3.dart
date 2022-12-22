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
                    width: 4.0,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RadioListTile(
                          value: "Morning (08am - 10am)",
                          groupValue: val,
                          contentPadding: const EdgeInsets.all(2.0),
                          title: TextPoppins(
                            text: "Morning (08am - 10am)",
                            fontSize: 13,
                            color: Constants.primaryColor,
                          ),
                          onChanged: (value) {
                            setState(() {
                              _deliveryTime = value.toString();
                            });
                          },
                        ),
                        RadioListTile(
                          value: "Afternoon (12pm - 01pm)",
                          groupValue: _deliveryTime,
                          contentPadding: const EdgeInsets.all(2.0),
                          onChanged: (value) {
                            setState(() {
                              _deliveryTime = value.toString();
                            });
                          },
                          title: TextPoppins(
                            text: "Afternoon (12pm - 01pm)",
                            fontSize: 13,
                            color: Constants.primaryColor,
                          ),
                        ),
                        RadioListTile(
                          value: "Evening (04pm - 06pm)",
                          groupValue: _deliveryTime,
                          contentPadding: const EdgeInsets.all(2.0),
                          onChanged: (value) {
                            setState(() {
                              _deliveryTime = value.toString();
                            });
                          },
                          title: TextPoppins(
                            text: "Evening (04pm - 06pm)",
                            fontSize: 13,
                            color: Constants.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  )
                  // TimePickerSpinner(
                  //   is24HourMode: false,
                  //   normalTextStyle:
                  //       const TextStyle(fontSize: 16, color: Colors.grey),
                  //   highlightedTextStyle: const TextStyle(
                  //     fontSize: 16,
                  //     color: Constants.primaryColor,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  //   spacing: 5,
                  //   itemHeight: 20,
                  //   isForce2Digits: true,
                  //   onTimeChange: (time) {
                  //     setState(() {
                  //       _dateTime = time;
                  //     });
                  //   },
                  // )
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                child: TextPoppins(
                  text: "Receive the same number of meals per delivery?",
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
