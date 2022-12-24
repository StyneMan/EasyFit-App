import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:easyfit_app/helper/preference/preference_manager.dart';
import 'package:easyfit_app/helper/state/state_manager.dart';
import 'package:easyfit_app/model/mealplan/mealmodel.dart';
import 'package:easyfit_app/screens/cart/plan_cart.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class Assigner extends StatefulWidget {
  final PreferenceManager manager;
  var selectedDays;
  var product;
  Assigner({
    Key? key,
    required this.product,
    required this.manager,
    required this.selectedDays,
  }) : super(key: key);

  @override
  State<Assigner> createState() => _AssignerState();
}

class _AssignerState extends State<Assigner> {
  String _selectedDay = "Select meal day";
  String _errorMessage = "";
  int _dayQuantity = 1;

  final _controller = Get.find<StateController>();

  _pluralizer(int num) {
    return num > 1 ? "s" : "";
  }

  _mealAdder(var day) {
    switch (day) {
      case "Thursday":
        if (_controller.thuCartList.value.length < _dayQuantity) {
          _controller.setThuCarts(widget.product);
          Future.delayed(const Duration(seconds: 1), () {
            pushNewScreen(
              context,
              withNavBar: true,
              screen: PlanCart(manager: widget.manager),
            );
          });
        } else {
          Constants.toast("$_selectedDay meal slot filled. ");
          setState(() {
            _errorMessage =
                "$_selectedDay meal slot filled. $_dayQuantity meal${_pluralizer(_dayQuantity)} for ${_selectedDay.toLowerCase()}";
          });
        }
        break;
      case "Monday":
        if (_controller.monCartList.value.length < _dayQuantity) {
          _controller.setMonCarts(widget.product);
          Future.delayed(const Duration(seconds: 1), () {
            pushNewScreen(
              context,
              withNavBar: true,
              screen: PlanCart(manager: widget.manager),
            );
          });
        } else {
          Constants.toast("$_selectedDay meal slot filled. ");
          setState(() {
            _errorMessage =
                "$_selectedDay meal slot filled. $_dayQuantity meal${_pluralizer(_dayQuantity)} for ${_selectedDay.toLowerCase()}";
          });
        }
        break;
      case "Tuesday":
        if (_controller.tueCartList.value.length < _dayQuantity) {
          _controller.setTueCarts(widget.product);
          Future.delayed(const Duration(seconds: 1), () {
            pushNewScreen(
              context,
              withNavBar: true,
              screen: PlanCart(manager: widget.manager),
            );
          });
        } else {
          Constants.toast("$_selectedDay meal slot filled. ");
          setState(() {
            _errorMessage =
                "$_selectedDay meal slot filled. $_dayQuantity meal${_pluralizer(_dayQuantity)} for ${_selectedDay.toLowerCase()}";
          });
        }
        break;
      case "Wednesday":
        if (_controller.wedCartList.value.length < _dayQuantity) {
          _controller.setWedCarts(widget.product);
          Future.delayed(const Duration(seconds: 1), () {
            pushNewScreen(
              context,
              withNavBar: true,
              screen: PlanCart(manager: widget.manager),
            );
          });
        } else {
          Constants.toast("$_selectedDay meal slot filled. ");
          setState(() {
            _errorMessage =
                "$_selectedDay meal slot filled. $_dayQuantity meal${_pluralizer(_dayQuantity)} for ${_selectedDay.toLowerCase()}";
          });
        }
        break;
      case "Friday":
        if (_controller.friCartList.value.length < _dayQuantity) {
          _controller.setFriCarts(widget.product);
          Future.delayed(const Duration(seconds: 1), () {
            pushNewScreen(
              context,
              withNavBar: true,
              screen: PlanCart(manager: widget.manager),
            );
          });
        } else {
          Constants.toast("$_selectedDay meal slot filled. ");
          setState(() {
            _errorMessage =
                "$_selectedDay meal slot filled. $_dayQuantity meal${_pluralizer(_dayQuantity)} for ${_selectedDay.toLowerCase()}";
          });
        }
        break;
      case "Saturday":
        if (_controller.satCartList.value.length < _dayQuantity) {
          _controller.setSatCarts(widget.product);
          Future.delayed(const Duration(seconds: 1), () {
            pushNewScreen(
              context,
              withNavBar: true,
              screen: PlanCart(manager: widget.manager),
            );
          });
        } else {
          Constants.toast("$_selectedDay meal slot filled. ");
          setState(() {
            _errorMessage =
                "$_selectedDay meal slot filled. $_dayQuantity meal${_pluralizer(_dayQuantity)} for ${_selectedDay.toLowerCase()}";
          });
        }
        break;
      case "Sunday":
        if (_controller.sunCartList.value.length < _dayQuantity) {
          _controller.setSunCarts(widget.product);
          Future.delayed(const Duration(seconds: 1), () {
            pushNewScreen(
              context,
              withNavBar: true,
              screen: PlanCart(manager: widget.manager),
            );
          });
        } else {
          Constants.toast("$_selectedDay meal slot filled. ");
          setState(() {
            _errorMessage =
                "$_selectedDay meal slot filled. $_dayQuantity meal${_pluralizer(_dayQuantity)} for ${_selectedDay.toLowerCase()}";
          });
        }

        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _selectedDay == "Select meal day"
            ? const SizedBox()
            : TextPoppins(
                text: "Total meals for $_selectedDay is $_dayQuantity",
                fontSize: 14,
              ),
        const SizedBox(
          height: 4.0,
        ),
        TextPoppins(
          text: _errorMessage,
          fontSize: 12,
          color: Colors.red,
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
          ),
          child: DropdownButton(
            hint: Text(
              _selectedDay,
            ),
            items: Plan.fromJson(_controller.planSetup).meals?.map((e) {
              return DropdownMenuItem(
                value: e.day,
                child: Text(e.day),
              );
            }).toList(),
            // value: _selectedDay,
            onChanged: (newValue) {
              var quans = Plan.fromJson(_controller.planSetup)
                  .meals
                  ?.where((element) => element.day == newValue as String?)
                  .toList();
              print("HJS JS :: ${quans?.length}");
              setState(() {
                _selectedDay = (newValue as String?)!;
                _dayQuantity = quans![0].quantity;
                // _selectedCity = _cities[0]['cities'][0];
              });
              switch (_selectedDay) {
                case "Mon":
                  if (_controller.monCartList.value.length <
                      quans![0].quantity) {
                    //Good add more
                    setState(() {
                      _errorMessage = "";
                    });
                  } else {
                    setState(() {
                      _errorMessage =
                          "$_selectedDay is filled. Required ${quans[0].quantity} meal${_pluralizer(quans[0].quantity)}";
                    });
                  }
                  break;
                case "Tue":
                  if (_controller.tueCartList.value.length <
                      quans![0].quantity) {
                    //Good add more
                    setState(() {
                      _errorMessage = "";
                    });
                  } else {
                    setState(() {
                      _errorMessage =
                          "$_selectedDay is filled. Required ${quans[0].quantity} meal${_pluralizer(quans[0].quantity)}";
                    });
                  }
                  break;
                default:
              }
            },
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 34,
            isExpanded: true,
            underline: const SizedBox(),
          ),
        ),
        const SizedBox(height: 16.0),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _selectedDay == "Select meal day"
                ? null
                : () {
                    _mealAdder(_selectedDay);
                  },
            child: TextPoppins(
                text: _selectedDay == "Select meal day"
                    ? "Continue"
                    : "Add meal to $_selectedDay",
                fontSize: 14),
          ),
        ),
      ],
    );
  }
}
