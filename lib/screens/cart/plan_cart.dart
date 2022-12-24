import 'package:easyfit_app/components/drawer/custom_drawer.dart';
import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:easyfit_app/helper/preference/preference_manager.dart';
import 'package:easyfit_app/helper/state/state_manager.dart';
import 'package:easyfit_app/model/mealplan/mealmodel.dart';
import 'package:easyfit_app/screens/cart/components/plan_cart_item.dart';
import 'package:easyfit_app/screens/delivery/delivery_mode.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/instance_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class PlanCart extends StatefulWidget {
  final PreferenceManager manager;
  const PlanCart({
    Key? key,
    required this.manager,
  }) : super(key: key);

  @override
  State<PlanCart> createState() => _PlanCartState();
}

class _PlanCartState extends State<PlanCart> {
  final _controller = Get.find<StateController>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _user = FirebaseAuth.instance.currentUser;

  var monTotal = 0,
      tueTotal = 0,
      wedTotal = 0,
      thuTotal = 0,
      friTotal = 0,
      satTotal = 0,
      sunTotal = 0;
  var discount = 0.0;
  var grandTotal = 0.0;

  _sumTotal(var day) {
    switch (day) {
      case "Monday":
        (_controller.monCartList.value).forEach((element) {
          monTotal += element["price"] as int;
        });
        break;
      case "Tuesday":
        (_controller.tueCartList.value).forEach((element) {
          tueTotal += element["price"] as int;
        });
        break;
      case "Wednesday":
        (_controller.wedCartList.value).forEach((element) {
          wedTotal += element["price"] as int;
        });
        break;
      case "Thursday":
        (_controller.thuCartList.value).forEach((element) {
          thuTotal += element["price"] as int;
        });
        break;
      case "Friday":
        (_controller.friCartList.value).forEach((element) {
          friTotal += element["price"] as int;
        });
        break;
      case "Saturday":
        (_controller.satCartList.value).forEach((element) {
          satTotal += element["price"] as int;
        });
        break;
      case "Sunday":
        (_controller.sunCartList.value).forEach((element) {
          sunTotal += element["price"] as int;
        });
        break;
      default:
    }
  }

  @override
  void initState() {
    super.initState();
    _computeTotal();
    // Future.delayed(const Duration(seconds: 1), () {
    _computeDiscount();
    // });
  }

  _returnTotal(var day) {
    var res;
    switch (day) {
      case "Monday":
        // setState(() {
        res = monTotal;
        // });
        break;
      case "Tuesday":
        res = tueTotal;
        break;
      case "Wednesday":
        res = wedTotal;
        break;
      case "Thursday":
        res = thuTotal;
        break;
      case "Friday":
        res = friTotal;
        break;
      case "Saturday":
        res = satTotal;
        break;
      case "Sunday":
        res = sunTotal;
        break;
      default:
    }
    return res;
  }

