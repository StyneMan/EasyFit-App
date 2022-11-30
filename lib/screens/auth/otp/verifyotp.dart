import 'dart:io';

import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:easyfit_app/helper/state/state_manager.dart';
import 'package:easyfit_app/screens/auth/account_created/successscreen.dart';
import 'package:easyfit_app/screens/auth/resetpass/resetpass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';
import 'package:page_transition/page_transition.dart';

class VerifyOTP extends StatefulWidget {
  final String caller;
  const VerifyOTP({
    Key? key,
    required this.caller,
  }) : super(key: key);

  @override
  State<VerifyOTP> createState() => _State();
}

class _State extends State<VerifyOTP> {
  bool _isLoading = false;
  // final _controller = Get.find<StateController>();

  String? num1 = "";
  String? num2 = "";
  String? num3 = "";
  String? num4 = "";

  _resendCode() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _isLoading = false;
      });

      if (widget.caller == "Password") {
        Navigator.of(context).push(
          PageTransition(
            type: PageTransitionType.size,
            alignment: Alignment.bottomCenter,
            child: const ResetPassword(),
          ),
        );
      } else {
        Navigator.of(context).push(
          PageTransition(
            type: PageTransitionType.size,
            alignment: Alignment.bottomCenter,
            child: const AccountSuccess(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return
        // Obx(
        //   () =>
        LoadingOverlayPro(
      isLoading: _isLoading, // _controller.isLoading.value,
      backgroundColor: Colors.black54,
      progressIndicator: Platform.isAndroid
          ? const CircularProgressIndicator(
              color: Colors.white,
            )
          : const CupertinoActivityIndicator(
              animating: true,
            ),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Center(
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10.0,
                  ),
                  children: [
                    Image.asset(
                      "assets/images/otp_verification_img.png",
                      width: MediaQuery.of(context).size.width * 0.14,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextPoppins(
                      text: "OTP Verification",
                      fontSize: 21,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      align: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    TextPoppins(
                      text:
                          "Please type the 4 digit OTP code sent to your email.",
                      fontSize: 14,
                      align: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 18.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _textFieldOTP(first: true, last: false, index: 0),
                        const SizedBox(
                          width: 18.0,
                        ),
                        _textFieldOTP(first: false, last: false, index: 1),
                        const SizedBox(
                          width: 18.0,
                        ),
                        _textFieldOTP(first: false, last: false, index: 2),
                        const SizedBox(
                          width: 18.0,
                        ),
                        _textFieldOTP(first: false, last: true, index: 3),
                      ],
                    ),
                    // TextButton(
                    //   onPressed: () {},
                    //   child: Text("Resend code in 01:34"),
                    // ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _resendCode();
                      },
                      child: TextPoppins(
                        text: 'Verify OTP',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(12.0),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 16,
                left: 8.0,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    CupertinoIcons.arrow_left_circle_fill,
                    color: Colors.black,
                    size: 36,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // ),
    );
  }

  Widget _textFieldOTP({required bool first, last, required int index}) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      child: AspectRatio(
        aspectRatio: 0.4,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            print('Curr index $index $value');

            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }

            if (first == true) {
              setState(() {
                num1 = value;
              });
            }
            if (index == 1) {
              setState(() {
                num2 = value;
              });
            }
            if (index == 2) {
              setState(() {
                num3 = value;
              });
            }
            // else if (index == 1 && value.length == 1) {
            //   _otpList.add(value);
            // }
            if (value.length == 1 && last == true) {
              setState(() {
                num4 = value;
              });

              // _triggerVerify(num1!, num2!, num3!, num4!);
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: const InputDecoration(
            counter: Offstage(),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.black12),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 2, color: Color(0xFF197F8A)),
            ),
          ),
        ),
      ),
    );
  }
}
