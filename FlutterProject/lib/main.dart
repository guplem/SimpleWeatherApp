import "package:flutter/material.dart";
import "package:weather_app/hub/screen_view.dart";
import "package:weather_app/theme_custom.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData themeData = ThemeCustom.defaultTheme;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // THEME
      theme: themeData,
      themeMode: themeData.brightness == Brightness.light ? ThemeMode.light : ThemeMode.dark,
      // OTHER
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => "Weather App",
      // INITIAL ROUTE
      home: const HubScreen(),
    );
  }
}
