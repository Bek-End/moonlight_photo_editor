import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_editor_flutter2/core/colors/colors.dart';

class SkipButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  const SkipButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              primary: kBlack,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: EdgeInsets.zero,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColorLight,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                text,
                style: Theme.of(context).primaryTextTheme.titleMedium,
              ),
            ),
          )
        : CupertinoButton(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColorLight,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 8,
              ),
              child: Text(
                text,
                style: Theme.of(context).primaryTextTheme.titleMedium,
              ),
            ),
            onPressed: onPressed,
          );
  }
}
