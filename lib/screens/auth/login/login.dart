import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/forms/login/loginform.dart';
import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:easyfit_app/helper/preference/preference_manager.dart';
import 'package:easyfit_app/screens/auth/register/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Login extends StatefulWidget {
  const Login({
    Key? key,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  PreferenceManager? _manager;

  @override
  void initState() {
    super.initState();
    _manager = PreferenceManager(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              children: [
                const SizedBox(),
                Positioned(
                  top: 18,
                  right: -4,
                  bottom: -5,
                  child: Image.asset(
                    "assets/images/login_img.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 40,
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
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              shrinkWrap: true,
              children: [
                TextPoppins(
                  text: "Welcome back!",
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                TextPoppins(
                  text: "Sign in to your account!",
                  fontSize: 14,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                LoginForm(
                  manager: _manager!,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: "Sign up ",
                          style: const TextStyle(
                            color: Constants.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.of(context).push(
                                  PageTransition(
                                    type: PageTransitionType.size,
                                    alignment: Alignment.bottomCenter,
                                    child: Register(),
                                  ),
                                ),
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
    );
  }
}
