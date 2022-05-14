import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'package:photo_editor_flutter2/core/colors/colors.dart';

class SfSliderWidget extends StatefulWidget {
  final double min;
  final double max;
  final String label;
  final String? suffix;
  final Function(double) onChanged;
  const SfSliderWidget({
    Key? key,
    required this.min,
    required this.max,
    required this.onChanged,
    required this.label,
    this.suffix,
  }) : super(key: key);

  @override
  State<SfSliderWidget> createState() => _SfSliderWidgetState();
}

class _SfSliderWidgetState extends State<SfSliderWidget> with AutomaticKeepAliveClientMixin {
  late double value = widget.min;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Row(
      children: [
        SizedBox(
          width: 64,
          child: Text(
            widget.label,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: kWhite),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: SfSlider(
            min: widget.min,
            minorTicksPerInterval: 1,
            max: widget.max,
            activeColor: kWhite,
            inactiveColor: kGrey,
            value: value,
            onChanged: (e) {
              widget.onChanged(e as double);
              setState(() {
                value = e;
              });
            },
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Text(
          '${value.floor()} ${widget.suffix ?? ''}',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: kWhite),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
