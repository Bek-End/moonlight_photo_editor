import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_editor_flutter2/core/colors/colors.dart';
import 'package:photo_editor_flutter2/core/widgets/buttons/skip_button.dart';
import 'package:photo_editor_flutter2/features/home/home_screen.dart';
import 'package:photo_editor_flutter2/features/onboarding/widgets/onboarding_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    pageController.addListener(
      () {
        if (pageController.page! > 1) {
          setState(() {
            title = 'ENTER';
          });
        } else {
          setState(() {
            title = 'SKIP';
          });
        }
      },
    );
  }

  final PageController pageController = PageController();
  String title = 'SKIP';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: PageView(
                controller: pageController,
                children: [
                  if (Platform.isMacOS)
                    const OnboardingWidget(
                      text: 'Tap the icons to edit photos or draw something on a canvas',
                      image: 'assets/images/1-macos.png',
                    )
                  else
                    const OnboardingWidget(
                      text: 'Tap the icons to edit photos or draw something on a canvas',
                      image: 'assets/images/1.png',
                    ),
                  if (Platform.isMacOS)
                    const OnboardingWidget(
                      text: 'Select tools and start drawing ',
                      image: 'assets/images/2-macos.png',
                    )
                  else
                    const OnboardingWidget(
                      text: 'Select tools and start drawing ',
                      image: 'assets/images/2.png',
                    ),
                  if (Platform.isMacOS)
                    const OnboardingWidget(
                      text: 'Save and share',
                      image: 'assets/images/3-macos.png',
                    )
                  else
                    const OnboardingWidget(
                      text: 'Save and share',
                      image: 'assets/images/3.png',
                    )
                ],
              ),
            ),
            Center(
              child: SmoothPageIndicator(
                controller: pageController,
                count: 3,
                effect: const WormEffect(
                  spacing: 8.0,
                  radius: 8,
                  dotWidth: 8,
                  dotHeight: 8.0,
                  paintStyle: PaintingStyle.fill,
                  dotColor: kWhite,
                  activeDotColor: kOrange,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SkipButton(
        onPressed: () {
          if (pageController.page! >= 2) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          } else {
            pageController.nextPage(
              duration: const Duration(
                milliseconds: 500,
              ),
              curve: Curves.easeIn,
            );
          }
        },
        text: title,
      ),
    );
  }
}
