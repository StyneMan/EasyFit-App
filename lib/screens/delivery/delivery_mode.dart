import 'package:easyfit_app/model/mealplan/mealmodel.dart';
import 'package:easyfit_app/screens/payment/payment_method.dart';
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
          text: "Delivery Info".toUpperCase(),
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
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        children: [
          Center(
            child: ClipOval(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.36,
                height: MediaQuery.of(context).size.width * 0.36,
                padding: const EdgeInsets.all(36.0),
                color: Constants.accentColor,
                child: SvgPicture.asset(
                  'assets/images/carbon_delivery.svg',
                  color: Constants.primaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 21.0),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              final _addressController = TextEditingController();
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextPoppins(
                        text:
                            "${Plan.fromJson(_controller.planSetup).meals?.elementAt(i).day}",
                        fontSize: 14,
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      TextRoboto(
                        text:
                            "${Plan.fromJson(_controller.planSetup).meals?.elementAt(i).quantity} meals",
                        fontSize: 14,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextFormField(
                      controller: _addressController,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        filled: false,
                        hintText: 'Delivery Address',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: Plan.fromJson(_controller.planSetup).meals!.length,
          ),
          const SizedBox(
            height: 16.0,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _payment(context);
              },
              child: TextPoppins(text: "Continue to payment", fontSize: 14),
            ),
          )
        ],
      ),
    );
  }

  _payment(context) {
    _controller.setLoading(true);
    Future.delayed(const Duration(seconds: 3), () {
      _controller.setLoading(false);
      pushNewScreen(
        context,
        screen: PaymentMethod(
          manager: manager,
        ),
        withNavBar: true, // OPTIONAL VALUE. True by default.
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
      );
    });
  }
}
