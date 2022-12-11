import 'package:easyfit_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:easyfit_app/screens/home/home.dart';

class StateController extends GetxController {
  Dao? myDao;

  StateController({this.myDao});

  var isAppClosed = false;
  var isLoading = false.obs;
  var isAuthenticated = false.obs;
  var hideNavbar = false.obs;
  var showPlan = true.obs;
  var hasInternetAccess = true.obs;

  var currentUser = FirebaseAuth.instance.currentUser;
  var mealsLeft = "".obs;

  var tabController = PersistentTabController(initialIndex: 0);

  var productsData = "".obs;

  ScrollController transactionsScrollController = ScrollController();
  ScrollController messagesScrollController = ScrollController();

  var accessToken = "".obs;
  String _token = "";
  RxString dbItem = 'Awaiting data'.obs;

  @override
  void onInit() async {
    super.onInit();
    initDao();
    //Fetch user data
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString("accessToken") ?? "";
    bool _isAuthenticated = prefs.getBool("loggedIn") ?? false;

    if (_token.isNotEmpty) {}
  }

  Future<void> initDao() async {
    // instantiate Dao only if null (i.e. not supplied in constructor)
    myDao = await Dao.createAsync();
    dbItem.value = myDao!.dbValue;
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

  void setMealsLeft(var meals) {
    mealsLeft.value = meals;
  }

  void setShowPlan(bool state) {
    showPlan.value = state;
  }

  void setProductsData(String state) {
    productsData.value = state;
  }

  void jumpTo(int pos) {
    tabController.jumpToTab(pos);
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
