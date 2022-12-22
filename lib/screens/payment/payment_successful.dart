import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../helper/preference/preference_manager.dart';

class PaymentSuccessful extends StatelessWidget {
  final PreferenceManager manager;
  PaymentSuccessful({
    Key? key,
    required this.manager,
  }) : super(key: key);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // Future.delayed(const Duration(seconds: 2), () {
    //   if (cart != null && listMap != null) {
    //     cart.emptyCart(listMap[0]['cart']);
    //     //reset delivery info too.
    //     cart.setHasDelivery(false);
    //     cart.setDeliveryInfo({});
    //   }
    // });

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Payment Status',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                ClipOval(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.40,
                    height: MediaQuery.of(context).size.width * 0.40,
                    padding: const EdgeInsets.all(36.0),
                    color: Constants.accentColor,
                    child: SvgPicture.asset('assets/images/wpf_banknotes.svg'),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextPoppins(
                  text: 'Payment Successful',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            TextPoppins(
              text:
                  'Thanks for shopping with DWEC Winery. Please note that your order will be packaged and ready for pickup or delivery once confirmed.',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              align: TextAlign.center,
            ),
            const SizedBox(height: 24.0),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // _controller.jumpTo(0);
                  // _controller.jumpTo(0);
                  // Navigator.of(context).pushAndRemoveUntil(
                  //   MaterialPageRoute(builder: (context) => Home(manager: manager),),
                  //   (Route<dynamic> route) => false,
                  // );
                },
                child: const Text(
                  'PROCEED',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  backgroundColor: Constants.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
