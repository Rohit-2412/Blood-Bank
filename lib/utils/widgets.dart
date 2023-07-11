import 'package:blood_bank/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class MyWidget {
  static const InputDecoration outlineDec = InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: CustomColors.whiteColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: CustomColors.whiteColor),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: CustomColors.whiteColor),
    ),
  );

  static const TextStyle textLg = TextStyle(
    fontSize: 18,
  );
  static const TextStyle textXl = TextStyle(
    fontSize: 24,
  );

  // navigate to screen
  static void navigateTo(BuildContext context, String name) {
    Navigator.pushNamed(context, name);
  }

  // welcome screen text style
  static TextStyle heading = const TextStyle(
      color: CustomColors.whiteColor,
      fontSize: 24,
      fontWeight: FontWeight.w500);

  // show snack bar
  static void showSnackBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(content)));
  }
}