  List _returnList(var day) {
    var res;
    switch (day) {
      case 'Monday':
        // setState(() {
        res = _controller.monCartList.value;
        // });
        break;
      case 'Tuesday':
        // setState(() {
        res = _controller.tueCartList.value;
        // });
        break;
      case 'Wednesday':
        // setState(() {
        res = _controller.wedCartList.value;
        // });
        break;
      case 'Thursday':
        // setState(() {
        res = _controller.thuCartList.value;
        // });
        break;
      case 'Friday':
        // setState(() {
        res = _controller.friCartList.value;
        // });
        break;
      case 'Saturday':
        // setState(() {
        res = _controller.satCartList.value;
        // });
        break;
      case 'Sunday':
        // setState(() {
        res = _controller.sunCartList.value;
        // });
        break;
      default:
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        foregroundColor: Constants.primaryColor,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 4.0,
            ),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                CupertinoIcons.arrow_left_circle_fill,
                color: Colors.black,
                size: 28,
              ),
            ),
          ],
        ),
        title: TextPoppins(
          text: "Cart".toUpperCase(),
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Constants.secondaryColor,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (!_scaffoldKey.currentState!.isEndDrawerOpen) {
                _scaffoldKey.currentState!.openEndDrawer();
              }
            },
            icon: SvgPicture.asset(
              'assets/images/menu_icon.svg',
              color: Constants.secondaryColor,
            ),
          ),
        ],
      ),
      endDrawer: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: CustomDrawer(
          manager: widget.manager,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: TextPoppins(
                      text:
                          "${Plan.fromJson(_controller.planSetup).meals?.elementAt(index).day}",
                      fontSize: 18,
                      color: Constants.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 2.0,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i) {
                      // _sumTotal(
                      //     "${Plan.fromJson(_controller.planSetup).meals?.elementAt(index).day}");
                      // print(
                      //     "PORCIE:: ${_returnList("${Plan.fromJson(_controller.planSetup).meals?.elementAt(index).day}").elementAt(i)["price"]}");

                      return PlanCartItem(
                        day:
                            "${Plan.fromJson(_controller.planSetup).meals?.elementAt(index).day}",
                        data: _returnList(
                                "${Plan.fromJson(_controller.planSetup).meals?.elementAt(index).day}")
                            .elementAt(i),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: _returnList(
                            "${Plan.fromJson(_controller.planSetup).meals?.elementAt(index).day}")
                        .length,
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextPoppins(
                        text: "Number of meals",
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      TextPoppins(
                        text:
                            "${_returnList("${Plan.fromJson(_controller.planSetup).meals?.elementAt(index).day}").length}",
                        fontSize: 13,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextPoppins(
                        text: "Amount",
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      // Text("${monTotal}"),
                      Text(
                        '${Constants.nairaSign(context).currencySymbol}${Constants.formatMoney(_returnTotal("${Plan.fromJson(_controller.planSetup).meals?.elementAt(index).day}"))}',
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  )
                ],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 24.0,
            ),
            itemCount: Plan.fromJson(_controller.planSetup).meals!.length,
          ),
          const SizedBox(height: 18),
          const Divider(),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextPoppins(
                text: "Maximum number of meals",
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              TextPoppins(
                text: Plan.fromJson(_controller.planSetup).totalMeals,
                fontSize: 14,
              ),
            ],
          ),
          const SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextPoppins(
                text: "Total number of meals",
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              TextPoppins(
                text:
                    "${_controller.monCartList.value.length + _controller.tueCartList.value.length + _controller.wedCartList.value.length + _controller.thuCartList.value.length + _controller.friCartList.value.length + _controller.satCartList.value.length + _controller.sunCartList.value.length}",
                fontSize: 14,
              ),
            ],
          ),
          const SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextPoppins(
                text: "% Discount",
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              Text(
                '${Constants.nairaSign(context).currencySymbol}${Constants.formatMoneyFloat(discount)} ${int.parse(Plan.fromJson(_controller.planSetup).totalMeals) < 11 && int.parse(Plan.fromJson(_controller.planSetup).totalMeals) >= 5 ? "(2.5%)" : int.parse(Plan.fromJson(_controller.planSetup).totalMeals) >= 11 && int.parse(Plan.fromJson(_controller.planSetup).totalMeals) < 20 ? "(5%)" : int.parse(Plan.fromJson(_controller.planSetup).totalMeals) > 19 ? "(10%)" : ""}',
              ),
            ],
          ),
          const SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextPoppins(
                text: "Total amount",
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              Text(
                '${Constants.nairaSign(context).currencySymbol}${Constants.formatMoney(monTotal + tueTotal + wedTotal + thuTotal + friTotal + satTotal + sunTotal)}',
              ),
            ],
          ),
          const SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextPoppins(
                text: "Grand total",
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              Text(
                '${Constants.nairaSign(context).currencySymbol}${Constants.formatMoneyFloat(grandTotal)}',
              ),
            ],
          ),
          const SizedBox(
            height: 21.0,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                pushNewScreen(
                  context,
                  screen: DeliveryMode(
                    manager: widget.manager,
                  ),
                  withNavBar: true, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              child: TextPoppins(text: "Continue", fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  _computeDiscount() {
    int totalMeals = int.parse(Plan.fromJson(_controller.planSetup).totalMeals);
    int totalPrice = monTotal +
        tueTotal +
        wedTotal +
        thuTotal +
        friTotal +
        satTotal +
        sunTotal;

    if (totalMeals >= 5 && totalMeals < 11) {
      discount = totalPrice * 0.025;
      grandTotal = totalPrice - discount;
    } else if (totalMeals >= 11 && totalMeals < 19) {
      discount = totalPrice * 0.050;
      grandTotal = totalPrice - discount;
    } else if (totalMeals >= 20) {
      discount = totalPrice * 0.1;
      grandTotal = totalPrice - discount;
    }
  }

  _computeTotal() {
    _controller.monCartList.value.forEach((element) {
      monTotal += element['price'] as int;
    });

    _controller.tueCartList.value.forEach((element) {
      tueTotal += element['price'] as int;
    });

    _controller.wedCartList.value.forEach((element) {
      wedTotal += element['price'] as int;
    });

    _controller.thuCartList.value.forEach((element) {
      thuTotal += element['price'] as int;
    });

    _controller.friCartList.value.forEach((element) {
      friTotal += element['price'] as int;
    });

    _controller.satCartList.value.forEach((element) {
      satTotal += element['price'] as int;
    });

    _controller.sunCartList.value.forEach((element) {
      sunTotal += element['price'] as int;
    });
  }
}
