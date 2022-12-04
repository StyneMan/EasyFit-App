import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:easyfit_app/helper/preference/preference_manager.dart';
import 'package:easyfit_app/helper/state/state_manager.dart';
import 'package:easyfit_app/screens/auth/account_created/successscreen.dart';
import 'package:easyfit_app/screens/auth/resetpass/resetpass.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_autofill/sms_autofill.dart';

typedef void InitCallback(params);

class VerifyOTP extends StatefulWidget {
  final String caller;
  var credential;
  InitCallback? onEntered;
  String? email, pass, phone, name, verificationId;
  VerifyOTP({
    Key? key,
    required this.caller,
    this.verificationId,
    this.onEntered,
    this.credential,
    this.email,
    this.name,
    this.pass,
    this.phone,
  }) : super(key: key);

  @override
  State<VerifyOTP> createState() => _State();
}

class _State extends State<VerifyOTP> {
  bool _isLoading = false;
  final _controller = Get.find<StateController>();
  final _otpController = TextEditingController();
  PreferenceManager? _manager;
  String _code = '';

  @override
  void initState() {
    super.initState();
    _manager = PreferenceManager(context);
  }

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

  _linkAccount() async {
    _controller.setLoading(true);
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      String smsCode = _otpController.text.trim();

      var _credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationId!, smsCode: smsCode);
      //  .getCredential(
      //     verificationId: verificationId, smsCode: smsCode);
      auth.currentUser?.linkWithCredential(_credential).then((result) async {
        await FirebaseFirestore.instance.collection("users").add({
          "name": widget.name,
          "id": auth.currentUser?.uid,
          "email": widget.email,
          "phone": widget.phone,
          "isActive": true,
          "cart": [],
          "orders": [],
          "dob": "",
          "address": "",
          "image": "",
          "preference": null
        });

        _controller.setLoading(false);
        _manager?.setIsLoggedIn(true);

        Navigator.of(context).pushReplacement(
          PageTransition(
            type: PageTransitionType.size,
            alignment: Alignment.bottomCenter,
            child: const AccountSuccess(),
          ),
        );
      }).catchError((e) {
        print(e);
      });
    } on FirebaseAuthException catch (e) {
      _controller.setLoading(false);
      switch (e.code) {
        case "provider-already-linked":
          print("The provider has already been linked to the user.");
          break;
        case "invalid-credential":
          print("The provider's credential is not valid.");
          break;
        case "credential-already-in-use":
          print("The account corresponding to the credential already exists, "
              "or is already linked to a Firebase User.");
          break;
        // See the API reference for the full list of error codes.
        default:
          print("Unknown error.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => LoadingOverlayPro(
        isLoading: _controller.isLoading.value, // _controller.isLoading.value,
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
                            "Please type the 6 digit OTP code sent to your phone.",
                        fontSize: 14,
                        align: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 18.0,
                      ),
                      PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: const TextStyle(
                          color: Constants.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 6,
                        autoFocus: true,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        validator: (v) {
                          if (v!.length < 3) {
                            return "I'm from validator";
                          } else {
                            return null;
                          }
                        },
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderWidth: 0.75,
                          fieldOuterPadding:
                              const EdgeInsets.symmetric(horizontal: 0.0),
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor: Colors.white,
                        ),
                        cursorColor: Colors.black,
                        animationDuration: const Duration(milliseconds: 300),
                        // enableActiveFill: true,
                        // errorAnimationController: errorController,
                        controller: _otpController,
                        keyboardType: TextInputType.number,
                        boxShadows: const [
                          BoxShadow(
                            offset: Offset(0, 1),
                            color: Colors.black12,
                            blurRadius: 10,
                          )
                        ],
                        onCompleted: (v) {
                          debugPrint("Completed");
                        },
                        // onTap: () {
                        //   print("Pressed");
                        // },
                        onChanged: (value) {
                          debugPrint(value);
                          // setState(() {
                          //   currentText = value;
                          // });
                        },
                        beforeTextPaste: (text) {
                          debugPrint("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                      ),
                      // PinFieldAutoFill(
                      //   decoration: UnderlineDecoration(
                      //     textStyle: const TextStyle(
                      //       fontSize: 20,
                      //       color: Colors.black,
                      //     ),
                      //     colorBuilder: FixedColorBuilder(
                      //       Colors.black.withOpacity(0.3),
                      //     ),
                      //   ),
                      //   currentCode: _code,
                      //   controller: _otpController,
                      //   onCodeSubmitted: (code) {
                      //     // _linkAccount();
                      //   },
                      //   onCodeChanged: (code) {
                      //     if (code!.length == 6) {
                      //       FocusScope.of(context).requestFocus(FocusNode());
                      //     }
                      //   },
                      // ),

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     _textFieldOTP(first: true, last: false, index: 0),
                      //     const SizedBox(
                      //       width: 10.0,
                      //     ),
                      //     _textFieldOTP(first: false, last: false, index: 1),
                      //     const SizedBox(
                      //       width: 10.0,
                      //     ),
                      //     _textFieldOTP(first: false, last: false, index: 2),
                      //     const SizedBox(
                      //       width: 10.0,
                      //     ),
                      //     _textFieldOTP(first: false, last: false, index: 3),
                      //     const SizedBox(
                      //       width: 10.0,
                      //     ),
                      //     _textFieldOTP(first: false, last: false, index: 4),
                      //     const SizedBox(
                      //       width: 10.0,
                      //     ),
                      //     _textFieldOTP(first: false, last: true, index: 5),
                      //   ],
                      // ),
                      // TextButton(
                      //   onPressed: () {},
                      //   child: Text("Resend code in 01:34"),
                      // ),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // _resendCode();
                          // _linkAccount();
                          if (widget.caller == "Password") {
                            Navigator.of(context).push(
                              PageTransition(
                                type: PageTransitionType.size,
                                alignment: Alignment.bottomCenter,
                                child: const ResetPassword(),
                              ),
                            );
                          } else {
                            _linkAccount();
                          }
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
      ),
    );
  }

  // Widget _textFieldOTP({required bool first, last, required int index}) {
  //   return Container(
  //     height: MediaQuery.of(context).size.height * 0.15,
  //     child: AspectRatio(
  //       aspectRatio: 0.4,
  //       child: TextField(
  //         autofocus: true,
  //         onChanged: (value) {
  //           print('Curr index $index $value');

  //           if (value.length == 1 && last == false) {
  //             FocusScope.of(context).nextFocus();
  //           }
  //           if (value.length == 0 && first == false) {
  //             FocusScope.of(context).previousFocus();
  //           }

  //           if (first == true) {
  //             setState(() {
  //               num1 = value;
  //             });
  //           }
  //           if (index == 1) {
  //             setState(() {
  //               num2 = value;
  //             });
  //           }
  //           if (index == 2) {
  //             setState(() {
  //               num3 = value;
  //             });
  //           }
  //           if (index == 3) {
  //             setState(() {
  //               num4 = value;
  //             });
  //           }
  //           if (index == 4) {
  //             setState(() {
  //               num5 = value;
  //             });
  //           }
  //           // else if (index == 1 && value.length == 1) {
  //           //   _otpList.add(value);
  //           // }
  //           if (value.length == 1 && last == true) {
  //             setState(() {
  //               num6 = value;
  //             });

  //             widget.onEntered!("$num1$num2$num3$num4$num5$num6");

  //             // _triggerVerify(num1!, num2!, num3!, num4!);
  //           }
  //         },
  //         showCursor: false,
  //         readOnly: false,
  //         textAlign: TextAlign.center,
  //         style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //         keyboardType: TextInputType.number,
  //         maxLength: 1,
  //         decoration: const InputDecoration(
  //           counter: Offstage(),
  //           enabledBorder: UnderlineInputBorder(
  //             borderSide: BorderSide(width: 2, color: Colors.black12),
  //           ),
  //           focusedBorder: UnderlineInputBorder(
  //             borderSide: BorderSide(
  //               width: 2,
  //               color: Color(0xFF197F8A),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
