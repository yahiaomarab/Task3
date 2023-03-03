import 'package:flutter/material.dart';
import 'package:todo/layouts/layout_screen.dart';
import '../shared/Network/local/cacheHelper.dart';
import '../shared/ThemesAndColors/Themes/dark_Theme.dart';
import '../shared/ThemesAndColors/Themes/light_Theme.dart';

void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  await  CacheHelper.init();
  bool isDark=CacheHelper.Gettdata(key: "isdark");
  runApp( MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
          home:Home_Screen(),
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.dark,
          darkTheme: darkTheme,
          theme: lightTheme,
        );
  }
}

