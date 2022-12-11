import 'package:easyfit_app/components/drawer/custom_drawer.dart';
import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:easyfit_app/helper/preference/preference_manager.dart';
import 'package:easyfit_app/helper/state/state_manager.dart';
import 'package:easyfit_app/model/cart/cart_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/instance_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'components/cart_item.dart';

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
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // PaginateRefreshedChangeListener refreshChangeListener =
  //     PaginateRefreshedChangeListener();
  bool _isLoading = true;

  final _controller = Get.find<StateController>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
  }

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
      body:
          // (listMap.isNotEmpty || user != null)
          //     ? (listMap[0]['cart'] ?? user.carts).isNotEmpty
          //         ?
          SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) => CartItem(
                model: cartList[i],
                // data: listMap[0]['cart']![i],
              ),
              itemCount: cartList.length,
              separatorBuilder: (context, i) => const Divider(),
            ),
            // : const EmptyCart(),
            const SizedBox(height: 8),
            // (listMap.isNotEmpty || user.carts.isNotEmpty)
            //     ?
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
                        'Sub total',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                          '${Constants.nairaSign(context).currencySymbol} ${Constants.formatMoney(30000)}'),
                    ],
                  ),
                  const SizedBox(height: 2),
                  const Divider(),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Delivery',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                          '${Constants.nairaSign(context).currencySymbol} ${Constants.formatMoneyFloat(1200.00)}'),
                    ],
                  ),
                  const SizedBox(height: 2),
                  const Divider(),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                          '${Constants.nairaSign(context).currencySymbol} ${Constants.formatMoneyFloat(31200.00)}'),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    child: Container(
                      width: double.infinity,
                      color: Constants.primaryColor,
                      child: TextButton(
                        onPressed: () {
                          // pushNewScreen(
                          //   context,
                          //   screen: DeliveryMode(
                          //     manager: widget.manager,
                          //   ),
                          //   withNavBar:
                          //       true, // OPTIONAL VALUE. True by default.
                          //   pageTransitionAnimation:
                          //       PageTransitionAnimation
                          //           .cupertino,
                          // );
                        },
                        child: const Text(
                          'Check Out',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(16.0),
                          primary: Constants.primaryColor,
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
                          //listMap[0]['cart']![i]
                          // _cart.emptyCart(listMap[0]['cart']);
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
            // : const SizedBox(
            //     child: Center(
            //       child: CircularProgressIndicator(
            //         color: Constants.primaryColor,
            //       ),
            //     ),
            //     height: 200,
            //   ),
          ],
        ),
      ),
      // : const EmptyCart()
      // : const SizedBox(
      //     child: Center(
      //       child: CircularProgressIndicator(
      //         color: Constants.primaryColor,
      //       ),
      //     ),
      //     height: 256,
      //   ),
    );
  }
}
