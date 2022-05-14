import 'dart:math' as math;

import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:glass/glass.dart';

import 'package:photo_editor_flutter2/core/colors/colors.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BottomSheetExpandedElement extends StatelessWidget {
  final String title;
  final String subtitle;
  final String instaLink;
  final String telegramLink;
  const BottomSheetExpandedElement({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.instaLink,
    required this.telegramLink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kGreyLight,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ExpansionWidget(
        titleBuilder: (double animationValue, _, bool isExpaned, toogleFunction) {
          return InkWell(
            onTap: () => toogleFunction(animated: true),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Transform.rotate(
                    angle: math.pi * animationValue / 2,
                    child: Icon(
                      PhosphorIcons.caret_right_thin,
                      color: kWhite.withOpacity(0.2),
                    ),
                    alignment: Alignment.center,
                  ),
                )
              ],
            ),
          );
        },
        content: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: kWhite.withOpacity(0.66),
                      ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: const Icon(
                        PhosphorIcons.instagram_logo_light,
                        color: kWhite,
                      ),
                      onPressed: () async{
                        await launchUrlString(instaLink);
                      },
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: const Icon(
                        PhosphorIcons.telegram_logo_light,
                        color: kWhite,
                      ),
                      onPressed: () async{
                        await launchUrlString(telegramLink);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomSheetWidget extends StatelessWidget {
  final List<Widget> children;
  const BottomSheetWidget({
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          color: Theme.of(context).primaryColorDark.withOpacity(0.8),
        ),
        child: SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 14),
                alignment: Alignment.center,
                height: 4,
                width: 50,
                decoration: BoxDecoration(
                  color: kWhite.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: children,
                ),
              ),
            ],
          ),
        ),
      ).asGlass(
        blurX: 15,
        blurY: 15,
        tintColor: kGreyLight,
      ),
    );
  }
}
