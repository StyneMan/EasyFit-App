import 'package:cached_network_image/cached_network_image.dart';
import 'package:easyfit_app/components/shimmer/banner_shimmer.dart';
import 'package:easyfit_app/components/shimmer/image_shimmer.dart';
import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:flutter/material.dart';

import '../../../components/text_components.dart';

class MenuCard extends StatelessWidget {
  var data;
  MenuCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.45,
          height: MediaQuery.of(context).size.width * 0.45,
          decoration: BoxDecoration(
            // color: HexColor.fromHex(data['color']),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: CachedNetworkImage(
              imageUrl: '${data['image']}',
              width: MediaQuery.of(context).size.width * 0.45,
              height: MediaQuery.of(context).size.width * 0.45,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, prog) => const Center(
                child: BannerShimmer(),
              ),
              errorWidget: (context, err, st) => const BannerShimmer(),
            ),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Center(
          child: TextPoppins(
            text: data['name'].toUpperCase(),
            fontSize: 14,
            align: TextAlign.center,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
