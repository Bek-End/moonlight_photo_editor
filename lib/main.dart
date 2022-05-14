import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:photo_editor_flutter2/core/colors/colors.dart';
import 'package:photo_editor_flutter2/core/theme/light_theme.dart';
import 'package:photo_editor_flutter2/features/home/home_screen.dart';
import 'package:photo_editor_flutter2/features/onboarding/onboarding_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoonLight Photo Editor',
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: IsFirstRun.isFirstRun(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return const Scaffold(
                backgroundColor: kBlack,
                body: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.data != null) {
                if (snapshot.data! == false) {
                  return const HomeScreen();
                } else {
                  return const OnboardingScreen();
                }
              }
              return const OnboardingScreen();
            default:
              return const OnboardingScreen();
          }
          return const OnboardingScreen();
        },
      ),
    );
  }
}
