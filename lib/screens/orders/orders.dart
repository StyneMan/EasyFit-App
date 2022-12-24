import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../components/drawer/custom_drawer.dart';
import '../../components/shimmer/cart_shimmer.dart';
import '../../components/text_components.dart';
import '../../helper/constants/constants.dart';
import '../../helper/preference/preference_manager.dart';
import '../../helper/state/state_manager.dart';
import '../../model/orders/ordersmodel.dart';
import '../cart/cart.dart';
import 'components/orders_row.dart';

class Orders extends StatefulWidget {
  final PreferenceManager manager;
  Orders({Key? key, required this.manager}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isLoading = true;

  final _controller = Get.find<StateController>();
  final _user = FirebaseAuth.instance.currentUser;
  var _mStream;
  int _quantity = 1;
  var _orderItems;

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
          text: "My Orders".toUpperCase(),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          children: [
            StreamBuilder<DocumentSnapshot>(
              stream: _mStream.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
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
                            size: 72,
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
                _orderItems = snapshot.data?.get('orders');

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, i) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: OrdersRow(
                      order:
                          OrdersModel.fromJson(snapshot.data?.get('orders')[i]),
                      manager: widget.manager,
                    ),
                    // CartItem(
                    //   model: CartModel.fromJson(snapshot.data?.get('orders')[i]),
                    // ),
                  ),
                  itemCount: snapshot.data?.get('orders')?.length,
                  separatorBuilder: (context, i) => const Divider(
                    color: Constants.primaryColor,
                    thickness: 0.5,
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),

      // ListView.builder(
      //   padding: const EdgeInsets.all(0.0),
      //   itemBuilder: (context, i) => OrdersRow(
      //     order: ordersList[i],
      //     manager: widget.manager,
      //   ),
      //   itemCount: ordersList.length,
      // ),
    );
  }
}
