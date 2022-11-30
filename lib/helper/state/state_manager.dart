import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:easyfit_app/screens/home/home.dart';

class StateController extends GetxController {
  var isAppClosed = false;
  var isLoading = false.obs;
  var isAuthenticated = false.obs;
  var hideNavbar = false.obs;
  var hasInternetAccess = true.obs;

  var productsData = "".obs;

  ScrollController transactionsScrollController = ScrollController();
  ScrollController messagesScrollController = ScrollController();

  var accessToken = "".obs;

  String _token = "";

  @override
  void onInit() async {
    super.onInit();
    //Fetch user data
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString("accessToken") ?? "";
    bool _isAuthenticated = prefs.getBool("loggedIn") ?? false;

    if (_token.isNotEmpty) {}
  }

  Widget currentScreen = Home();

  var currentPage = "Home";
  List<String> pageKeys = [
    "Home",
    "Categories",
    "Promos",
    "Services",
    "Account"
  ];
  Map<String, GlobalKey<NavigatorState>> navigatorKeys = {
    "Home": GlobalKey<NavigatorState>(),
    "Categories": GlobalKey<NavigatorState>(),
    "Promos": GlobalKey<NavigatorState>(),
    "Services": GlobalKey<NavigatorState>(),
    "Account": GlobalKey<NavigatorState>(),
  };

  var selectedIndex = 0.obs;

  void setAccessToken(String token) {
    accessToken.value = token;
  }

  void setHasInternet(bool state) {
    hasInternetAccess.value = state;
  }

  void setProductsData(String state) {
    productsData.value = state;
  }

  void selectTab(var currPage, String tabItem, int index) {
    if (tabItem == currentPage) {
      navigatorKeys[tabItem]!.currentState?.popUntil((route) => route.isFirst);
      currentScreen = currPage;
      selectedIndex.value = index;
    } else {
      currentPage = pageKeys[index];
      selectedIndex.value = index;
      currentScreen = currPage;
    }
  }

  void setLoading(bool state) {
    isLoading.value = state;
  }

  void resetAll() {}

  @override
  void onClose() {
    super.onClose();
    transactionsScrollController.dispose();
    messagesScrollController.dispose();
  }
}
