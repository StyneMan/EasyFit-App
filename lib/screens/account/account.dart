import 'package:easyfit_app/components/drawer/custom_drawer.dart';
import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:easyfit_app/helper/preference/preference_manager.dart';
import 'package:easyfit_app/screens/account/edit_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class Account extends StatelessWidget {
  final PreferenceManager manager;
  Account({Key? key, required this.manager}) : super(key: key);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
              text: "Arinola Odunuga",
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
                TextPoppins(text: "demouser@email.com", fontSize: 16),
                const SizedBox(
                  height: 10,
                ),
                TextPoppins(text: "Phone", fontSize: 14),
                TextPoppins(text: "0901234567895", fontSize: 16),
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
                TextPoppins(text: "Date of Birth", fontSize: 14),
                TextPoppins(text: "27/06/2022", fontSize: 16),
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
