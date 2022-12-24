import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/instance_manager.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../components/drawer/custom_drawer.dart';
import '../../components/text_components.dart';
import '../../helper/constants/constants.dart';
import '../../helper/preference/preference_manager.dart';
import '../../helper/state/state_manager.dart';
import 'components/transfer_bottom_sheet.dart';

class PaymentMethod extends StatefulWidget {
  final PreferenceManager manager;
  const PaymentMethod({
    Key? key,
    required this.manager,
  }) : super(key: key);

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  final plugin = PaystackPlugin();
  final _controller = Get.find<StateController>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _bank1name = "";
  String _acc1name = "";
  String _acc1num = "";

  String _bank2name = "";
  String _acc2name = "";
  String _acc2num = "";

  Map _accData = {};

  _getAccounts() {
    FirebaseFirestore.instance
        .collection('cms')
        .doc("bank")
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (kDebugMode) {
          print('Document data: ${documentSnapshot.data()}');
        }
        setState(() {
          _accData = {
            "bankName1": documentSnapshot.get('bankName1'),
            "bankName2": documentSnapshot.get('bankName2'),
            "accountName1": documentSnapshot.get('accountName1'),
            "accountName2": documentSnapshot.get('accountName2'),
            "accountNumber1": documentSnapshot.get('accountNumber1'),
            "accountNumber2": documentSnapshot.get('accountNumber2'),
          };
        });
        if (kDebugMode) {
          print('${documentSnapshot.get('bankName1')}');
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    plugin.initialize(publicKey: Constants.pstk);
    // _getAccounts();
  }

  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<CartNotifier>(context);
    // final user = Provider.of<UserNotifier>(context);
    // final loader = Provider.of<LoaderNotifier>(context);
    // final _controller = Provider.of<RouteNotifier>(context);
    // var list = Provider.of<List<UserProfile>>(context);
    // final listMap = Provider.of<List<Map>>(context, listen: true);

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
          text: "payment method".toUpperCase(),
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
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                  width: 0.5, color: Colors.grey, style: BorderStyle.solid),
              borderRadius: const BorderRadius.all(
                Radius.circular(6.0),
              ),
            ),
            child: TextButton(
              onPressed: () {
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
                    height: MediaQuery.of(context).size.height * 0.70,
                    child: Wrap(
                      children: <Widget>[
                        TransferBottomSheet(
                          data: _accData,
                          manager: widget.manager,
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.20,
                      height: MediaQuery.of(context).size.width * 0.20,
                      color: Constants.accentColor,
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/images/bank_transfer.svg",
                          color: Constants.primaryColor,
                          width: 32,
                          height: 32,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Bank Transfer',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Make payments using bank transfer.',
                        style: TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  )
                ],
              ),
              style: TextButton.styleFrom(
                primary: Colors.black,
                padding: const EdgeInsets.all(10.0),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                  width: 0.5, color: Colors.grey, style: BorderStyle.solid),
              borderRadius: const BorderRadius.all(
                Radius.circular(6.0),
              ),
            ),
            child: TextButton(
              onPressed: () {
                _handleCheckout(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.20,
                      height: MediaQuery.of(context).size.width * 0.20,
                      color: Constants.accentColor,
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/images/atm.svg",
                          color: Constants.primaryColor,
                          width: 32,
                          height: 32,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Card Payment',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Make payments using your ATM card.',
                        style: TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
              style: TextButton.styleFrom(
                primary: Colors.black,
                padding: const EdgeInsets.all(10.0),
              ),
            ),
          ),
          const SizedBox(height: 96),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop(context);
                Navigator.of(context).pop(context);
              },
              child: const Text('Go back to cart',
                  style: TextStyle(color: Colors.white)),
              style: TextButton.styleFrom(
                backgroundColor: Constants.primaryColor,
                padding: const EdgeInsets.all(16.0),
                onSurface: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                style: BorderStyle.solid,
                width: 1.0,
                color: Constants.primaryColor,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            ),
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                _controller.tabController.jumpToTab(0);
              },
              child: const Text(
                'Explore more meals',
                style: TextStyle(color: Constants.primaryColor),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.all(16.0),
                onSurface: Constants.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _handleCheckout(BuildContext context) async {
    _controller.setLoading(true);
    // List<CartModel> itemList = [];
    // user.carts.forEach((v) {
    //     itemList.add(CartModel.fromJson(v));
    // });

    Charge charge = Charge()
      ..amount = (300000).toInt() * 100
      ..reference = _getReference()
      // ..accessCode = _accessCode
      ..email = "test@user.com";

    // var accessCode =
    // await _fetchAccessCodeFrmServer(_getReference(), cart, user.email);
    // charge.accessCode = accessCode;

    try {
      CheckoutResponse response = await plugin.checkout(
        context,
        method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
        charge: charge,
        fullscreen: true,
        logo: SvgPicture.asset("assets/images/logo.svg", width: 96),
      );

      print('Transaction Response => $response');
      print('Transaction Response Ref => ${response.reference}');
      // _verifyOnServer(response.reference, cart, listMap, user);
      _controller.setLoading(false);
      // setState(() => _inProgress = false);
      // _updateStatus(response.reference, '$response');
    } catch (e) {
      _controller.setLoading(false);
      // print('Transaction Error Response => $e');
      // setState(() => _inProgress = false);
      // _showMessage("Check console for error");
      rethrow;
    }
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  // Future<String?> _fetchAccessCodeFrmServer(
  //     String reference, cart, email) async {
  //   final resp = await FirebaseService.INIT_PAYMENT.call(<String, dynamic>{
  //     'amount': (cart.totalCartPrice).toInt() * 100,
  //     'email': email,
  //   });

  //   return "${resp.data['data']['access_code']}";
  // }

  Future _verifyOnServer(reference, cart, listMap, user) async {
    // try {
    //   final resp = await FirebaseService.VERIFY_PAYMENT.call(reference);

    //   print("ORDER-NO:: ${resp.data['data']['reference']}");
    //   print("AMOUNT:: ${resp.data['data']['amount']}");
    //   print("PAID AT:: ${resp.data['data']['paid_at']}");
    //   print("CURRENCY:: ${resp.data['data']['currency']}");
    //   print("PAYMENT METHOD:: ${resp.data['data']['channel']}");

    //   try {
    //     final res = await cart.addOrder(
    //         listMap[0]['cart'], resp.data, user.fullname, user.email);

    //     //Now send email here
    //     // final emailSend = await FirebaseService.SEND_ORDER_EMAIL.call({
    //     //   "userName": "${user.fullname}",
    //     //   "email": "${user.email}",
    //     //   "orderNo": "${resp.data['data']['reference']}",
    //     //   "items": listMap[0]['cart'],
    //     // });

    //     print("EMAIL RESPO:: $res");

    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => PaymentSuccessful(manager: widget.manager)),
    //     );
    //   } catch (er) {
    //     print("INNNER EROR:: $er");
    //   }
    // } catch (e) {
    //   print("EER:: $e");
    // }
  }
}
