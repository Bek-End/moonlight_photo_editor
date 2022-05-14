import 'package:flutter/material.dart';
import 'package:flutter_painter/flutter_painter.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:photo_editor_flutter2/core/widgets/buttons/colorful_button.dart';
import 'package:photo_editor_flutter2/core/widgets/buttons/round_selectable_widget.dart';
import 'package:photo_editor_flutter2/core/widgets/buttons/selectable_button.dart';
import 'package:photo_editor_flutter2/core/widgets/buttons/text_button.dart';
import 'dart:ui' as ui;

const double kMinHeightTextPanel = 145;
const double kMaxHeightTextPanel = 335;

enum TextStructTypeEnum {
  regular,
  bold,
  italic,
  underline,
  none,
  secondTime,
}

enum TextAligntMent {
  left,
  center,
  right,
  full,
}

class SlidingUpTextPanel extends StatefulWidget {
  final Function() onCancel;
  final Function() onSave;
  final PainterController controller;
  const SlidingUpTextPanel({
    Key? key,
    required this.onCancel,
    required this.onSave,
    required this.controller,
  }) : super(key: key);

  @override
  State<SlidingUpTextPanel> createState() => _SlidingUpTextPanelState();
}

class _SlidingUpTextPanelState extends State<SlidingUpTextPanel> {
  List<Color> colors = [Colors.white] + Colors.primaries + [Colors.black];
  late List<
      TextStyle Function({
    TextStyle? textStyle,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<ui.Shadow>? shadows,
    List<ui.FontFeature>? fontFeatures,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
  })> fontValues = GoogleFonts.asMap().values.toList();
  late Color currValue = colors[0];
  late String currFontKey = GoogleFonts.asMap().keys.toList()[0];
  List<TextStructTypeEnum> currStructValue = [];
  TextAligntMent currTextAlignValue = TextAligntMent.left;
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
                        widget.controller.textFocusNode!.unfocus();
                        setState(() {});
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
                      widget.controller.textStyle = widget.controller.textStyle.copyWith(
                        color: e,
                      );
                    },
                    value: colors[index],
                    groupvalue: currValue,
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: GoogleFonts.asMap().length,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: SelectableButton<String>(
                        value: GoogleFonts.asMap().keys.toList()[index],
                        groupValue: currFontKey,
                        onPressed: (e) {
                          setState(() {
                            currFontKey = e;
                          });
                          widget.controller.textStyle = GoogleFonts.asMap().values.toList()[index](
                            textStyle: widget.controller.textStyle,
                          );
                        },
                        text: GoogleFonts.asMap().keys.toList()[index],
                        textStyle: GoogleFonts.asMap().values.toList()[index](),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: Row(
                  children: [
                    Row(
                      children: [
                        RoundMultiSelectableWidget(
                          value: TextStructTypeEnum.bold,
                          groupValue: currStructValue,
                          onPressed: (e) {
                            if (e == TextStructTypeEnum.secondTime) {
                              setState(() {
                                currStructValue.remove(TextStructTypeEnum.bold);
                              });
                              widget.controller.textStyle = widget.controller.textStyle.copyWith(
                                fontWeight: FontWeight.normal,
                              );
                            } else {
                              setState(() {
                                currStructValue.add(e);
                              });
                              widget.controller.textStyle = widget.controller.textStyle.copyWith(
                                fontWeight: FontWeight.bold,
                              );
                            }
                          },
                          child: Text(
                            'B',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        RoundMultiSelectableWidget(
                          value: TextStructTypeEnum.italic,
                          groupValue: currStructValue,
                          onPressed: (e) {
                            if (e == TextStructTypeEnum.secondTime) {
                              setState(() {
                                currStructValue.remove(TextStructTypeEnum.italic);
                                widget.controller.textStyle = widget.controller.textStyle.copyWith(
                                  fontStyle: FontStyle.normal,
                                );
                              });
                            } else {
                              setState(() {
                                currStructValue.add(e);
                              });
                              widget.controller.textStyle = widget.controller.textStyle.copyWith(
                                fontStyle: FontStyle.italic,
                              );
                            }
                          },
                          child: Text(
                            'T',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontStyle: FontStyle.italic,
                                ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        RoundMultiSelectableWidget(
                          value: TextStructTypeEnum.underline,
                          groupValue: currStructValue,
                          onPressed: (e) {
                            if (e == TextStructTypeEnum.secondTime) {
                              setState(() {
                                currStructValue.remove(TextStructTypeEnum.underline);
                              });
                              widget.controller.textStyle = widget.controller.textStyle.copyWith(
                                decoration: TextDecoration.none,
                              );
                            } else {
                              setState(() {
                                currStructValue.add(e);
                              });
                              widget.controller.textStyle = widget.controller.textStyle.copyWith(
                                decoration: TextDecoration.underline,
                              );
                            }
                          },
                          child: Text(
                            'U',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
