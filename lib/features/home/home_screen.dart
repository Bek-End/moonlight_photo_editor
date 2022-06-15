import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_editor_flutter2/core/colors/colors.dart';
import 'package:photo_editor_flutter2/core/widgets/buttons/round_button.dart';
import 'package:photo_editor_flutter2/core/widgets/buttons/text_button.dart';
import 'package:photo_editor_flutter2/features/home/bottom_sheet_widget.dart';
import 'package:photo_editor_flutter2/features/main_page/main_page_screen.dart';
import 'dart:async';
import 'package:expansion_widget/expansion_widget.dart';
import 'dart:math' as math;

import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              CustomTextButton(
                child: SvgPicture.asset('assets/icons/exclamation-circle.svg'),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: kTrans,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    builder: (context) => Wrap(
                      children: const [
                        BottomSheetWidget(
                          children: [
                            SizedBox(
                              height: 33,
                            ),
                            BottomSheetExpandedElement(
                              title: 'Savrulloev Sunnatjon',
                              subtitle: 'Lead project developer',
                              instaLink: 'https://www.instagram.com/sun_natjon/',
                              telegramLink: 'https://t.me/sun_nat_json',
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            BottomSheetExpandedElement(
                              title: 'Khusrav Khamidulloevich',
                              subtitle: 'Project UI/UX Designer',
                              instaLink: 'https://www.instagram.com/real_khusrav/',
                              telegramLink: 'https://t.me/khus_svr',
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            BottomSheetExpandedElement(
                              title: 'Milikeev Vadim',
                              subtitle: 'Project Manager',
                              instaLink: 'https://www.instagram.com/instagram/',
                              telegramLink:
                                  'https://i.pinimg.com/originals/44/e2/42/44e2422c7ecf1e9234c7fa4cdf03f060.jpg',
                            ),
                            SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 210,
                      width: 204,
                    ),
                    const SizedBox(
                      height: 95,
                    ),
                    Text(
                      'Tap the icons below to edit photos or draw something...',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 36,
          vertical: 24,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          color: Theme.of(context).primaryColorDark,
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (!Platform.isMacOS)
                RoundButton(
                  child: SvgPicture.asset('assets/icons/camera_icon.svg'),
                  subtitle: 'Camera',
                  onPressed: () async {
                    final image = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                    );
                    if (image != null) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MainPageScreen(
                            image: File(
                              image.path,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              RoundButton(
                child: SvgPicture.asset('assets/icons/gallery_icon.svg'),
                subtitle: 'Gallery',
                onPressed: () async {
                  if (Platform.isMacOS) {
                    FilePickerResult? result = await FilePicker.platform.pickFiles(
                      type: FileType.image,
                      allowedExtensions: ['jpg', 'jpeg', 'png'],
                    );
                    if (result != null) {
                      File file = File(result.files.single.path!);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MainPageScreen(
                            image: file,
                          ),
                        ),
                      );
                    } else {
                      // User canceled the picker
                    }
                  } else {
                    final image = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                    );
                    if (image != null) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MainPageScreen(
                            image: File(
                              image.path,
                            ),
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
              RoundButton(
                child: SvgPicture.asset('assets/icons/pencil_icon.svg'),
                subtitle: 'Drawing',
                onPressed: () async {
                  File f = await getImageFileFromAssets(
                    'images/white_screen.jpeg',
                  );
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MainPageScreen(
                        image: File(
                          f.path,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = await File('${directory.path}/${DateTime.now().microsecondsSinceEpoch}.png').create();
    final file = await imagePath.writeAsBytes(
      byteData.buffer.asInt8List(byteData.offsetInBytes, byteData.lengthInBytes),
    );
    return file;
  }
}
