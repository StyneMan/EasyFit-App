import 'package:cached_network_image/cached_network_image.dart';
import 'package:easyfit_app/helper/preference/preference_manager.dart';
import 'package:easyfit_app/screens/product/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:page_transition/page_transition.dart';

import '../../../components/shimmer/banner_shimmer.dart';
import '../../../components/text_components.dart';
import '../../../helper/state/state_manager.dart';

class BannerWidget extends StatelessWidget {
  final PreferenceManager manager;
  BannerWidget({
    Key? key,
    required this.manager,
  }) : super(key: key);

  final _controller = Get.find<StateController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.all(2.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(16.0),
          ),
          child: _controller.featuredMeal.value.isEmpty
              ? const BannerShimmer()
              : GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      PageTransition(
                        duration: const Duration(milliseconds: 500),
                        type: PageTransitionType.bottomToTopJoined,
                        alignment: Alignment.bottomCenter,
                        childCurrent: this,
                        child: ProductDetail(
                            manager: manager,
                            data: _controller.featuredMeal.value[0]),
                      ),
                    );
                  },
                  child: Stack(
                    children: <Widget>[
                      CachedNetworkImage(
                        imageUrl: _controller.featuredMeal.value[0]['image'],
                        progressIndicatorBuilder: (context, url, prog) =>
                            const Center(
                          child: BannerShimmer(),
                        ),
                        fit: BoxFit.cover,
                        height: 200,
                        width: 1000.0,
                        errorWidget: (context, err, st) => const Center(
                          child: BannerShimmer(),
                        ),
                      ),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 21.0,
                            horizontal: 20.0,
                          ),
                          child: TextPoppins(
                            text: "Meal of the week",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
