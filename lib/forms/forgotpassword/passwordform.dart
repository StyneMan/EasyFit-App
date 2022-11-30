import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:easyfit_app/screens/auth/otp/verifyotp.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class PasswordForm extends StatefulWidget {
  PasswordForm({Key? key}) : super(key: key);

  @override
  State<PasswordForm> createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  final TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
              filled: false,
              labelText: 'Email',
              hintText: 'Email',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]')
                  .hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
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
                if (_formKey.currentState!.validate()) {
                  //Now go to otp page
                  Navigator.of(context).push(
                    PageTransition(
                      type: PageTransitionType.size,
                      alignment: Alignment.bottomCenter,
                      child: const VerifyOTP(
                        caller: "Password",
                      ),
                    ),
                  );
                }
              },
              child: TextPoppins(
                text: "Send OTP",
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
