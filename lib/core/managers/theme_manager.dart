import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/managers/font_manager.dart';

ThemeData getApplicationThemeData() {
  return ThemeData(
    fontFamily: FontConstants.droidFontFamily,

    //main Colors
    primaryColor: ColorManager.primaryColor,
    scaffoldBackgroundColor: ColorManager.scaffoldBackground,
    progressIndicatorTheme:
        ProgressIndicatorThemeData(color: ColorManager.orange),

  //switch theme
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return Colors.white;
        }
        return null;
      }),
      trackColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return ColorManager.orange;
        }
        return null;
      }),
    ),


//radio button theme
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return ColorManager.orange;
        }
        return null;
      }),
    ),


//check box theme
    checkboxTheme: CheckboxThemeData(

      fillColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return ColorManager.orange;
        }
        return null;
      }),
    ),



    // app bar theme
    appBarTheme: AppBarTheme(
      backgroundColor: ColorManager.black,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: ColorManager.black,
      ),
      titleTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
    ),

    // button theme
    // buttonTheme: ButtonThemeData(
    //     shape: const StadiumBorder(),
    //     disabledColor: ColorManager.grey1,
    //     buttonColor: ColorManager.primary,
    //     splashColor: ColorManager.lightPrimary),

//elevated Button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        backgroundColor:ColorManager.orange,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        elevation: 0
      ),
    ),

// text button theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ColorManager.orange,
      ),
    ),

//outlined button theme
     outlinedButtonTheme: OutlinedButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ColorManager.orange,
         shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    ),

    // input decoration theme (text field theme)
    inputDecorationTheme: InputDecorationTheme(
     contentPadding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),

      hintStyle: TextStyle(
        fontSize: 14,
      ),
      labelStyle: TextStyle(
        fontSize: 14,
      ),
      floatingLabelStyle: TextStyle(
          color:ColorManager.orange,
          fontSize: 16,
          fontWeight: FontWeight.bold),
      errorStyle: TextStyle(
        color: Colors.red,
      ),


      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.gray1,

        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            4,
          ),

        ),
      ),

      // focused border style(primary)
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color:ColorManager.orange,

        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            4,
          ),
        ),
      ),

      // error border style
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,

        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            4,
          ),
        ),
      ),

      // focused border style
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,

        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            4,
          ),
        ),
      ),
    ),
  );
}
