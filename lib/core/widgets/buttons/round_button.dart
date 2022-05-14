import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_editor_flutter2/core/colors/colors.dart';
import 'package:photo_editor_flutter2/core/util/platform_enum.dart';
import 'dart:io';

class RoundButton extends StatelessWidget {
  final Widget child;
  final Function() onPressed;
  final String subtitle;
  final PlatformOS platformOS;
  const RoundButton({
    Key? key,
    required this.child,
    required this.onPressed,
    required this.subtitle,
    this.platformOS = PlatformOS.ios,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                  primary: Theme.of(context).cardColor,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: const CircleBorder(),
                  elevation: 0,
                ),
                onPressed: onPressed,
                child: child,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.titleSmall,
              )
            ],
          )
        : CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: onPressed,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).cardColor,
                  ),
                  child: child,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.titleSmall,
                )
              ],
            ),
          );
  }
}
