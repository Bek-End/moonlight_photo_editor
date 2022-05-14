import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_editor_flutter2/core/colors/colors.dart';

import 'package:photo_editor_flutter2/core/widgets/buttons/round_selectable_widget.dart';

const double kMinHeightMainPanel = 145;
const double kMaxHeightMainPanel = 350;

class SlidingUpPanelWidget extends StatefulWidget {
  final Function(SelectableButtons) onTap;
  const SlidingUpPanelWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  State<SlidingUpPanelWidget> createState() => _SlidingUpPanelWidgetState();
}

class _SlidingUpPanelWidgetState extends State<SlidingUpPanelWidget> with AutomaticKeepAliveClientMixin {
  SelectableButtons currVal = SelectableButtons.none;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 48,
            bottom: 16,
          ),
          child: Wrap(
            children: [
              RoundSelectableWidget<SelectableButtons>(
                value: SelectableButtons.crop,
                groupValue: currVal,
                onPressed: (e) {
                  setState(() {
                    currVal = e;
                  });
                  widget.onTap(e);
                },
                child: SvgPicture.asset('assets/icons/crop_icon.svg'),
                subtitle: 'Crop',
              ),
              RoundSelectableWidget<SelectableButtons>(
                value: SelectableButtons.text,
                groupValue: currVal,
                onPressed: (e) {
                  setState(() {
                    currVal = e;
                  });
                  widget.onTap(e);
                },
                child: SvgPicture.asset('assets/icons/text.svg'),
                subtitle: 'Text',
              ),
              RoundSelectableWidget<SelectableButtons>(
                value: SelectableButtons.emojis,
                groupValue: currVal,
                onPressed: (e) {
                  setState(() {
                    currVal = e;
                  });
                  widget.onTap(e);
                },
                child: const Icon(
                  PhosphorIcons.smiley_sticker_thin,
                  color: kWhite,
                  size: 24,
                ),
                subtitle: 'Emojis',
              ),
              RoundSelectableWidget<SelectableButtons>(
                value: SelectableButtons.eraser,
                groupValue: currVal,
                onPressed: (e) {
                  setState(() {
                    currVal = e;
                  });
                  widget.onTap(e);
                },
                child: SvgPicture.asset('assets/icons/eraser.svg'),
                subtitle: 'Eraser',
              ),
              RoundSelectableWidget<SelectableButtons>(
                value: SelectableButtons.pencil,
                groupValue: currVal,
                onPressed: (e) {
                  setState(() {
                    currVal = e;
                  });
                  widget.onTap(e);
                },
                child: SvgPicture.asset('assets/icons/pen.svg'),
                subtitle: 'Pencil',
              ),
              RoundSelectableWidget<SelectableButtons>(
                value: SelectableButtons.addPhoto,
                groupValue: currVal,
                onPressed: (e) {
                  setState(() {
                    currVal = e;
                  });
                  widget.onTap(e);
                },
                child: const Icon(
                  PhosphorIcons.image_thin,
                  color: kWhite,
                ),
                subtitle: 'Add',
              ),
              RoundSelectableWidget<SelectableButtons>(
                value: SelectableButtons.line,
                groupValue: currVal,
                onPressed: (e) {
                  setState(() {
                    currVal = e;
                  });
                  widget.onTap(e);
                },
                child: SvgPicture.asset('assets/icons/minus.svg'),
                subtitle: 'Line',
              ),
              RoundSelectableWidget<SelectableButtons>(
                value: SelectableButtons.arrow,
                groupValue: currVal,
                onPressed: (e) {
                  setState(() {
                    currVal = e;
                  });
                  widget.onTap(e);
                },
                child: SvgPicture.asset('assets/icons/arrow.svg'),
                subtitle: 'Arrow',
              ),
              RoundSelectableWidget<SelectableButtons>(
                value: SelectableButtons.circle,
                groupValue: currVal,
                onPressed: (e) {
                  setState(() {
                    currVal = e;
                  });
                  widget.onTap(e);
                },
                child: SvgPicture.asset('assets/icons/circle.svg'),
                subtitle: 'Circle',
              ),
              RoundSelectableWidget<SelectableButtons>(
                value: SelectableButtons.square,
                groupValue: currVal,
                onPressed: (e) {
                  setState(() {
                    currVal = e;
                  });
                  widget.onTap(e);
                },
                child: SvgPicture.asset('assets/icons/box.svg'),
                subtitle: 'Square',
              ),
              RoundSelectableWidget<SelectableButtons>(
                value: SelectableButtons.filter,
                groupValue: currVal,
                onPressed: (e) {
                  setState(() {
                    currVal = e;
                  });
                  widget.onTap(e);
                },
                child: const Icon(
                  PhosphorIcons.palette_thin,
                  color: kWhite,
                ),
                subtitle: 'Filters',
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
