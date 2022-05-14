import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:photo_editor_flutter2/core/colors/colors.dart';

class SelectableButton<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final Function(T) onPressed;
  final String text;
  final TextStyle textStyle;
  const SelectableButton({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onPressed,
    required this.text,
    required this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 7,
              ),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              primary: groupValue == value ? kOrange : kWhite,
            ),
            onPressed: () {
              onPressed(value);
            },
            child: Text(
              text,
              style: value == groupValue ? textStyle.copyWith(color: kWhite) : textStyle.copyWith(color: kBlack),
            ),
          )
        : CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              onPressed(value);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: groupValue == value ? kOrange : kWhite,
              ),
              child: Text(
                text,
                style: value == groupValue ? textStyle.copyWith(color: kWhite) : textStyle.copyWith(color: kBlack),
              ),
            ),
          );
  }
}
