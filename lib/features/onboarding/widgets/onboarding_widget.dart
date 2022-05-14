import 'dart:io';

import 'package:flutter/material.dart';

class OnboardingWidget extends StatelessWidget {
  final String text;
  final String image;
  const OnboardingWidget({
    Key? key,
    required this.text,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          height: 360,
        ),
        const SizedBox(
          height: 80,
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        )
      ],
    );
  }
}
