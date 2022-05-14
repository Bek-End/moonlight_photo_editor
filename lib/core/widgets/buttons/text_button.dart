import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_editor_flutter2/core/colors/colors.dart';

class CustomTextButton extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;
  const CustomTextButton({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              shape: const CircleBorder(),
              minimumSize: const Size(50, 30),
              primary: kWhite,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: child,
          )
        : CupertinoButton(
            padding: EdgeInsets.zero,
            child: child,
            onPressed: onPressed,
          );
  }
}
