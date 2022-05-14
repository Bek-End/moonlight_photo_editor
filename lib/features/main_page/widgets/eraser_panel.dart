import 'package:flutter/material.dart';
import 'package:flutter_painter/flutter_painter.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:photo_editor_flutter2/core/widgets/buttons/text_button.dart';
import 'package:photo_editor_flutter2/core/widgets/sliders/sf_slider.dart';

const double kMinHeightEraserPanel = 145;

class EraserPanel extends StatefulWidget {
  final Function() onCancel;
  final Function() onSave;
  final PainterController controller;

  const EraserPanel({
    Key? key,
    required this.onCancel,
    required this.onSave,
    required this.controller,
  }) : super(key: key);

  @override
  State<EraserPanel> createState() => _EraserPanelState();
}

class _EraserPanelState extends State<EraserPanel> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 25,
            bottom: 16,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextButton(
                      child: SvgPicture.asset('assets/icons/x_icon.svg'),
                      onPressed: () {
                        widget.onCancel();
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: SfSliderWidget(
                  min: 1,
                  max: 100,
                  suffix: 'px',
                  onChanged: setFreeStyleStrokeWidth,
                  label: 'Size',
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  void setFreeStyleStrokeWidth(double value) {
    widget.controller.freeStyleStrokeWidth = value;
  }
}
