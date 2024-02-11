import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyLargePrimary => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w300,
      );
  static get bodyLargePrimary_1 => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get bodySmall10 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 10.fSize,
      );
  static get bodySmall10_1 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 10.fSize,
      );
  static get bodySmallBlack900 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.black900,
        fontSize: 10.fSize,
      );
  static get bodySmallExtraLight => theme.textTheme.bodySmall!.copyWith(
        fontSize: 10.fSize,
        fontWeight: FontWeight.w200,
      );
  static get bodySmallPrimaryContainer => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
        fontSize: 12.fSize,
      );
  static get bodySmallPrimaryContainer12 => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
        fontSize: 12.fSize,
      );
  static get bodySmallff232121 => theme.textTheme.bodySmall!.copyWith(
        color: Color(0XFF232121),
        fontSize: 10.fSize,
        fontWeight: FontWeight.w400,
      );
  static get bodySmallff23212110 => theme.textTheme.bodySmall!.copyWith(
        color: Color(0XFF232121),
        fontSize: 10.fSize,
      );
  // Label text style
  static get labelLargeGray10001 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.gray10001,
        fontWeight: FontWeight.w500,
      );
  static get labelMediumBluegray700 => theme.textTheme.labelMedium!.copyWith(
        color: appTheme.blueGray700,
        fontWeight: FontWeight.w800,
      );
  static get labelMediumffffbe58 => theme.textTheme.labelMedium!.copyWith(
        color: Color(0XFFFFBE58),
        fontWeight: FontWeight.w700,
      );
  // Title text style
  static get titleMediumBlack900 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w800,
      );
  static get titleMediumBlack900_1 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
      );
  static get titleMediumErrorContainer => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.errorContainer,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumGray10001 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray10001,
      );
  static get titleMediumOnPrimary => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimary,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumOnPrimary_1 => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimary,
      );
  static get titleMediumTeal200 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.teal200,
      );
  static get titleSmallBlack900 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w700,
      );
  static get titleSmallBold => theme.textTheme.titleSmall!.copyWith(
        fontWeight: FontWeight.w700,
      );
}

extension on TextStyle {
  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }
}
