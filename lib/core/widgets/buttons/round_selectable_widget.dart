import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_editor_flutter2/features/main_page/widgets/sliding_up_text_panel.dart';

enum SelectableButtons {
  crop,
  text,
  line,
  pencil,
  eraser,
  arrow,
  circle,
  square,
  emojis,
  addPhoto,
  filter,
  none,
}

class RoundMultiSelectableWidget extends StatelessWidget {
  final TextStructTypeEnum value;
  final List<TextStructTypeEnum> groupValue;
  final Function(TextStructTypeEnum) onPressed;
  final Widget child;
  final String? subtitle;
  const RoundMultiSelectableWidget({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onPressed,
    required this.child,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        if (groupValue.contains(value)) {
          onPressed(TextStructTypeEnum.secondTime);
        } else {
          onPressed(value);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: groupValue.contains(value) ? Theme.of(context).focusColor : Theme.of(context).cardColor,
            ),
            child: child,
          ),
          if (subtitle != null)
            const SizedBox(
              height: 8,
            ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: Theme.of(context).textTheme.titleSmall,
            )
        ],
      ),
    );
  }
}

class RoundSelectableWidget<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final Function(T) onPressed;
  final Widget child;
  final String? subtitle;
  const RoundSelectableWidget({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onPressed,
    required this.child,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 14,
        left: 14,
        bottom: 24,
      ),
      child: Platform.isAndroid
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    primary: value == groupValue ? Theme.of(context).focusColor : Theme.of(context).cardColor,
                    shape: const CircleBorder(),
                  ),
                  onPressed: () {
                    onPressed(value);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: child,
                  ),
                ),
                if (subtitle != null)
                  const SizedBox(
                    height: 8,
                  ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.titleSmall,
                  )
              ],
            )
          : CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                onPressed(value);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: value == groupValue ? Theme.of(context).focusColor : Theme.of(context).cardColor,
                    ),
                    child: child,
                  ),
                  if (subtitle != null)
                    const SizedBox(
                      height: 8,
                    ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: Theme.of(context).textTheme.titleSmall,
                    )
                ],
              ),
            ),
    );
  }
}
