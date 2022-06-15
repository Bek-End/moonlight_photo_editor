import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_painter/flutter_painter.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_editor_flutter2/features/filter_screen/filter_screen.dart';
import 'package:photo_editor_flutter2/features/main_page/widgets/add_photo_panel.dart';
import 'package:photofilters/filters/preset_filters.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path/path.dart' as path;
import 'package:image/image.dart' as imageLib;
import 'package:photo_editor_flutter2/core/colors/colors.dart';
import 'package:photo_editor_flutter2/core/theme/light_theme.dart';
import 'package:photo_editor_flutter2/core/widgets/buttons/round_selectable_widget.dart';
import 'package:photo_editor_flutter2/core/widgets/buttons/text_button.dart';
import 'package:photo_editor_flutter2/features/main_page/widgets/emodji_panel.dart';
import 'package:photo_editor_flutter2/features/main_page/widgets/eraser_panel.dart';
import 'package:photo_editor_flutter2/features/main_page/widgets/pencil_panel.dart';
import 'package:photo_editor_flutter2/features/main_page/widgets/shape_panel.dart';
import 'package:photo_editor_flutter2/features/main_page/widgets/sliding_panel_container.dart';
import 'package:photo_editor_flutter2/features/main_page/widgets/sliding_up_panel.dart';
import 'package:photo_editor_flutter2/features/main_page/widgets/sliding_up_text_panel.dart';

