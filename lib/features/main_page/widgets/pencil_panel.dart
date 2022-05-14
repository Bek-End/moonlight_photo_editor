import 'package:flutter/material.dart';
import 'package:flutter_painter/flutter_painter.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:photo_editor_flutter2/core/widgets/buttons/colorful_button.dart';
import 'package:photo_editor_flutter2/core/widgets/buttons/text_button.dart';
import 'package:photo_editor_flutter2/core/widgets/sliders/sf_slider.dart';

class PencilPanel extends StatefulWidget {
  final Function() onCancel;
  final Function() onSave;
  final PainterController controller;

  const PencilPanel({
    Key? key,
    required this.onCancel,
    required this.onSave,
    required this.controller,
  }) : super(key: key);

  @override
  State<PencilPanel> createState() => _PencilPanelState();
}

class _PencilPanelState extends State<PencilPanel> {
  List<Color> colors = [Colors.white] + Colors.primaries + [Colors.black];
  late Color currValue = colors[0];
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
              SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  itemCount: colors.length,
                  itemBuilder: (context, index) => ColorfulButton<Color>(
                    color: colors[index],
                    onPressed: (e) {
                      setState(() {
                        currValue = e;
                      });
                      setFreeStyleColor(e);
                    },
                    value: colors[index],
                    groupvalue: currValue,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
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
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: SfSliderWidget(
                  min: 1,
                  max: 100,
                  onChanged: setFreeStyleOpacity,
                  label: 'Opacity',
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  void setFreeStyleOpacity(double value) {
    widget.controller.freeStyleColor = widget.controller.freeStyleColor.withOpacity(
      value / 100,
    );
  }

  void setFreeStyleStrokeWidth(double value) {
    widget.controller.freeStyleStrokeWidth = value;
  }

  void setFreeStyleColor(Color color) {
    widget.controller.freeStyleColor = color;
  }
}
