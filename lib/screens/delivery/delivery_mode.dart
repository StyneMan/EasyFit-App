import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/instance_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../components/drawer/custom_drawer.dart';
import '../../components/text_components.dart';
import '../../helper/constants/constants.dart';
import '../../helper/preference/preference_manager.dart';
import '../../helper/state/state_manager.dart';
import '../payment/payment_method.dart';
import 'home_delivery.dart';

class DeliveryMode extends StatelessWidget {
  final PreferenceManager manager;
  DeliveryMode({
    Key? key,
    required this.manager,
  }) : super(key: key);

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _controller = Get.find<StateController>();

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
          text: "Delivery Method".toUpperCase(),
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
          manager: manager,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                ClipOval(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.40,
                    height: MediaQuery.of(context).size.width * 0.40,
                    padding: const EdgeInsets.all(36.0),
                    color: Constants.accentColor,
                    child: SvgPicture.asset(
                      'assets/images/carbon_delivery.svg',
                      color: Constants.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextPoppins(
                  text: 'Choose Delivery Method',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  ),
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      // cart.setDeliveryType("Pickup");
                      pushNewScreen(
                        context,
                        screen: PaymentMethod(manager: manager),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    },
                    child: TextPoppins(
                      text: 'PICKUP FROM SHOP',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      backgroundColor: Constants.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  ),
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      // cart.setDeliveryType("Door Delivery");
                      pushNewScreen(
                        context,
                        screen: HomeDelivery(
                          manager: manager,
                        ),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    },
                    child: TextPoppins(
                      text: 'HOME DELIVERY',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      backgroundColor: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
