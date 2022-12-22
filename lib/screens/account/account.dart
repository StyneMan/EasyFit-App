import 'package:firebase_auth/firebase_auth.dart';
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
import '../cart/cart.dart';
import 'edit_profile.dart';

class Account extends StatelessWidget {
  final PreferenceManager manager;
  Account({Key? key, required this.manager}) : super(key: key);

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _controller = Get.find<StateController>();

  final _user = FirebaseAuth.instance.currentUser;

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
                // Navigator.of(context).pop();
                _controller.jumpTo(0);
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
          text: "PROFILE".toUpperCase(),
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Constants.secondaryColor,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              pushNewScreen(
                context,
                withNavBar: true,
                screen: Cart(manager: manager),
              );
            },
            icon: Stack(
              children: [
                const Icon(
                  CupertinoIcons.cart,
                  color: Constants.secondaryColor,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: ClipOval(
                    child: Container(
                      width: 14.0,
                      height: 14.0,
                      decoration: BoxDecoration(
                        color: Constants.secondaryColor,
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      child: TextPoppins(
                        text: "2",
                        align: TextAlign.center,
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
        padding: const EdgeInsets.all(16.0),
        children: [
          Center(
            child: SvgPicture.asset(
              "assets/images/user_icon.svg",
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width * 0.36,
              height: MediaQuery.of(context).size.width * 0.36,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Center(
            child: TextPoppins(
              text: _user?.displayName ?? "",
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 21,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextPoppins(text: "Email", fontSize: 14),
                TextPoppins(text: "${_user?.email}", fontSize: 16),
                const SizedBox(
                  height: 10,
                ),
                TextPoppins(text: "Phone", fontSize: 14),
                TextPoppins(text: "${_user?.phoneNumber}", fontSize: 16),
                const SizedBox(
                  height: 10,
                ),
                TextPoppins(text: "Address", fontSize: 14),
                TextPoppins(
                  text: "Plot 2 road 4, Goodnews Estate, Gwagwalada",
                  fontSize: 16,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextPoppins(text: "Landmark", fontSize: 14),
                TextPoppins(text: "Sky Mall", fontSize: 16),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 24,
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.0,
                        color: Constants.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: TextButton(
                      onPressed: () {
                        pushNewScreen(
                          context,
                          withNavBar: true,
                          screen: EditProfile(manager: manager),
                        );
                      },
                      child: TextPoppins(
                        text: "Edit Profile",
                        fontSize: 16,
                        color: Constants.primaryColor,
                      ),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
