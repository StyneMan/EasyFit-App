import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../components/shimmer/banner_shimmer.dart';
import '../../../components/shimmer/image_shimmer.dart';
import '../../../components/text_components.dart';
import '../../../helper/constants/constants.dart';
import '../../../helper/preference/preference_manager.dart';
import '../product_detail.dart';

class ProductCard extends StatelessWidget {
  var data;
  final PreferenceManager manager;
  ProductCard({
    Key? key,
    required this.data,
    required this.manager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            PageTransition(
              type: PageTransitionType.size,
              alignment: Alignment.bottomCenter,
              child: ProductDetail(manager: manager, data: data),
            ),
          );
        },
        child: Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Center(
                    child: CachedNetworkImage(
                      imageUrl: '${data['image']}',
                      progressIndicatorBuilder: (context, url, prog) =>
                          const Center(
                        child: ImageShimmer(),
                      ),
                      errorWidget: (context, err, st) => const BannerShimmer(),
                    ),
                  ),
                ),
              ),
              Container(
                // color: Colors.white,
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextPoppins(
                      text: data['name'].length > 19
                          ? data['name'].substring(0, 16) + "..."
                          : data['name'],
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    TextPoppins(
                      text: data['description'].length > 24
                          ? data['description'].substring(0, 21) + "..."
                          : data['description'],
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${Constants.nairaSign(context).currencySymbol} ${Constants.formatMoney(data['price'])}",
                          style: const TextStyle(
                            color: Constants.primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        ClipOval(
                          child: GestureDetector(
                            onTap: () {
                              //Add to cart here
                            },
                            child: Container(
                              color: Constants.primaryColor,
                              padding: const EdgeInsets.all(4.0),
                              child: const Icon(
                                CupertinoIcons.add,
                                color: Colors.white,
                                size: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
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
