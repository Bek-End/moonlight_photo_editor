import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import 'package:photo_editor_flutter2/core/widgets/buttons/round_button.dart';
import 'package:photo_editor_flutter2/core/widgets/buttons/text_button.dart';

const double kMinHeightAddPhotoPanel = 175;

class AddPhotoPanel extends StatelessWidget {
  final Function() onCancel;
  final Function() onCameraTap;
  final Function() onGalleryTap;
  final Function() onDrawingTap;
  const AddPhotoPanel({
    Key? key,
    required this.onCancel,
    required this.onCameraTap,
    required this.onGalleryTap,
    required this.onDrawingTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 15,
            bottom: 16,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                      onPressed: onCancel,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 18,
                  right: 18,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RoundButton(
                      child: SvgPicture.asset('assets/icons/camera_icon.svg'),
                      subtitle: 'Camera',
                      onPressed: onCameraTap,
                    ),
                    RoundButton(
                      child: SvgPicture.asset('assets/icons/gallery_icon.svg'),
                      subtitle: 'Gallery',
                      onPressed: onGalleryTap,
                    ),
                    RoundButton(
                      child: SvgPicture.asset('assets/icons/pencil_icon.svg'),
                      subtitle: 'Drawing',
                      onPressed: onDrawingTap,
                    ),
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
