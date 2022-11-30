import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/forms/forgotPassword/passwordform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                const SizedBox(),
                Positioned(
                  top: 18,
                  right: -4,
                  bottom: 10,
                  child: Image.asset(
                    "assets/images/forgotpass_img.png",
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
            flex: 2,
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              shrinkWrap: true,
              children: [
                TextPoppins(
                  text: "Forgot Password",
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                TextPoppins(
                  text: "Enter the email associated with your account.",
                  fontSize: 14,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                PasswordForm(),
                const SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
