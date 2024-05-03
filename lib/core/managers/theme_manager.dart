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
    // primaryColorLight: ColorManager.lightPrimary,
    // primaryColorDark: ColorManager.darkPrimary,
    // disabledColor: ColorManager.grey1,
    // splashColor: ColorManager.lightPrimary,
    // colorScheme: ColorScheme.fromSwatch().copyWith(
    //   primary: ColorManager.black,
    // ),

    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return ColorManager.orange;
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

    // cardview theme
    // cardTheme: CardTheme(
    //     color: ColorManager.white,
    //     shadowColor: ColorManager.grey,
    //     elevation: AppSize.s4),

    // app bar theme
    appBarTheme: AppBarTheme(
      backgroundColor: ColorManager.black,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      centerTitle: true,
      // elevation: AppSize.s16,
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

//elevated Button
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

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ColorManager.orange,
      ),
    ),

     outlinedButtonTheme: OutlinedButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ColorManager.orange,
         shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    ),
    // text theme
    // textTheme: TextTheme(

    //   displayLarge:
    //       getLightStyle(color: ColorManager.white, fontSize: FontSize.s22),
    //   headline1: getSemiBoldStyle(
    //       color: ColorManager.darkGrey, fontSize: FontSize.s16),
    //   subtitle1:
    //       getMediumStyle(color: ColorManager.lightGrey, fontSize: FontSize.s14),
    //   caption: getRegularStyle(color: ColorManager.grey1),
    //   bodyText1        : getRegularStyle(
    //     color: ColorManager.grey,
    //   ),
    // ),

    // input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
      // content padding
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

      // enabled border style (grey)
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.gray1,
          //  width: AppSize.s1_5,
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
          //  width: AppSize.s1_5,
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
          //  width: AppSize.s1_5,
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
          // width: AppSize.s1_5,
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
