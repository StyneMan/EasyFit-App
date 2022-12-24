import 'package:cached_network_image/cached_network_image.dart';
import 'package:easyfit_app/components/shimmer/banner_shimmer.dart';
import 'package:easyfit_app/model/mealplan/mealmodel.dart';
import 'package:easyfit_app/screens/plan/components/assign_dialog.dart';
import 'package:easyfit_app/screens/product/components/assigner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

import '../../components/drawer/custom_drawer.dart';
import '../../components/text_components.dart';
import '../../helper/constants/constants.dart';
import '../../helper/preference/preference_manager.dart';
import '../../helper/state/state_manager.dart';
import '../cart/cart.dart';

class ProductDetail extends StatefulWidget {
  final PreferenceManager manager;
  var data;
  ProductDetail({
    Key? key,
    required this.manager,
    required this.data,
  }) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _controller = Get.find<StateController>();

  final _user = FirebaseAuth.instance.currentUser;

  int _count = 1;

  _add(context) {
    if (_user != null) {
      _controller.setQuantity(_controller.itemQuantity.value + 1);
    }
  }

  _minus(context) {
    if (_user != null) {
      if (_controller.itemQuantity.value > 1) {
        _controller.setQuantity(_controller.itemQuantity.value - 1);
      }
    } else {
      // CartNavigator.gotoCart(context: context, manager: manager);
    }
  }

  _addToCart(context) {
    if (_user != null) {
      if (_controller.planSetup.isEmpty) {
        _controller.addProductToCart(
            _user?.uid, widget.data, _controller.itemQuantity.value);
        Future.delayed(const Duration(seconds: 1), () {
          pushNewScreen(
            context,
            withNavBar: true,
            screen: Cart(manager: widget.manager),
          );
        });
      } else {
        //Advanced case here
        showBarModalBottomSheet(
          expand: false,
          context: context,
          topControl: ClipOval(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    16,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.close,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          builder: (context) => SizedBox(
            height: MediaQuery.of(context).size.height * 0.275,
            child: Assigner(
              selectedDays: _controller.planSetup["selectedDays"],
              product: widget.data,
              manager: widget.manager,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // print("hHHJHS:: ${_controller.planSetup['meals'][0]["day"]}");

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
            text: "Details".toUpperCase(),
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: SizedBox(
                width: double.infinity,
                child: PinchZoom(
                  child: CachedNetworkImage(
                    imageUrl: '${widget.data['image']}',
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (context, url, prog) =>
                        const Center(
                      child: BannerShimmer(),
                    ),
                    errorWidget: (context, err, st) => const BannerShimmer(),
                  ),
                  resetDuration: const Duration(milliseconds: 100),
                  maxScale: 2.5,
                  onZoomStart: () {
                    if (kDebugMode) {
                      print('Start zooming');
                    }
                  },
                  onZoomEnd: () {
                    if (kDebugMode) {
                      print('Stop zooming');
                    }
                  },
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Stack(
                    children: [
                      ListView(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.66,
                                child: TextPoppins(
                                  text: widget.data['name'],
                                  color: Constants.primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                "${Constants.nairaSign(context).currencySymbol}${Constants.formatMoney(widget.data['price'])}",
                                style: const TextStyle(
                                  color: Constants.primaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          TextPoppins(
                            text: widget.data['description'],
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          const Text(
                            "Ingredients",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Constants.primaryColor,
                            ),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, i) => TextPoppins(
                              text: widget.data['ingredients'][i]
                                  .toString()
                                  .capitalize!,
                              fontSize: 14,
                            ),
                            itemCount: widget.data['ingredients'].length,
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextPoppins(
                                text: "Calories",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Constants.primaryColor,
                              ),
                              TextPoppins(
                                text: "${widget.data['calories']}",
                                fontSize: 14,
                              ),
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextPoppins(
                                text: "Carbs",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Constants.primaryColor,
                              ),
                              TextPoppins(
                                text: "${widget.data['carbs']}",
                                fontSize: 14,
                              ),
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextPoppins(
                                text: "Proteins",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Constants.primaryColor,
                              ),
                              TextPoppins(
                                text: "${widget.data['proteins']}",
                                fontSize: 14,
                              ),
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextPoppins(
                                text: "Fat",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Constants.primaryColor,
                              ),
                              TextPoppins(
                                text: "${widget.data['fat']}",
                                fontSize: 14,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 60 + kToolbarHeight,
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 10,
                        left: 1,
                        right: 1,
                        child: Card(
                          elevation: 5,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _controller.meals.value.isNotEmpty
                                  ? const SizedBox()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            _minus(context);
                                          },
                                          icon: const Icon(
                                            CupertinoIcons.minus,
                                            color: Constants.primaryColor,
                                          ),
                                        ),
                                        TextPoppins(
                                            text:
                                                "${_controller.itemQuantity.value}",
                                            fontSize: 16),
                                        IconButton(
                                          onPressed: () {
                                            _add(context);
                                          },
                                          icon: const Icon(
                                            CupertinoIcons.add,
                                            color: Constants.primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    _addToCart(context);
                                  },
                                  child: TextPoppins(
                                    text: "Add to cart",
                                    fontSize: 16,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(16.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
