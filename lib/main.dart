import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inshort/commons/constants/theme_constants.dart';
import 'package:inshort/components/home/home_view.dart';
import 'package:inshort/service_locator.dart';

void main() {
   setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Inshort',
      debugShowCheckedModeBanner: false,
      transitionDuration: Duration(seconds: 0),
      theme: ThemeData(
        primarySwatch: MaterialColor(
          0xFF000000,
          <int, Color>{
            50: Color(0xFF000000),
            100: Color(0xFF000000),
            200: Color(0xFF000000),
            300: Color(0xFF000000),
            400: Color(0xFF000000),
            500: Color(0xFF000000),
            600: Color(0xFF000000),
            700: Color(0xFF000000),
            800: Color(0xFF000000),
            900: Color(0xFF000000),
          },
        ),
        textSelectionTheme:
            TextSelectionThemeData(selectionHandleColor: Colors.transparent),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        backgroundColor: ThemeConstants.WHITE_COLOR,
        scaffoldBackgroundColor: ThemeConstants.WHITE_COLOR,
      ),
      home: Homeview(),
    );
  }
}
