import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/data/onboarding/slide.dart';
import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:easyfit_app/screens/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height * 0.81;
    double hleft = MediaQuery.of(context).size.height - (h + 16);

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            height: h + 16,
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
                _pageController.animateToPage(
                  currentIndex,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              itemCount: onboardingSlides.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: Stack(
                        children: [
                          Positioned(
                            right: -1,
                            left: 50,
                            top: 10,
                            child: Image.asset(
                              onboardingSlides[index].image,
                              // width: MediaQuery.of(context).size.width * 0.75,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: (MediaQuery.of(context).size.height * 0.75 - 48),
                      left: 16,
                      right: 16,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextPoppins(
                            text: onboardingSlides[index].title,
                            fontSize: 21,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          TextPoppins(
                            text: onboardingSlides[index].desc,
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          TextPoppins(
                            text: onboardingSlides[index].author,
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: onboardingSlides.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _pageController.animateToPage(
                        entry.key,
                        duration: const Duration(),
                        curve: Curves.easeIn,
                      ),
                      child: Container(
                        width: 12.0,
                        height: 12.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              (Theme.of(context).brightness == Brightness.dark
                                      ? Colors.white
                                      : Constants.primaryColor)
                                  .withOpacity(
                            currentIndex == entry.key ? 0.9 : 0.4,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    currentIndex == (onboardingSlides.length - 1)
                        ? const SizedBox()
                        : TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                PageTransition(
                                  type: PageTransitionType.size,
                                  alignment: Alignment.bottomCenter,
                                  child: Welcome(),
                                ),
                              );
                            },
                            child: Text('Skip'),
                          ),
                    ElevatedButton(
                      onPressed: currentIndex == (onboardingSlides.length - 1)
                          ? () {
                              Navigator.of(context).pushReplacement(
                                PageTransition(
                                  type: PageTransitionType.bottomToTop,
                                  child: Welcome(),
                                ),
                              );
                            }
                          : () {
                              setState(() {
                                currentIndex = currentIndex + 1;
                              });
                              _pageController.animateToPage(
                                currentIndex,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn,
                              );
                            },
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