class MainPageScreen extends StatefulWidget {
  final File image;
  const MainPageScreen({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  State<MainPageScreen> createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen> {
  FocusNode textFocusNode = FocusNode();
  late PainterController controller;
  ui.Image? backgroundImage;
  Paint shapePaint = Paint()
    ..strokeWidth = 5
    ..color = kOrange
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

  SelectableButtons currVal = SelectableButtons.none;
  final PageController pageController = PageController();
  late File currImageFile = widget.image;
  double kMinHeight = kMinHeightMainPanel;
  double kMaxHeight = kMaxHeightMainPanel;

  @override
  void initState() {
    super.initState();
    controller = PainterController(
      settings: PainterSettings(
        text: TextSettings(
          focusNode: textFocusNode,
          textStyle: const TextStyle(fontWeight: FontWeight.bold, color: kOrange, fontSize: 18),
        ),
        freeStyle: const FreeStyleSettings(
          color: kOrange,
          strokeWidth: 5,
        ),
        shape: ShapeSettings(
          paint: shapePaint,
        ),
        scale: const ScaleSettings(
          enabled: true,
          minScale: 1,
          maxScale: 5,
        ),
      ),
    );
    // Listen to focus events of the text field
    textFocusNode.addListener(onFocus);
    // Initialize background
    initBackground();
  }

  /// Fetches image from an [ImageProvider] (in this example, [NetworkImage])
  /// to use it as a background
  void initBackground() async {
    // Extension getter (.image) to get [ui.Image] from [ImageProvider]
    final image = await FileImage(currImageFile).image;
    setState(() {
      backgroundImage = image;
      controller.background = image.backgroundDrawable;
    });
  }

  /// Updates UI when the focus changes
  void onFocus() {
    if (controller.selectedObjectDrawable is TextDrawable) {
      setState(
        () {
          kMinHeight = kMinHeightTextPanel;
          kMaxHeight = kMaxHeightTextPanel;
        },
      );
      pageController.jumpToPage(
        1,
      );
    } else {
      setState(() {});
    }
  }

  late List<Widget> actualPageViewChildren = [pageViewChildren[0]];

  late final List<Widget> pageViewChildren = [
    SlidingUpPanelWidget(
      onTap: (e) async {
        switch (e) {
          case SelectableButtons.text:
            actualPageViewChildren = [];
            actualPageViewChildren.add(pageViewChildren[0]);
            actualPageViewChildren.add(pageViewChildren[1]);
            addText();
            setState(
              () {
                kMinHeight = kMinHeightTextPanel;
                kMaxHeight = kMaxHeightTextPanel;
              },
            );
            pageController.animateToPage(
              1,
              curve: Curves.easeIn,
              duration: const Duration(
                milliseconds: 300,
              ),
            );
            break;
          case SelectableButtons.emojis:
            actualPageViewChildren = [];
            actualPageViewChildren.add(pageViewChildren[0]);
            actualPageViewChildren.add(pageViewChildren[2]);
            setState(
              () {
                kMinHeight = kMinHeightEmodjiPanel;
                kMaxHeight = kMaxHeightEmodjiPanel;
              },
            );
            pageController.animateToPage(
              1,
              curve: Curves.easeIn,
              duration: const Duration(
                milliseconds: 300,
              ),
            );
            break;
          case SelectableButtons.crop:
            final res = await ImageCropper().cropImage(
              sourcePath: currImageFile.absolute.path,
            );
            if (res != null) {
              currImageFile = File(res.path);
              initBackground();
            }
            break;
          case SelectableButtons.eraser:
            actualPageViewChildren = [];
            actualPageViewChildren.add(pageViewChildren[0]);
            actualPageViewChildren.add(pageViewChildren[3]);
            toggleFreeStyleErase();
            setState(() {
              kMinHeight = kMinHeightEraserPanel;
              kMaxHeight = kMinHeightEraserPanel;
            });
            pageController.animateToPage(
              1,
              curve: Curves.easeIn,
              duration: const Duration(
                milliseconds: 300,
              ),
            );
            break;
          case SelectableButtons.pencil:
            actualPageViewChildren = [];
            actualPageViewChildren.add(pageViewChildren[0]);
            actualPageViewChildren.add(pageViewChildren[4]);
            toggleFreeStyleDraw();
            setState(() {
              kMinHeight = kMinHeightTextPanel;
              kMaxHeight = kMaxHeightTextPanel;
            });
            pageController.animateToPage(
              1,
              curve: Curves.easeIn,
              duration: const Duration(
                milliseconds: 300,
              ),
            );
            break;
          case SelectableButtons.addPhoto:
            actualPageViewChildren = [];
            actualPageViewChildren.add(pageViewChildren[0]);
            actualPageViewChildren.add(pageViewChildren[5]);
            setState(() {
              kMinHeight = kMinHeightAddPhotoPanel;
              kMaxHeight = kMinHeightAddPhotoPanel;
            });
            pageController.animateToPage(
              1,
              curve: Curves.easeIn,
              duration: const Duration(
                milliseconds: 300,
              ),
            );
            break;
          case SelectableButtons.line:
            actualPageViewChildren = [];
            actualPageViewChildren.add(pageViewChildren[0]);
            actualPageViewChildren.add(pageViewChildren[6]);
            selectShape(LineFactory());
            setState(() {
              kMinHeight = kMinHeightTextPanel;
              kMaxHeight = kMaxHeightTextPanel;
            });
            pageController.animateToPage(
              1,
              curve: Curves.easeIn,
              duration: const Duration(
                milliseconds: 300,
              ),
            );
            break;
          case SelectableButtons.arrow:
            actualPageViewChildren = [];
            actualPageViewChildren.add(pageViewChildren[0]);
            actualPageViewChildren.add(pageViewChildren[6]);
            selectShape(ArrowFactory());
            setState(() {
              kMinHeight = kMinHeightTextPanel;
              kMaxHeight = kMaxHeightTextPanel;
            });
            pageController.animateToPage(
              1,
              curve: Curves.easeIn,
              duration: const Duration(
                milliseconds: 300,
              ),
            );
            break;
          case SelectableButtons.circle:
            actualPageViewChildren = [];
            actualPageViewChildren.add(pageViewChildren[0]);
            actualPageViewChildren.add(pageViewChildren[6]);
            selectShape(OvalFactory());
            setState(() {
              kMinHeight = kMinHeightTextPanel;
              kMaxHeight = kMaxHeightTextPanel;
            });
            pageController.animateToPage(
              1,
              curve: Curves.easeIn,
              duration: const Duration(
                milliseconds: 300,
              ),
            );
            break;
          case SelectableButtons.square:
            actualPageViewChildren = [];
            actualPageViewChildren.add(pageViewChildren[0]);
            actualPageViewChildren.add(pageViewChildren[6]);
            selectShape(RectangleFactory());
            setState(() {
              kMinHeight = kMinHeightTextPanel;
              kMaxHeight = kMaxHeightTextPanel;
            });
            pageController.animateToPage(
              1,
              curve: Curves.easeIn,
              duration: const Duration(
                milliseconds: 300,
              ),
            );
            break;
          case SelectableButtons.none:
            break;
          case SelectableButtons.filter:
            final fileName = path.basename(currImageFile.path);
            var imageL = imageLib.decodeImage(currImageFile.readAsBytesSync());
            imageL = imageLib.copyResize(imageL!, width: 600);
            Map? imagefile = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PhotoFilterScreen(
                  image: imageL!,
                  filters: presetFiltersList,
                  filename: fileName,
                  loader: const Center(child: CircularProgressIndicator()),
                  fit: BoxFit.contain,
                ),
              ),
            );
            if (imagefile != null) {
              if (imagefile.containsKey('image_filtered')) {
                currImageFile = imagefile['image_filtered'];
                initBackground();
              }
            }
            break;
        }
      },
    ),
    SlidingUpTextPanel(
      controller: controller,
      onSave: () {
        setState(() {
          kMinHeight = kMinHeightMainPanel;
          kMaxHeight = kMaxHeightMainPanel;
        });
        pageController.animateToPage(
          0,
          curve: Curves.easeIn,
          duration: const Duration(
            milliseconds: 300,
          ),
        );
      },
      onCancel: () {
        setState(() {
          kMinHeight = kMinHeightMainPanel;
          kMaxHeight = kMaxHeightMainPanel;
        });
        pageController.animateToPage(
          0,
          curve: Curves.easeIn,
          duration: const Duration(
            milliseconds: 300,
          ),
        );
      },
    ),
    EmodjiPanel(
      onCancel: () {
        setState(() {
          kMinHeight = kMinHeightMainPanel;
          kMaxHeight = kMaxHeightMainPanel;
        });
        pageController.animateToPage(
          0,
          curve: Curves.easeIn,
          duration: const Duration(
            milliseconds: 300,
          ),
        );
      },
      onTap: (e) {
        setState(() {
          kMinHeight = kMinHeightMainPanel;
          kMaxHeight = kMaxHeightMainPanel;
        });
        pageController.animateToPage(
          0,
          curve: Curves.easeIn,
          duration: const Duration(
            milliseconds: 300,
          ),
        );
        controller.addDrawables(
          [
            TextDrawable(
              text: e,
              position: Offset(
                MediaQuery.of(context).size.width / 2,
                MediaQuery.of(context).size.height / 3,
              ),
            ),
          ],
        );
      },
    ),
    EraserPanel(
      controller: controller,
      onCancel: () {
        toggleFreeStyleErase();
        setState(() {
          kMinHeight = kMinHeightMainPanel;
          kMaxHeight = kMaxHeightMainPanel;
        });
        pageController.animateToPage(
          0,
          curve: Curves.easeIn,
          duration: const Duration(
            milliseconds: 300,
          ),
        );
      },
      onSave: () {
        toggleFreeStyleErase();
        setState(() {
          kMinHeight = kMinHeightMainPanel;
          kMaxHeight = kMaxHeightMainPanel;
        });
        pageController.animateToPage(
          0,
          curve: Curves.easeIn,
          duration: const Duration(
            milliseconds: 300,
          ),
        );
      },
    ),
    PencilPanel(
      controller: controller,
      onCancel: () {
        toggleFreeStyleDraw();
        setState(() {
          kMinHeight = kMinHeightMainPanel;
          kMaxHeight = kMaxHeightMainPanel;
        });
        pageController.animateToPage(
          0,
          curve: Curves.easeIn,
          duration: const Duration(
            milliseconds: 300,
          ),
        );
      },
      onSave: () {
        toggleFreeStyleDraw();
        setState(() {
          kMinHeight = kMinHeightMainPanel;
          kMaxHeight = kMaxHeightMainPanel;
        });
        pageController.animateToPage(
          0,
          curve: Curves.easeIn,
          duration: const Duration(
            milliseconds: 300,
          ),
        );
      },
    ),
    AddPhotoPanel(
      onCancel: () {
        setState(() {
          kMinHeight = kMinHeightMainPanel;
          kMaxHeight = kMaxHeightMainPanel;
        });
        pageController.animateToPage(
          0,
          curve: Curves.easeIn,
          duration: const Duration(
            milliseconds: 300,
          ),
        );
      },
      onCameraTap: () async {
        final image = await ImagePicker().pickImage(
          source: ImageSource.camera,
        );
        if (image != null) {
          addPhoto(File(image.path));
        }
      },
      onGalleryTap: () async {
        final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );
        if (image != null) {
          addPhoto(File(image.path));
        }
      },
      onDrawingTap: () async {
        File f = await getImageFileFromAssets(
          'images/white_screen.jpeg',
        );
        addPhoto(f);
      },
    ),
    ShapePanel(
      onCancel: () {
        setState(() {
          kMinHeight = kMinHeightMainPanel;
          kMaxHeight = kMaxHeightMainPanel;
        });
        pageController.animateToPage(
          0,
          curve: Curves.easeIn,
          duration: const Duration(
            milliseconds: 300,
          ),
        );
      },
      onSave: () {
        setState(() {
          kMinHeight = kMinHeightMainPanel;
          kMaxHeight = kMaxHeightMainPanel;
        });
        pageController.animateToPage(
          0,
          curve: Curves.easeIn,
          duration: const Duration(
            milliseconds: 300,
          ),
        );
      },
      controller: controller,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        renderAndDiscard();
        return false;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, kToolbarHeight),
          child: ValueListenableBuilder<PainterControllerValue>(
            valueListenable: controller,
            builder: (context, _, child) {
              return AppBar(
                backgroundColor: Theme.of(context).primaryColor,
                leading: CustomTextButton(
                  child: SvgPicture.asset('assets/icons/arrow_back.svg'),
                  onPressed: () {
                    renderAndDiscard();
                  },
                ),
                actions: [
                  CupertinoTheme(
                    data: cupertinoTheme,
                    child: CustomTextButton(
                      child: const Icon(PhosphorIcons.trash_light),
                      onPressed: controller.selectedObjectDrawable == null ? null : removeSelectedDrawable,
                    ),
                  ),
                  CupertinoTheme(
                    data: cupertinoTheme,
                    child: CustomTextButton(
                      child: const Icon(Icons.flip_sharp),
                      onPressed: controller.selectedObjectDrawable != null &&
                              controller.selectedObjectDrawable is ImageDrawable
                          ? flipSelectedImageDrawable
                          : null,
                    ),
                  ),
                  CupertinoTheme(
                    data: cupertinoTheme,
                    child: CustomTextButton(
                      child: const Icon(
                        PhosphorIcons.arrow_clockwise_light,
                      ),
                      onPressed: controller.canRedo ? redo : null,
                    ),
                  ),
                  CupertinoTheme(
                    data: cupertinoTheme,
                    child: CustomTextButton(
                      child: const Icon(
                        PhosphorIcons.arrow_counter_clockwise_light,
                      ),
                      onPressed: controller.canUndo ? undo : null,
                    ),
                  ),
                  if (!Platform.isMacOS)
                    CustomTextButton(
                      child: SvgPicture.asset('assets/icons/save_icon.svg'),
                      onPressed: renderAndDisplayImage,
                    ),
                  CustomTextButton(
                    child: SvgPicture.asset('assets/icons/share_icon.svg'),
                    onPressed: () async {
                      final file = await getRendedredImage(await renderImage());
                      Share.shareFiles([file!.path]);
                    },
                  ),
                ],
              );
            },
          ),
        ),
        body: Stack(
          children: [
            if (backgroundImage != null)
              Positioned.fill(
                bottom: MediaQuery.of(context).size.height * 0.2,
                child: Center(
                  child: AspectRatio(
                    aspectRatio: backgroundImage!.width / backgroundImage!.height,
                    child: FlutterPainter(
                      controller: controller,
                      onDrawableCreated: (e) {
                        if (e is ShapeDrawable) {
                          setState(() {
                            kMinHeight = kMinHeightMainPanel;
                            kMaxHeight = kMaxHeightMainPanel;
                          });
                          pageController.animateToPage(
                            0,
                            curve: Curves.easeIn,
                            duration: const Duration(
                              milliseconds: 300,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            SlidingPanelContainer(
              maxHeight: kMaxHeight,
              minHeight: kMinHeight,
              child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: actualPageViewChildren,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addPhoto(File file) async {
    controller.addImage(await FileImage(file).image, const Size(150, 150));
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

  void selectShape(ShapeFactory? factory) {
    controller.shapeFactory = factory;
  }

  void toggleFreeStyleErase() {
    controller.freeStyleMode =
        controller.freeStyleMode != FreeStyleMode.erase ? FreeStyleMode.erase : FreeStyleMode.none;
  }

  void toggleFreeStyleDraw() {
    controller.freeStyleMode = controller.freeStyleMode != FreeStyleMode.draw ? FreeStyleMode.draw : FreeStyleMode.none;
  }

  void addText() {
    if (controller.freeStyleMode != FreeStyleMode.none) {
      controller.freeStyleMode = FreeStyleMode.none;
    }
    print(controller.textSettings.focusNode);
    controller.addText();
  }

  void flipSelectedImageDrawable() {
    final imageDrawable = controller.selectedObjectDrawable;
    if (imageDrawable is! ImageDrawable) return;
    controller.replaceDrawable(imageDrawable, imageDrawable.copyWith(flipped: !imageDrawable.flipped));
  }

  void undo() {
    controller.undo();
  }

  void redo() {
    controller.redo();
  }

  void removeSelectedDrawable() {
    final selectedDrawable = controller.selectedObjectDrawable;
    if (selectedDrawable != null) controller.removeDrawable(selectedDrawable);
  }

  Future<Uint8List?> renderImage() async {
    final backgroundImageSize = Size(backgroundImage!.width.toDouble(), backgroundImage!.height.toDouble());
    final imageFuture =
        controller.renderImage(backgroundImageSize).then<Uint8List?>((ui.Image image) => image.pngBytes);
    return imageFuture;
  }

  renderAndDiscard() async {
    if (backgroundImage == null) return;
    final backgroundImageSize = Size(backgroundImage!.width.toDouble(), backgroundImage!.height.toDouble());
    final imageFuture = controller.renderImage(backgroundImageSize).then<Uint8List?>(
          (ui.Image image) => image.pngBytes,
        );
    final res = await showDialog<bool>(
      context: context,
      builder: (context) => RenderDiscardImageDialog(imageFuture: imageFuture),
    );
    if (res != null) {
      if (res) {
        Navigator.pop(context);
      }
    }
  }

  void renderAndDisplayImage() async {
    if (backgroundImage == null) return;
    final backgroundImageSize = Size(backgroundImage!.width.toDouble(), backgroundImage!.height.toDouble());
    final imageFuture = controller.renderImage(backgroundImageSize).then<Uint8List?>(
          (ui.Image image) => image.pngBytes,
        );
    final res = await showDialog<bool>(
      context: context,
      builder: (context) => RenderedImageDialog(imageFuture: imageFuture),
    );
    if (res != null) {
      if (res) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: const [
                Icon(
                  PhosphorIcons.check_fill,
                  color: kWhite,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Saved successfully to Photos :)',
                ),
              ],
            ),
            backgroundColor: kGreen,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<File?> getRendedredImage(Uint8List? image) async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = await File('${directory.path}/${DateTime.now().microsecondsSinceEpoch}.png').create();
    final f = await imagePath.writeAsBytes(image!);
    return f;
  }
}

class RenderDiscardImageDialog extends StatelessWidget {
  final Future<Uint8List?> imageFuture;
  const RenderDiscardImageDialog({
    Key? key,
    required this.imageFuture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? AlertDialog(
            title: const Text(
              "Do you want to save the changes?",
            ),
            content: FutureBuilder<Uint8List?>(
              future: imageFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const SizedBox(
                    height: 50,
                    child: Center(child: CircularProgressIndicator.adaptive()),
                  );
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return const SizedBox();
                }
                return InteractiveViewer(maxScale: 10, child: Image.memory(snapshot.data!));
              },
            ),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () async {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: const Text(
                  'Discard',
                  style: TextStyle(color: kRed),
                ),
                onPressed: () async {
                  Navigator.of(context).pop(true);
                },
              ),
              TextButton(
                child: const Text('Save'),
                onPressed: () async {
                  final renderFile = await imageFuture;
                  final directory = await getApplicationDocumentsDirectory();
                  final imagePath =
                      await File('${directory.path}/${DateTime.now().microsecondsSinceEpoch}.png').create();
                  final f = await imagePath.writeAsBytes(renderFile!);
                  final res = await GallerySaver.saveImage(
                    f.path,
                  );
                  Navigator.of(context).pop(res!);
                },
              ),
            ],
          )
        : CupertinoAlertDialog(
            title: const Text(
              "Do you want to save the changes?",
            ),
            content: FutureBuilder<Uint8List?>(
              future: imageFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const SizedBox(
                    height: 50,
                    child: Center(child: CircularProgressIndicator.adaptive()),
                  );
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return const SizedBox();
                }
                return InteractiveViewer(maxScale: 10, child: Image.memory(snapshot.data!));
              },
            ),
            actions: [
              CupertinoDialogAction(
                child: const Text('Cancel'),
                onPressed: () async {
                  Navigator.of(context).pop(false);
                },
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: const Text('Discard'),
                onPressed: () async {
                  Navigator.of(context).pop(true);
                },
              ),
              CupertinoDialogAction(
                child: const Text('Save'),
                onPressed: () async {
                  final renderFile = await imageFuture;
                  final directory = await getApplicationDocumentsDirectory();
                  final imagePath =
                      await File('${directory.path}/${DateTime.now().microsecondsSinceEpoch}.png').create();
                  final f = await imagePath.writeAsBytes(renderFile!);
                  final res = await GallerySaver.saveImage(
                    f.path,
                  );
                  Navigator.of(context).pop(res!);
                },
              ),
            ],
          );
  }
}

class RenderedImageDialog extends StatelessWidget {
  final Future<Uint8List?> imageFuture;

  const RenderedImageDialog({Key? key, required this.imageFuture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? AlertDialog(
            title: const Text("Rendered Image"),
            content: FutureBuilder<Uint8List?>(
              future: imageFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const SizedBox(
                    height: 50,
                    child: Center(child: CircularProgressIndicator.adaptive()),
                  );
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return const SizedBox();
                }
                return InteractiveViewer(maxScale: 10, child: Image.memory(snapshot.data!));
              },
            ),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () async {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: const Text('Save'),
                onPressed: () async {
                  final renderFile = await imageFuture;
                  final directory = await getApplicationDocumentsDirectory();
                  final imagePath =
                      await File('${directory.path}/${DateTime.now().microsecondsSinceEpoch}.png').create();
                  final f = await imagePath.writeAsBytes(renderFile!);
                  final res = await GallerySaver.saveImage(
                    f.path,
                  );
                  Navigator.of(context).pop(res!);
                },
              ),
            ],
          )
        : CupertinoAlertDialog(
            title: const Text("Rendered Image"),
            content: FutureBuilder<Uint8List?>(
              future: imageFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const SizedBox(
                    height: 50,
                    child: Center(child: CircularProgressIndicator.adaptive()),
                  );
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return const SizedBox();
                }
                return InteractiveViewer(maxScale: 10, child: Image.memory(snapshot.data!));
              },
            ),
            actions: [
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: const Text('Cancel'),
                onPressed: () async {
                  Navigator.of(context).pop(false);
                },
              ),
              CupertinoDialogAction(
                child: const Text('Save'),
                onPressed: () async {
                  final renderFile = await imageFuture;
                  final directory = await getApplicationDocumentsDirectory();
                  final imagePath =
                      await File('${directory.path}/${DateTime.now().microsecondsSinceEpoch}.png').create();
                  final f = await imagePath.writeAsBytes(renderFile!);
                  final res = await GallerySaver.saveImage(
                    f.path,
                  );
                  Navigator.of(context).pop(res!);
                },
              ),
            ],
          );
  }
}
