import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../components/drawer/custom_drawer.dart';
import '../../components/shimmer/cart_shimmer.dart';
import '../../components/text_components.dart';
import '../../helper/constants/constants.dart';
import '../../helper/preference/preference_manager.dart';
import '../../helper/state/state_manager.dart';
import '../../model/cart/cart_model.dart';
import '../delivery/home_delivery.dart';
import 'components/cart_item.dart';
import 'components/empty_cart.dart';

class Cart extends StatefulWidget {
  final PreferenceManager manager;
  const Cart({
    Key? key,
    required this.manager,
  }) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  // PaginateRefreshedChangeListener refreshChangeListener =
  //     PaginateRefreshedChangeListener();
  bool _isLoading = true;

  final _controller = Get.find<StateController>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _user = FirebaseAuth.instance.currentUser;
  var _mStream;
  int _quantity = 1;
  var _cartItems;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });

    _mStream =
        FirebaseFirestore.instance.collection('users').doc("${_user?.uid}");
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
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
            text: "Cart".toUpperCase(),
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
        body: _controller.subTotalPrice.value == 0.0
            ? const Center(
                child: EmptyCart(),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Wrap(
                  children: [
                    StreamBuilder<DocumentSnapshot>(
                      stream: _mStream.snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CartShimmer();
                        }
                        // print("JOLOS:: ${snapshot.data?.get('cart')}");
                        // onCounted(snapshot.data?.get('cart')?.length);

                        if (!snapshot.hasData) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.wifi_off_outlined,
                                    size: 48,
                                  ),
                                  TextRoboto(
                                    text: 'No data found',
                                    fontSize: 16,
                                  )
                                ],
                              ),
                            ),
                          );
                        }

                        // final data = snapshot.requireData;
                        _cartItems = snapshot.data?.get('cart');

                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, i) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: CartItem(
                              model: CartModel.fromJson(
                                  snapshot.data?.get('cart')[i]),
                            ),
                          ),
                          itemCount: snapshot.data?.get('cart')?.length,
                          separatorBuilder: (context, i) => const Divider(
                            color: Constants.primaryColor,
                            thickness: 0.5,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Total',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '${Constants.nairaSign(context).currencySymbol}${Constants.formatMoneyFloat(_controller.subTotalPrice.value)}',
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          const Divider(),
                          const SizedBox(height: 24.0),
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6)),
                            child: Container(
                              width: double.infinity,
                              color: Constants.primaryColor,
                              child: TextButton(
                                onPressed: () {
                                  pushNewScreen(
                                    context,
                                    screen: HomeDelivery(
                                      manager: widget.manager,
                                    ),
                                    withNavBar:
                                        true, // OPTIONAL VALUE. True by default.
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  );
                                },
                                child: const Text(
                                  'Check Out',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: Constants.primaryColor,
                                  padding: const EdgeInsets.all(16.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(2),
                            ),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Constants.primaryColor,
                                    style: BorderStyle.solid,
                                    width: 1.0),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  _controller.emptyCart(
                                      _cartItems, _controller.currentUser?.uid);
                                },
                                child: const Text(
                                  'Empty cart',
                                  style: TextStyle(
                                    color: Constants.primaryColor,
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  // padding: const EdgeInsets.all(6.0),
                                  primary: Constants.primaryColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              onPressed: () {
                                _controller.tabController.jumpToTab(0);
                              },
                              child: const Text(
                                'Continue shopping',
                                style: TextStyle(color: Colors.black),
                              ),
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(16.0),
                                primary: Constants.primaryColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
