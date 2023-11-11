import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scheduler/pages/home.dart';
import 'package:scheduler/pages/courses.dart';
import 'package:scheduler/utilities/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.light(context);
    /*final theme2 = ThemeData(
        textTheme: GoogleFonts.jostTextTheme(
      Theme.of(context).textTheme,
    ));*/
    return MaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: Home(),
      routes: {
        '/home': (context) => Home(),
        '/courses': (context) => const Courses(),
      },
    );
  }
}
