import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/screens/personalize/personalizeaccount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

class AccountSuccess extends StatelessWidget {
  const AccountSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            SvgPicture.asset(
              "assets/images/texture.svg",
              fit: BoxFit.cover,
            ),
            Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/smiley.png",
                      fit: BoxFit.cover,
                    ),
                    TextPoppins(
                      text: "Your EasyFit account has been created, Okoro.",
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      align: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 2.0,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: TextPoppins(
                        text:
                            "You’re one step away from living that healthy life and achieving that body goal. ",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        align: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 18,
              left: 18,
              right: 18,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    PageTransition(
                      type: PageTransitionType.size,
                      alignment: Alignment.bottomCenter,
                      child: const PersonalizeAccount(),
                    ),
                  );
                },
                child: TextPoppins(
                  text: "Personalize Account",
                  fontSize: 14,
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
