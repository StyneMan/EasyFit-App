import 'package:easyfit_app/components/drawer/custom_drawer.dart';
import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/data/products/products.dart';
import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:easyfit_app/helper/preference/preference_manager.dart';
import 'package:easyfit_app/screens/cart/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class ProductDetail extends StatefulWidget {
  final PreferenceManager manager;
  final Product product;
  ProductDetail({
    Key? key,
    required this.manager,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  int _count = 1;

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
            child: PinchZoom(
              child: Image.asset(
                '${widget.product.image}',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  "assets/images/placeholder.png",
                  fit: BoxFit.cover,
                ),
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
                                text: widget.product.name,
                                color: Constants.primaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              "${Constants.nairaSign(context).currencySymbol}${Constants.formatMoney(widget.product.price)}",
                              style: const TextStyle(
                                color: Constants.primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 21.0),
                        TextPoppins(
                          text: widget.product.description,
                          fontSize: 14,
                        ),
                        const SizedBox(
                          height: 18,
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
                          height: 5.0,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, i) => TextPoppins(
                            text: widget.product.ingredients[i].capitalize!,
                            fontSize: 14,
                          ),
                          itemCount: widget.product.ingredients.length,
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
                              text: "${widget.product.calories}",
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
                              text: "${widget.product.carbs}",
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
                              text: "${widget.product.proteins}",
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
                              text: "${widget.product.fat}",
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (_count > 1) {
                                      setState(() {
                                        _count = _count - 1;
                                      });
                                    }
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.minus,
                                    color: Constants.primaryColor,
                                  ),
                                ),
                                TextPoppins(text: "$_count", fontSize: 16),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _count = _count + 1;
                                    });
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
                                onPressed: () {},
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
    );
  }
}
