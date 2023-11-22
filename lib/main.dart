import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/pages/home.dart';
import 'package:scheduler/providers/provider.dart';
import 'package:scheduler/utilities/styles.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
// Conexion con Firebase
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ShiftProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => CourseProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => BlockProvider(),
          )
        ],
        child: MaterialApp(
          theme: theme,
          debugShowCheckedModeBanner: false,
          home: Home(),
          /*routes: {
            '/home': (context) => Home(),
            '/courses': (context) => const Courses(),
          },*/
        ));
  }
}
