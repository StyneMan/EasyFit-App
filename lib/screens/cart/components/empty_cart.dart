import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../components/text_components.dart';
import '../../../helper/constants/constants.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.40,
              height: MediaQuery.of(context).size.width * 0.40,
              padding: const EdgeInsets.all(36.0),
              color: Constants.accentColor,
              child: SvgPicture.asset(
                'assets/images/empty_cart.svg',
                color: Constants.primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          TextPoppins(
            text: 'Cart is empty',
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
