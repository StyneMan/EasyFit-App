import 'package:easyfit_app/screens/auth/login/login.dart';
import 'package:easyfit_app/screens/auth/register/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Image.asset(
            "assets/images/welcome_img.png",
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
          ),
          Center(
            child: Image.asset(
              'assets/images/splash_icon.png',
              width: MediaQuery.of(context).size.width * 0.48,
            ),
          ),
          Positioned(
            bottom: 56,
            left: 56,
            right: 56,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.white,
                      width: 1.0,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        PageTransition(
                          type: PageTransitionType.size,
                          alignment: Alignment.bottomCenter,
                          child: Login(),
                        ),
                      );
                    },
                    child: const Text("Sign in"),
                    style: TextButton.styleFrom(
                      onSurface: Colors.white,
                      primary: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Container(
                  padding: const EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.white,
                      width: 1.0,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        PageTransition(
                          type: PageTransitionType.size,
                          alignment: Alignment.bottomCenter,
                          child: Register(),
                        ),
                      );
                    },
                    child: const Text(
                      "Create an account",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
