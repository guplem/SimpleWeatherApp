import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

// A class to unify all theme elements and basic settings for easy access and consistency
class ThemeCustom {
  ThemeCustom._();

  static const EdgeInsets paddingInnerCard = EdgeInsets.symmetric(horizontal: 10, vertical: 10);

  // STANDARD BORDER RADIUS
  static BorderRadius borderRadiusStandard = BorderRadius.circular(borderRadiusStandardValue);
  static BorderRadius borderRadiusFullyRounded = BorderRadius.circular(999999);
  static double borderRadiusStandardValue = 12; //INFO: https://m3.material.io/styles/shape/shape-scale-tokens

  // THEME SETTINGS
  static ThemeData get defaultTheme => getTheme(color: defaultSeedColor, themeMode: defaultThemeMode, materialVersion: defaultMaterialVersion);
  static Color get defaultSeedColor => Colors.lightGreen;
  static ThemeMode get defaultThemeMode => ThemeMode.system;
  static int get defaultMaterialVersion => 3;

  static ThemeData getTheme({required Color color, int materialVersion = 3, ThemeMode themeMode = ThemeMode.system}) {
    bool useLightMode = true;
    switch (themeMode) {
      case ThemeMode.system:
        useLightMode = PlatformDispatcher.instance.platformBrightness == Brightness.light;
        break;
      case ThemeMode.dark:
        useLightMode = false;
        break;
      case ThemeMode.light:
        useLightMode = true;
        break;
    }

    ThemeData themeData = ThemeData(
      typography: Typography.material2021(),
      colorSchemeSeed: color,
      useMaterial3: materialVersion == 3,
      brightness: useLightMode ? Brightness.light : Brightness.dark,
    );

    if (materialVersion == 3) {
      Color surfaceColor = ElevationOverlay.applySurfaceTint(themeData.colorScheme.surface, themeData.colorScheme.surfaceTint, 1);
      themeData = themeData.copyWith(
        colorScheme: themeData.colorScheme.copyWith(
          surface: surfaceColor,
          onSurface: themeData.colorScheme.onSurfaceVariant,
        ),
      );
    }

    return themeData;
  }

  // THEME SHORTCUTS
  static ThemeData of(BuildContext context) => Theme.of(context);

  static ColorScheme colorScheme(BuildContext context) => ThemeCustom.of(context).colorScheme;

  static TextTheme textTheme(BuildContext context) => ThemeCustom.of(context).textTheme;

  static SliderThemeData sliderTheme(BuildContext context) => SliderTheme.of(context);

}
