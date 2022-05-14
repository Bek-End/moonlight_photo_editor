import 'package:flutter/material.dart';
import 'package:glass/glass.dart';
import 'package:photo_editor_flutter2/features/main_page/widgets/sliding_up_panel.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:photo_editor_flutter2/core/colors/colors.dart';

class SlidingPanelContainer extends StatelessWidget {
  final Widget child;
  final double minHeight;
  final double maxHeight;
  const SlidingPanelContainer({
    Key? key,
    required this.child,
    this.minHeight = kMinHeightMainPanel,
    this.maxHeight = kMaxHeightMainPanel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      color: kTrans,
      panel: ClipRRect(
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
              child,
            ],
          ),
        ).asGlass(
          blurX: 15,
          blurY: 15,
          tintColor: kGreyLight,
        ),
      ),
      minHeight: minHeight,
      maxHeight: maxHeight,
    );
  }
}
