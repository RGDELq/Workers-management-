import 'package:flutter/material.dart';

// import 'package:image_picker/image_picker.dart';
class Colormanager {
}

Color primary = const Color.fromARGB(255, 44, 73, 121);
Color darkblue = const Color(0xff114E60);
Color darkGrey = const Color(0xff737477);
Color lightGrey = const Color(0xff9E9E9E);
Color dColor = const Color(0xff000000);
Color pistacho = const Color(0xffF5cef9);
// new colors
Color thirdPrimary = const Color(0xffF5CEBE);
Color darkcolor = const Color(0xff121212);

Color secprimary = const Color.fromARGB(255, 219, 232, 216);
Color thirdprimary = const Color.fromARGB(255, 181, 220, 172);

Color lightPrimary =
    const Color.fromARGB(255, 196, 181, 130); // color with 80% opacity
Color grey1 = const Color(0xff707070);
Color grey2 = const Color(0xff797979);
Color white = const Color(0xffFFFFFF);
Color error = const Color(0xffe61f34); // red color

Color pcolor = const Color.fromARGB(255, 44, 73, 121);

Duration animationDuration = const Duration(milliseconds: 200);

const kPrimaryColor = Color(0xFF00BF6D);
const kSecondaryColor = Color(0xFFFE9901);
const kContentColorLightTheme = Color(0xFF1D1D35);
const kContentColorDarkTheme = Color(0xFFF5FCF9);
const kWarninngColor = Color(0xFFF3BB1C);
const kErrorColor = Color(0xFFF03738);

const kDefaultPadding = 20.0;

final ThemeData lightThemeData = ThemeData(
  primaryColor: kPrimaryColor,
  scaffoldBackgroundColor: Colors.white,
  iconTheme: const IconThemeData(color: kContentColorLightTheme),
  colorScheme: const ColorScheme.light(
    primary: kPrimaryColor,
    secondary: kSecondaryColor,
    error: kErrorColor,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    ),
  ),
);

final ThemeData darkThemeData = ThemeData(
  primaryColor: kPrimaryColor,
  scaffoldBackgroundColor: kContentColorLightTheme,
  iconTheme: const IconThemeData(color: kContentColorDarkTheme),
  colorScheme: const ColorScheme.dark().copyWith(
    primary: kPrimaryColor,
    secondary: kSecondaryColor,
    error: kErrorColor,
  ),
  brightness: Brightness.dark,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    ),
  ),
);
