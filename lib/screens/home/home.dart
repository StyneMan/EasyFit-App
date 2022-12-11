import 'package:easyfit_app/components/drawer/custom_drawer.dart';
import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:easyfit_app/helper/preference/preference_manager.dart';
import 'package:easyfit_app/screens/cart/cart.dart';
import 'package:easyfit_app/screens/home/components/banner.dart';
import 'package:easyfit_app/screens/home/components/productsection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class Home extends StatelessWidget {
  final PreferenceManager? manager;
  Home({Key? key, this.manager}) : super(key: key);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    // final _user = _controller.currentUser;
    // if (_user != null) {
    //   var arr = _user.displayName?.split(' ');
    //   setState(() {
    //     _fname = arr![0];
    //   });
    // }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        foregroundColor: Constants.primaryColor,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: SvgPicture.asset(
                "assets/images/user_icon_mini.svg",
                width: 24,
                height: 24,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              width: 16.0,
            ),
            RichText(
              text: TextSpan(
                text: "Hi, ",
                style: const TextStyle(
                  fontSize: 18,
                  color: Constants.primaryColor,
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  TextSpan(
                    text: (_user?.displayName ?? "").split(' ')[0],
                    style: const TextStyle(
                      color: Constants.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              pushNewScreen(
                context,
                withNavBar: true,
                screen: Cart(manager: manager!),
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
          manager: manager!,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.275,
            child: const BannerWidget(),
          ),
          const SizedBox(
            height: 21.0,
          ),
          ProductSection(
            manager: manager!,
          )
        ],
      ),
    );
  }
}
