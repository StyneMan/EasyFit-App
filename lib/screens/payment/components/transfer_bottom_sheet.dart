import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../helper/constants/constants.dart';
import '../../../helper/preference/preference_manager.dart';
import '../payment_proof.dart';

class TransferBottomSheet extends StatelessWidget {
  var data;
  PreferenceManager manager;
  TransferBottomSheet({
    Key? key,
    required this.data,
    required this.manager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          const Text(
            'Account Details',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Bank',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Constants.primaryColor,
            ),
          ),
          Text(
            "${data['bankName1'] ?? "ABC Bank"}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Account Name',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Constants.primaryColor,
            ),
          ),
          Text(
            '${data['accountName1'] ?? "EasyFit..."}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Account Number',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Constants.primaryColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${data['accountNumber1'] ?? "1234567890"}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                onPressed: () {
                  Clipboard.setData(
                    ClipboardData(
                        text: '${data['accountNumber1'] ?? "1234567890"}'),
                  );
                  Fluttertoast.showToast(
                    msg: "Copied to clipboard!",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 3,
                    backgroundColor: Constants.primaryColor,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                },
                icon: const Icon(Icons.copy),
              ),
            ],
          ),
          const Divider(thickness: 3.0),
          const SizedBox(height: 8),
          const Text(
            'Bank',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Constants.primaryColor,
            ),
          ),
          Text(
            "${data['bankName2'] ?? "XYZ Bank"}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Account Name',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Constants.primaryColor,
            ),
          ),
          Text(
            '${data['accountName2'] ?? "EasyFit..."}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Account Number',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Constants.primaryColor),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${data['accountNumber2'] ?? "0123456789"}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                onPressed: () {
                  Clipboard.setData(
                    ClipboardData(text: '${data['accountNumber2']}'),
                  );
                  Fluttertoast.showToast(
                    msg: "Copied to clipboard!",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 3,
                    backgroundColor: Constants.primaryColor,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                },
                icon: const Icon(Icons.copy),
              ),
            ],
          ),
          const SizedBox(height: 21),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
                pushNewScreen(
                  context,
                  screen: PaymentProof(manager: manager),
                  withNavBar: true, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              child: Text(
                'I have paid'.toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Constants.primaryColor,
                padding: const EdgeInsets.all(16.0),
                onSurface: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
