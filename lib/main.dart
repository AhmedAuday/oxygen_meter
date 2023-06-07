import 'package:flutter/material.dart';

import 'Themes/themes.dart';

import 'screens/bluetooth.dart';
import 'widgets/nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await MyThemeData.initialize();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  // ignore: unused_field
  Locale? _locale;
  ThemeMode _themeMode = MyThemeData.themeMode;

  void setLocale(Locale value) => setState(() => _locale = value);
  void setThemeMode(ThemeMode mode) => setState(() {
        //_themeMode = mode;
        MyThemeData.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        BluetoothPage.id: (context) => BluetoothPage(),
      },
      title: 'oxygen Meter',
      locale: _locale,
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: _themeMode,
      home: NavBarPage(),
    );
  }
}
