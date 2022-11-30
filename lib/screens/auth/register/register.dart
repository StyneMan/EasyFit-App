import 'dart:io';

import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/forms/signup/signupform.dart';
import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:easyfit_app/screens/auth/otp/verifyotp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';
import 'package:page_transition/page_transition.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isLoading = false;

  _register(bool val) {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });

      Navigator.of(context).push(
        PageTransition(
          type: PageTransitionType.size,
          alignment: Alignment.bottomCenter,
          child: const VerifyOTP(
            caller: "Register",
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlayPro(
      isLoading: _isLoading,
      backgroundColor: Colors.black54,
      progressIndicator: Platform.isAndroid
          ? const CircularProgressIndicator(
              color: Colors.white,
            )
          : const CupertinoActivityIndicator(
              animating: true,
            ),
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  const SizedBox(),
                  Positioned(
                    top: 36,
                    right: 0,
                    bottom: 18,
                    child: Image.asset(
                      "assets/images/signup_img.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 8.0,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
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
            Expanded(
              flex: 3,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                shrinkWrap: true,
                children: [
                  TextPoppins(
                    text: "Sign Up",
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  TextPoppins(
                    text:
                        "Create an account and start your journey to the healthy lifestyle.",
                    fontSize: 14,
                  ),
                  const SizedBox(
                    height: 18.0,
                  ),
                  SignupForm(onLoading: _register),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "By signing up, you agree to our ",
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: "Terms of Use",
                            style: const TextStyle(
                              color: Constants.primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => print("object"),
                            // ..onTap = _showTermsOfService,
                          ),
                          const TextSpan(
                            text: " and ",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: "Privacy Policy",
                            style: const TextStyle(
                              color: Constants.primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => print("object"),
                            // ..onTap = _showTermsOfService,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}