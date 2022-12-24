import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyfit_app/model/cart/cart_model.dart';
// import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:easyfit_app/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:uuid/uuid.dart';

import '../../main.dart';
import '../constants/constants.dart';

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

  var userData = {}.obs;
  var carts = [].obs;
  var orders = [].obs;
  var menus = [].obs;
  var meals = [].obs;
  var featuredMeal = [].obs;
  var planSetup = {};

  RxDouble subTotalPrice = 0.0.obs;
  var deliveryFee = 0.obs;
  var totalAmount = 0.0.obs;
  RxInt itemQuantity = 1.obs;
  Map deliveryInfo = {};
  var advancedCartList = [].obs;
  var monCartList = [].obs;
  var tueCartList = [].obs;
  var wedCartList = [].obs;
  var thuCartList = [].obs;
  var friCartList = [].obs;
  var satCartList = [].obs;
  var sunCartList = [].obs;

  var noPlanDeliveryDate = "";

  ScrollController transactionsScrollController = ScrollController();
  ScrollController messagesScrollController = ScrollController();

  var accessToken = "".obs;
  String _token = "";
  RxString dbItem = 'Awaiting data'.obs;

  _init() async {
    // print("FROM STATE CONTROLLER ::::");
    try {
      await FirebaseFirestore.instance.collection("menus").get().then((value) {
        setMenusData(value.docs);
      });

      await FirebaseFirestore.instance
          .collection("week_meal")
          .get()
          .then((value) {
        setFeaturedMeal(value.docs);
      });

      await FirebaseFirestore.instance
          .collection("products")
          .get()
          .then((value) {
        setMealsData(value.docs);
      });

      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser?.uid)
          .get()
          .then(
            (value) => setUserData(
              value.data(),
            ),
          );
    } catch (e) {}
  }

  @override
  void onInit() async {
    super.onInit();
    initDao();

    _init();
    //Fetch user data
    // final prefs = await SharedPreferences.getInstance();
    // _token = prefs.getString("accessToken") ?? "";
    // bool _isAuthenticated = prefs.getBool("loggedIn") ?? false;

    final _user = FirebaseAuth.instance.currentUser;

    if (_user != null) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(_user.uid)
          .snapshots()
          .listen(
        (event) {
          changeCartTotalPrice(jsonEncode(event.get('cart')));
        },
      );
    }

    // if (_token.isNotEmpty) {}
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

  setCart(var value) {
    carts = value;
  }

  setUserData(var value) {
    userData.value = value;
  }

  setOrders(var value) {
    orders = value;
  }

  savePlan(var data) {
    planSetup = data;
  }

  saveNoPlanDeliveryDate(var date) {
    noPlanDeliveryDate = date;
  }

  setMenusData(var data) {
    menus.value = data;
  }

  setFeaturedMeal(var data) {
    featuredMeal.value = data;
  }

  setMealsData(var data) {
    meals.value = data;
  }

  setsubTotalPrice(var value) {
    subTotalPrice.value = value;
  }

  setDeliveryFee(int quantity) {
    deliveryFee.value = quantity * 1000;
  }

  setQuantity(var quantity) {
    itemQuantity.value = quantity;
  }

  setTotalAmount() {
    totalAmount.value = subTotalPrice.value + deliveryFee.value;
  }

  setDeliveryInfo(Map map) {
    deliveryInfo = map;
  }

  addProductToCart(userId, data, int quan) async {
    try {
      // print("DATA CHECKINSON:: ${data['name']}");
      await _isItemAlreadyAdded(data, userId).then((res) {
        if (res!) {
          Constants.toast("Item already added to cart!");
        } else {
          String itemId = const Uuid().v1();
          //Update current user's data here... uuid.v1()
          FirebaseFirestore.instance.collection("users").doc("$userId").update({
            "cart": FieldValue.arrayUnion([
              {
                "id": itemId,
                "productId": data['id'],
                "menu": data['menu'],
                "name": data['name'],
                "quantity": quan,
                "price": data['price'],
                "image": data['image'],
                "cost": data['price'] * quan,
                "addedOn": DateTime.now().microsecondsSinceEpoch,
              }
            ])
          });
          Constants.toast("Item successfully added to cart");
        }
      });

      // Now update user data here
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser?.uid)
          .get()
          .then(
            (value) => setUserData(
              value.data(),
            ),
          );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // void removeCartItem(var cartItem, userId) {
  //   FirebaseFirestore.instance.collection("users").doc("$userId").update({
  //     "cart": FieldValue.arrayRemove([cartItem])
  //   });
  // }

  // void emptyCart(var cartItems, userId) {
  //   cartItems.forEach((element) {
  //     FirebaseFirestore.instance.collection("users").doc("$userId").update({
  //       "cart": FieldValue.arrayRemove([element])
  //     });
  //   });
  // }

  void removeCartItem(CartModel cartItem, userId) {
    FirebaseFirestore.instance.collection("users").doc("$userId").update({
      "cart": FieldValue.arrayRemove([cartItem.toJson()])
    });
  }

  void emptyCart(var cartItems, userId) {
    cartItems.forEach((element) {
      FirebaseFirestore.instance.collection("users").doc("$userId").update({
        "cart": FieldValue.arrayRemove([element])
      });
    });
  }

  changeCartTotalPrice(var data) {
    subTotalPrice.value = 0.0;
    List<dynamic> _list = jsonDecode(data);
    for (var elem in _list) {
      subTotalPrice.value += elem['cost'];
    }
    deliveryFee.value = itemQuantity.value * 1000;
  }

  Future<bool?> _isItemAlreadyAdded(var data, var userId) async {
    bool _res = false;

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc("${currentUser?.uid}")
          .get()
          .then((documentSnapshot) {
        // print("DATA::DATA:: ${documentSnapshot.data()!['cart']!}");
        print("DATY::DATY: ${documentSnapshot.data()}");
        //  List<CartModel> _list = CartModel.fromJson(jsonEncode("${documentSnapshot.data()!['cart']}")).toList();
        documentSnapshot.data()!['cart'].forEach((v) {
          if ((data['id']) == v['productId']) {
            print('Added');
            _res = true;
          } else {
            print('Not Yet Added');
            _res = false;
          }
          print("VELO: ${v['price']}");
          // cart!.add(CartModel.fromJson(v));
        });
      });
    } catch (e) {
      debugPrint(e.toString());
    }

    return _res;
  }

  void decreaseQuantity(CartModel item, userId) {
    if (item.quantity == 1) {
      removeCartItem(item, userId);
    } else {
      removeCartItem(item, userId);
      item.quantity--;

      FirebaseFirestore.instance.collection("users").doc("$userId").update({
        "cart": FieldValue.arrayUnion([item.toJson()])
      });
    }
  }

  Future<dynamic> addOrder(
      var cartItems, resp, userName, email, var userId) async {
    DateTime currentPhoneDate = DateTime.now(); //DateTime
    Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //T

    await FirebaseFirestore.instance
        .collection("orders")
        .doc("${currentPhoneDate.microsecondsSinceEpoch}")
        .set({
      "id": currentPhoneDate.microsecondsSinceEpoch,
      "orderNo": resp['data']['reference'],
      "createdAt": myTimeStamp,
      "customerId": userId,
      "customerName": userName,
      "email": email,
      "paidAt": resp['data']['paid_at'],
      "deliveryFee": 1000,
      "deliveryInfo": deliveryInfo,
      "paymentMethod": resp['data']['channel'],
      "status": "Pending",
      "items": [],
      "strItems": cartItems.toString(),
    });

    return cartItems?.forEach((element) async {
      // print("Hi..>>..");
      await FirebaseFirestore.instance
          .collection("users")
          .doc("$userId")
          .update({
        "orders": FieldValue.arrayUnion([
          {
            "orderNo": resp['data']['reference'],
            "name": element['name'],
            "price": element['price'],
            "image": element['image'],
            "paidAt": resp['data']['paid_at'],
            "productId": element['productId'],
            "menu": element['menu'],
            "cost": element['cost'],
            "quantity": element['quantity'],
            "deliveryInfo": deliveryInfo,
            "paymentMethod": resp['data']['channel'],
          }
        ])
      });

      await FirebaseFirestore.instance
          .collection("products")
          .doc("${element['productId']}")
          .update({"quantity": FieldValue.increment(-element['quantity'])});

      //Add to orders collection too db
      FirebaseFirestore.instance
          .collection("orders")
          .doc("${currentPhoneDate.microsecondsSinceEpoch}")
          .update({
        "items": FieldValue.arrayUnion([
          {
            "name": element['name'],
            "price": element['price'],
            "image": element['image'],
            "productId": element['productId'],
            "menu": element['menu'],
            "cost": element['cost'],
            "quantity": element['quantity'],
          }
        ])
      });

      FirebaseFirestore.instance
          .collection("orders")
          .doc("${currentPhoneDate.microsecondsSinceEpoch}")
          .update({
        "strItems": FieldValue.arrayUnion([
          {
            "name": element['name'],
            "price": element['price'],
            "image": element['image'],
            "productId": element['productId'],
            "menu": element['menu'],
            "cost": element['cost'],
            "quantity": element['quantity'],
          }.toString()
        ])
      });
    });
  }

  void increaseQuantity(CartModel item, userId) {
    removeCartItem(item, userId);
    item.quantity++;
    FirebaseFirestore.instance.collection("users").doc("$userId").update({
      "cart": FieldValue.arrayUnion([item.toJson()])
    });
  }

  void setAccessToken(String token) {
    accessToken.value = token;
  }

  void setHasInternet(bool state) {
    hasInternetAccess.value = state;
  }

  void setMealsLeft(var meals) {
    mealsLeft.value = meals;
  }

  void setMonCarts(var meals) {
    monCartList.value.add(meals);
  }

  void setTueCarts(var meals) {
    tueCartList.value.add(meals);
  }

  void setWedCarts(var meals) {
    wedCartList.value.add(meals);
  }

  void setThuCarts(var meals) {
    thuCartList.value.add(meals);
  }

  void setFriCarts(var meals) {
    friCartList.value.add(meals);
  }

  void setSatCarts(var meals) {
    satCartList.value.add(meals);
  }

  void setSunCarts(var meals) {
    sunCartList.value.add(meals);
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
