import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_editor_flutter2/core/util/emodjis.dart';
import 'package:photo_editor_flutter2/core/widgets/buttons/text_button.dart';

const double kMaxHeightEmodjiPanel = 505;
const double kMinHeightEmodjiPanel = 175;

class EmodjiPanel extends StatelessWidget {
  final Function() onCancel;
  final Function(String) onTap;
  const EmodjiPanel({
    Key? key,
    required this.onCancel,
    required this.onTap,
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
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                height: 410,
                child: GridView(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    maxCrossAxisExtent: 40.0,
                  ),
                  children: getSmileys().map(
                    (String emoji) {
                      return GridTile(
                        child: GestureDetector(
                          onTap: () {
                            onTap(emoji);
                          },
                          child: Text(
                            emoji,
                            style: const TextStyle(fontSize: 35),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
