import 'package:easyfit_app/components/button/customcheckbutton.dart';
import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/data/personalize/personalizedata.dart';
import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:easyfit_app/helper/state/state_manager.dart';
import 'package:easyfit_app/model/mealplan/mealmodel.dart';
import 'package:easyfit_app/screens/plan/components/assign_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

typedef InitCallback(bool state);
typedef MealsCallback(
  var arr,
  var plan,
  var totalMeals,
);

class MealStep2 extends StatefulWidget {
  final InitCallback isAnyChecked;
  final MealsCallback setMealsArr;
  final int plan;
  const MealStep2({
    Key? key1,
    required this.plan,
    required this.setMealsArr,
    required this.isAnyChecked,
  }) : super(key: key1);

  @override
  State<MealStep2> createState() => _MealStep2State();
}

class _MealStep2State extends State<MealStep2> {
  bool _isActive = false, _isSunday = false;
  int _selectionCount = 0;
  int _counter = 0;
  bool _is5Days = true;
  final _controller = Get.find<StateController>();
  final _countController = TextEditingController();
  List<Map<String, dynamic>> _mealsArr = [];
  final List<bool> _selections = List.generate((weekDays.length), (_) => false);

  onChanged(value) {
    setState(() {
      _isActive = value;
    });
  }

  _check(value) {
    widget.isAnyChecked(value);
  }

