import 'package:easyfit_app/helper/preference/preference_manager.dart';
import 'package:easyfit_app/screens/account/account.dart';
import 'package:easyfit_app/screens/home/home.dart';
import 'package:easyfit_app/screens/menu/menu.dart';
import 'package:easyfit_app/screens/orders/orders.dart';
import 'package:flutter/material.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatefulWidget {
  TabNavigator({
    required this.navigatorKey,
    required this.tabItem,
    required this.manager,
  });

  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;
  final PreferenceManager manager;

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    navigatorKey = widget.navigatorKey;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Home(
      manager: widget.manager,
    );
    if (widget.tabItem == "Home")
      child = Home(
        manager: widget.manager,
      );
    else if (widget.tabItem == "Orders")
      child = Orders(
        manager: widget.manager,
      );
    else if (widget.tabItem == "Menu")
      child = FoodMenu(
        manager: widget.manager,
      );
    else if (widget.tabItem == "Account")
      child = Account(
        manager: widget.manager,
      );

    return Navigator(
      key: widget.navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
