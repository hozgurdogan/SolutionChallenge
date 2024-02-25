import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../core/app_export.dart';

/// A class that offers pre-defined button styles for customizing button appearance.
class CustomButtonStyles {
  // Filled button style
  static ButtonStyle get fillGrayD => ElevatedButton.styleFrom(
    backgroundColor: HexColor("#252422"),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14.h),
    ),
  );

  static ButtonStyle get fillGrayLD => ElevatedButton.styleFrom(
    backgroundColor: HexColor("#403D39"),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14.h),
    ),
  );

  static ButtonStyle get fillGrayL => ElevatedButton.styleFrom(
    backgroundColor: HexColor("#CCC5B9"),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14.h),
    ),
  );
  static ButtonStyle get fillGray => ElevatedButton.styleFrom(
        backgroundColor: appTheme.gray10001,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.h),
        ),
      );
  static ButtonStyle get fillGrayTL14 => ElevatedButton.styleFrom(
        backgroundColor: appTheme.gray300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.h),
        ),
      );
  static ButtonStyle get fillOnPrimary => ElevatedButton.styleFrom(
        backgroundColor: HexColor("#EB5E28"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.h),
        ),
      );
  static ButtonStyle get fillOnPrimaryTL19 => ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(19.h),
        ),
      );
  static ButtonStyle get fillTeal => ElevatedButton.styleFrom(
        backgroundColor: appTheme.teal200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.h),
        ),
      );
  // text button style
  static ButtonStyle get none => ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        elevation: MaterialStateProperty.all<double>(0),
      );
}
