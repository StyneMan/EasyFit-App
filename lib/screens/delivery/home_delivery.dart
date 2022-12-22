import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/instance_manager.dart';

import '../../components/drawer/custom_drawer.dart';
import '../../components/text_components.dart';
import '../../forms/delivery/home_delivery_form.dart';
import '../../helper/constants/constants.dart';
import '../../helper/preference/preference_manager.dart';
import '../../helper/state/state_manager.dart';

class HomeDelivery extends StatefulWidget {
  final PreferenceManager manager;
  const HomeDelivery({
    Key? key,
    required this.manager,
  }) : super(key: key);

  @override
  State<HomeDelivery> createState() => _HomeDeliveryState();
}

class _HomeDeliveryState extends State<HomeDelivery> {
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
          text: "Delivery Information".toUpperCase(),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            TextPoppins(
              text: 'Enter Delivery Details',
              fontSize: 18,
              align: TextAlign.center,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            const SizedBox(height: 16.0),
            TextPoppins(
              text:
                  'Please enter the correct delivery information and possible landmarks on the area of the form.',
              fontSize: 11,
              align: TextAlign.center,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            const SizedBox(height: 21.0),
            const Expanded(child: HomeDeliveryForm()),
          ],
        ),
      ),
    );
  }
}
