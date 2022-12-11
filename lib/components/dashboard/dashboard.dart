import 'dart:io';

import 'package:easyfit_app/helper/state/state_manager.dart';
import 'package:easyfit_app/screens/account/account.dart';
import 'package:easyfit_app/screens/home/home.dart';
import 'package:easyfit_app/screens/menu/menu.dart';
import 'package:easyfit_app/screens/network/no_internet.dart';
import 'package:easyfit_app/screens/orders/orders.dart';
import 'package:easyfit_app/screens/plan/components/plan_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:easyfit_app/helper/preference/preference_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class Dashboard extends StatefulWidget {
  final PreferenceManager manager;
  Dashboard({Key? key, required this.manager}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool _isLoggedIn = false;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // String _token = "";
  final _controller = Get.find<StateController>();

  @override
  void initState() {
    super.initState();
    if (_controller.showPlan.value) {
      Future.delayed(const Duration(seconds: 1), () {
        showDialog<String>(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            content: PlanDialog(
              manager: widget.manager,
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime pre_backpress = DateTime.now();

    return WillPopScope(
      onWillPop: () async {
        final timegap = DateTime.now().difference(pre_backpress);
        final cantExit = timegap >= const Duration(seconds: 4);
        pre_backpress = DateTime.now();
        if (cantExit) {
          Fluttertoast.showToast(
            msg: "Press again to exit",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.grey[800],
            textColor: Colors.white,
            fontSize: 16.0,
          );

          return false; // false will do nothing when back press
        } else {
          // _controller.triggerAppExit(true);
          if (Platform.isAndroid) {
            exit(0);
          } else if (Platform.isIOS) {}
          return true;
        }
      },
      child: Obx(
        () => LoadingOverlayPro(
          isLoading: _controller.isLoading.value,
          progressIndicator: Platform.isAndroid
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : const CupertinoActivityIndicator(
                  animating: true,
                ),
          backgroundColor: Colors.black54,
          child: !_controller.hasInternetAccess.value
              ? const NoInternet()
              : Scaffold(
                  key: _scaffoldKey,
                  body: PersistentTabView(
                    context,
                    screens: _buildScreens(_isLoggedIn),
                    items: _navBarsItems(),
                    controller: _controller.tabController,
                    confineInSafeArea: true,
                    handleAndroidBackButtonPress: false, // Default is true.
                    resizeToAvoidBottomInset:
                        true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
                    stateManagement: true, // Default is true.
                    hideNavigationBarWhenKeyboardShows:
                        true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
                    decoration: const NavBarDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                      colorBehindNavBar: Colors.white,
                    ),
                    popAllScreensOnTapOfSelectedTab: true,
                    popActionScreens: PopActionScreensType.all,
                    itemAnimationProperties: const ItemAnimationProperties(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.ease,
                    ),
                    screenTransitionAnimation: const ScreenTransitionAnimation(
                      animateTabTransition: true,
                      curve: Curves.ease,
                      duration: Duration(milliseconds: 200),
                    ),
                    navBarStyle: NavBarStyle
                        .style6, // Choose the nav bar style with this property.
                  ),
                ),
        ),
      ),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(
          CupertinoIcons.home,
          size: 24,
        ),
        title: "Home",
        activeColorPrimary: Constants.primaryColor,
        activeColorSecondary: Constants.primaryColor,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.hot_tub),
        title: "Orders",
        activeColorPrimary: Constants.primaryColor,
        activeColorSecondary: Constants.primaryColor,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.menu_book,
          size: 24,
        ),
        title: "Menu",
        activeColorPrimary: Constants.primaryColor,
        activeColorSecondary: Constants.primaryColor,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          CupertinoIcons.person,
          size: 24,
        ),
        title: ("Account"),
        activeColorPrimary: Constants.primaryColor,
        activeColorSecondary: Constants.primaryColor,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.grey,
      ),
    ];
  }

  List<Widget> _buildScreens(_loggedIn) {
    return [
      Home(
        manager: widget.manager,
      ),
      Orders(manager: widget.manager),
      FoodMenu(manager: widget.manager),
      Account(manager: widget.manager),
    ];
  }
}
