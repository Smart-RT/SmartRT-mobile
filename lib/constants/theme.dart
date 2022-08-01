import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/style.dart';

ThemeData getThemeData() {
  return ThemeData(
      // This is the theme of your application.
      //
      // Try running your application with "flutter run". You'll see the
      // application has a blue toolbar. Then, without quitting the app, try
      // changing the primarySwatch below to Colors.green and then invoke
      // "hot reload" (press "r" in the console where you ran "flutter run",
      // or simply save your changes to "hot reload" in a Flutter IDE).
      // Notice that the counter didn't reset back to zero; the application
      // is not restarted.

      // Define the default brightness and colors.
      brightness: Brightness.light,
      backgroundColor: smartRTPrimaryColor,
      scaffoldBackgroundColor: smartRTSecondaryColor,
      // primaryColor: Color(0xff311c0a),
      primarySwatch: const MaterialColor(
        0xff311c0a,
        <int, Color>{
          50: Color(0xfff1e9de),
          100: Color(0xffd5c7b9),
          200: Color(0xffb4a290),
          300: Color(0xff947e67),
          400: Color(0xff7c6449),
          500: Color(0xff644a2c),
          600: Color(0xff5a4126),
          700: Color(0xff4c361e),
          800: Color(0xff3f2916),
          900: Color(0xff311c0a)
        },
      ),

      // Define the default font family.
      fontFamily: 'Rubik',

      // Define the default `TextTheme`. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: TextTheme(
        titleMedium: smartRTTextTitleCard_Primary,
      ),

      // Define the default 'InputDecoration'. Use this to specify the default
      inputDecorationTheme: InputDecorationTheme(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        floatingLabelStyle: TextStyle(
          color: smartRTPrimaryColor,
          fontSize: 20,
        ),
        labelStyle: TextStyle(
          color: smartRTPrimaryColor,
        ),
        fillColor: smartRTPrimaryColor,
        enabledBorder: OutlineInputBorder(
          borderSide:  BorderSide(
            width: 2,
            color: smartRTPrimaryColor,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: smartRTPrimaryColor,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: smartRTErrorColor,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: smartRTErrorColor,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),

      // Define the default style of 'Elevated Button'
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: smartRTPrimaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ));
}
