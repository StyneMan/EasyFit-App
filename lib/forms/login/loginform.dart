import 'package:easyfit_app/components/dashboard/dashboard.dart';
import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:easyfit_app/helper/preference/preference_manager.dart';
import 'package:easyfit_app/helper/state/state_manager.dart';
import 'package:easyfit_app/screens/auth/forgotPass/forgotPass.dart';
import 'package:easyfit_app/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:page_transition/page_transition.dart';

class LoginForm extends StatefulWidget {
  final PreferenceManager manager;
  LoginForm({Key? key, required this.manager}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true;

  final _formKey = GlobalKey<FormState>();
  final _controller = Get.find<StateController>();

  _togglePass() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  _login() async {
    _controller.setLoading(true);
    try {
      final resp = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      _controller.setLoading(false);

      widget.manager.setIsLoggedIn(true);

      Navigator.of(context).pushReplacement(
        PageTransition(
          type: PageTransitionType.size,
          alignment: Alignment.bottomCenter,
          child: Dashboard(
            manager: widget.manager,
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      _controller.setLoading(false);
      print(e.message);
      Constants.toast("${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                gapPadding: 1.0,
              ),
              filled: false,
              labelText: 'Email',
              hintText: 'Email',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                gapPadding: 1.0,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                gapPadding: 1.0,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email or phone';
              }
              //if email
              // if (value.contains(RegExp(r'[a-z]'))) {
              //Email is entere now check if the email is valid
              if (!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]')
                  .hasMatch(value)) {
                return 'Please enter a valid email';
              }
              // }
              // else {
              //   if (value.length < 11) {
              //     return "Please enter a valid phone number";
              //   }
              // }

              return null;
            },
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
          ),
          const SizedBox(
            height: 16.0,
          ),
          TextFormField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                gapPadding: 1.0,
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                gapPadding: 1.0,
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                gapPadding: 1.0,
              ),
              filled: false,
              labelText: 'Password',
              hintText: 'Password',
              suffixIcon: IconButton(
                onPressed: () => _togglePass(),
                icon: Icon(
                  _obscureText ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please type password';
              }
              return null;
            },
            obscureText: _obscureText,
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(
            height: 1.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    PageTransition(
                      type: PageTransitionType.size,
                      alignment: Alignment.bottomCenter,
                      child: const ForgotPassword(),
                    ),
                  );
                },
                child: TextPoppins(
                  text: "Forgot password?",
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Constants.primaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            child: ElevatedButton(
              onPressed: () {
                _login();
                // Navigator.of(context).pushReplacement(
                //   PageTransition(
                //     type: PageTransitionType.size,
                //     alignment: Alignment.bottomCenter,
                //     child: Dashboard(
                //       manager: widget.manager,
                //     ),
                //   ),
                // );
              },
              child: TextPoppins(
                text: "Sign in",
                fontSize: 14,
                color: Colors.white,
              ),
              style: ElevatedButton.styleFrom(
                primary: Constants.primaryColor,
                onPrimary: Colors.white,
                elevation: 0.2,
              ),
            ),
          )
        ],
      ),
    );
  }
}
