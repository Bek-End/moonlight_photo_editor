import 'package:flutter/material.dart';
import 'package:flutter_painter/flutter_painter.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:photo_editor_flutter2/core/widgets/buttons/colorful_button.dart';
import 'package:photo_editor_flutter2/core/widgets/buttons/selectable_button.dart';
import 'package:photo_editor_flutter2/core/widgets/buttons/text_button.dart';
import 'package:photo_editor_flutter2/core/widgets/sliders/sf_slider.dart';

enum ShapeType {
  fill,
  stroke,
}

class ShapePanel extends StatefulWidget {
  final Function() onCancel;
  final Function() onSave;
  final PainterController controller;

  const ShapePanel({
    Key? key,
    required this.onCancel,
    required this.onSave,
    required this.controller,
  }) : super(key: key);

  @override
  State<ShapePanel> createState() => _ShapePanelState();
}

class _ShapePanelState extends State<ShapePanel> {
  List<Color> colors = [Colors.white] + Colors.primaries + [Colors.black];
  late Color currValue = colors[0];
  PaintingStyle currShapeType = PaintingStyle.stroke;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.controller,
      builder: (context, _, __) {
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
                      mainAxisAlignment: MainAxisAlignment.start,
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
                          setShapeColor(e);
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
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      children: [
                        SelectableButton<PaintingStyle>(
                          value: PaintingStyle.fill,
                          groupValue: currShapeType,
                          onPressed: (e) {
                            setState(() {
                              currShapeType = e;
                            });
                            setShapeStrokeType(e);
                          },
                          text: 'Fill',
                          textStyle: Theme.of(context).textTheme.bodyMedium!,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        SelectableButton<PaintingStyle>(
                          value: PaintingStyle.stroke,
                          groupValue: currShapeType,
                          onPressed: (e) {
                            setState(() {
                              currShapeType = e;
                            });
                            setShapeStrokeType(e);
                          },
                          text: 'Stroke',
                          textStyle: Theme.of(context).textTheme.bodyMedium!,
                        ),
                      ],
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
                      onChanged: setShapeStrokeWidth,
                      label: 'Size',
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  void setShapeStrokeWidth(double value) {
    setState(() {
      widget.controller.shapePaint = widget.controller.shapePaint!.copyWith(
        strokeWidth: value,
      );
    });
  }

  void setShapeColor(Color color) {
    setState(() {
      widget.controller.shapePaint = widget.controller.shapePaint!.copyWith(color: color);
    });
  }

  void setShapeStrokeType(PaintingStyle style) {
    setState(() {
      widget.controller.shapePaint = widget.controller.shapePaint!.copyWith(
        style: style,
      );
    });
  }
}
