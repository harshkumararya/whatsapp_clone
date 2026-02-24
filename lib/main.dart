import 'package:flutter/material.dart';
import 'package:whatsapp_clone/features/app/splash/splash_screen.dart';
import 'package:whatsapp_clone/features/app/theme/style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        dialogTheme: const DialogThemeData(
          backgroundColor:appBarColor,
          surfaceTintColor: Colors.transparent, // Ye sabse zaroori hai, varna light purple tint aayega
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor:appBarColor,
          elevation: 0,
        ),

        colorScheme: const ColorScheme.dark().copyWith(
          surface: appBarColor, // Dialogs aur Cards default mein yahi se color uthate hain
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
