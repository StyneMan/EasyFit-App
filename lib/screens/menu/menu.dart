import 'package:easyfit_app/components/drawer/custom_drawer.dart';
import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:easyfit_app/helper/preference/preference_manager.dart';
import 'package:easyfit_app/screens/cart/cart.dart';
import 'package:easyfit_app/screens/menu/components/listcomponent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class FoodMenu extends StatefulWidget {
  final PreferenceManager manager;
  FoodMenu({Key? key, required this.manager}) : super(key: key);

  @override
  State<FoodMenu> createState() => _FoodMenuState();
}

class _FoodMenuState extends State<FoodMenu> {
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
              width: 16.0,
            ),
            ClipOval(
              child: SvgPicture.asset(
                "assets/images/user_icon_mini.svg",
                width: 24,
                height: 24,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              width: 4.0,
            ),
          ],
        ),
        title: TextPoppins(
          text: "Menu".toUpperCase(),
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
                screen: Cart(manager: widget.manager),
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
          manager: widget.manager,
        ),
      ),
      body: ListView(
        children: [
          ListComponent(
            manager: widget.manager,
          ),
        ],
      ),
    );
  }
}