  // Set set = Set();
  _pushMeal(String day, int quantity) {
    if (quantity > int.parse(_countController.text)) {
      Constants.toast("Can not exceed total meals available");
    } else {
      if (_controller.mealsLeft.value.isEmpty) {
        //First time init
        _mealsArr.add({"day": day, "quantity": quantity});
        _controller
            .setMealsLeft("${int.parse(_countController.text) - quantity}");
      } else {
        if (quantity > int.parse(_controller.mealsLeft.value)) {
          Constants.toast(
              "Insufficient slot left. ${_countController.text} meals with ${_controller.mealsLeft} slots left.");
        } else {
          //First thing is to minus from what is left previously
          _controller.setMealsLeft(
              "${int.parse(_controller.mealsLeft.value) - quantity}");

          if (_mealsArr.isEmpty) {
            Future.delayed(const Duration(seconds: 1), () {
              _mealsArr.add({"day": day, "quantity": quantity});
            });

            print("LIST EMPTY :: ${_mealsArr.toString()}");
          } else {
            for (var item in _mealsArr) {
              if (item['day'] == day) {
                debugPrint("THESAME:::::::");
                //Update/overwrite here

                continue;
              }
              Future.delayed(const Duration(seconds: 1), () {
                _mealsArr.add({"day": day, "quantity": quantity});
              });
              // _mealsArr.add({"day": day, "quantity": quantity});
              // set.add(item);
            }

            //   var map = {};
            //   map['a'] = 1;
            //   map['b'] = 2;

            //   print("MAPP:: ${map}");

            //   map[map.keys.elementAt(element)] = 3;
            //   map[map.keys.elementAt(1)] = 5;
            //   assert(map['a'] == 3);
            //   assert(map['b'] == 5);

            //   print("MAPP:: ${map}");
            //   //   // setState(() {
            //   //   //   _mealsArr[element] = {"day": day, "quantity": quantity};
            //   //   // });
            //   //   // print("THESAME DAY => UPDATE :: ${_mealsArr.toString()}");
            //   // } else {
            //   _mealsArr.add({"day": day, "quantity": quantity});
            //   print("DIFFERENT DAY :: ${_mealsArr.toString()}");
            //   //   break;
            //   // }
            // }
          }
        }
      }
    }

    Future.delayed(const Duration(seconds: 3), () {
      widget.setMealsArr(_mealsArr, widget.plan, _countController.text);
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _counter = widget.plan;
      _countController.text = "${widget.plan}";
    });
    if (widget.plan == 5) {
      setState(() {
        _is5Days = true;
      });
    } else {
      setState(() {
        _is5Days = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // _countController.text = "${widget.plan}";
  }

  _isMember(String day) {
    bool _result = false;
    int _value = 0;
    if (_mealsArr.isNotEmpty) {
      for (var item in _mealsArr) {
        if (item['day'] == day) {
          // setState(() {
          _result = true;
          _value = item['quantity'];
          // });
        } else {
          // setState(() {
          _result = false;
          _value = item['quantity'];
          // });
        }
        // Future.delayed(const Duration(seconds: 1), () {
        //   _mealsArr.add({"day": day, "quantity": quantity});
        // });
        // _mealsArr.add({"day": day, "quantity": quantity});
        // set.add(item);
      }
    }
    return [_result, _value];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    const double itemHeight = kToolbarHeight - 16;
    final double itemWidth = size.width * 0.32;

    // _countController.text = "${widget.plan}";

    return Obx(
      () => ListView(
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
            text:
                "How many meals do you want delivered to you within the period of ${widget.plan} days plan?",
            fontSize: 13,
            align: TextAlign.start,
          ),
          const SizedBox(
            height: 16.0,
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
                      if (_counter > widget.plan) {
                        setState(() {
                          _countController.text = "${_counter - 1}";
                          _counter = _counter - 1;
                        });
                        //Now refresh all data
                        _controller.setMealsLeft("");
                        _mealsArr.clear();
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
                          //Now refresh all data
                          _controller.setMealsLeft("");
                          setState(() {
                            _counter = int.parse(val);
                          });
                          _mealsArr.clear();
                        },
                        onEditingComplete: () {
                          print("Complete");
                          //Now refresh all data
                          _controller.setMealsLeft("");
                          _mealsArr.clear();
                        },
                        controller: _countController,
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
                      setState(() {
                        _countController.text = "${_counter + 1}";
                        _counter = _counter + 1;
                      });
                      _controller.setMealsLeft("");
                      _mealsArr.clear();
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
          const SizedBox(
            height: 21.0,
          ),
          TextPoppins(
            text:
                "Spread your ${_countController.text} meals across your ${widget.plan} days plan",
            fontSize: 13,
            align: TextAlign.start,
            color: Constants.primaryColor,
          ),
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          weekDays[i],
                          style: widget.plan == 5
                              ? TextStyle(
                                  fontSize: 14,
                                  color: i < 5
                                      ? Constants.primaryColor
                                      : Colors.grey,
                                )
                              : const TextStyle(
                                  fontSize: 14,
                                  color: Constants.primaryColor,
                                ),
                        ),
                        SizedBox(
                          child: widget.plan == 5 && i > 4
                              ? const SizedBox()
                              : Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: _isMember(weekDays[i])[0]
                                        ? Constants.primaryColor
                                        : Colors.transparent,
                                  ),
                                  child: TextPoppins(
                                    text: "${_isMember(weekDays[i])[1]}",
                                    fontSize: 10.0,
                                    color: Colors.white,
                                    align: TextAlign.center,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                        ),
                      ],
                    )),
                  ),
                ),
            ].asMap().entries.map((
              wid,
            ) {
              return widget.plan == 5 && wid.key > 4
                  ? ToggleButtons(
                      selectedColor: Constants.primaryColor,
                      isSelected: [_selections[wid.key]],
                      onPressed: null,
                      children: [wid.value],
                    )
                  : ToggleButtons(
                      selectedColor: Constants.primaryColor,
                      isSelected: [_selections[wid.key]],
                      onPressed: (int index) {
                        //Show mini dialog here'
                        showDialog<String>(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => AlertDialog(
                            contentPadding: const EdgeInsets.all(0.0),
                            content: AssignDialog(
                              index: wid.key,
                              totalMeals: _countController.text,
                              onAssigned: _pushMeal,
                            ),
                          ),
                        );
                      },
                      children: [wid.value],
                    );
            }).toList(),
          ),
          const SizedBox(
            height: 8.0,
          ),
          _controller.mealsLeft.value.isEmpty
              ? const SizedBox()
              : TextPoppins(
                  text: "${_controller.mealsLeft.value} meals slot left",
                  fontSize: 13),
          // Text("${_mealsArr.length}"),
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
      ),
    );
  }
}
