import 'package:flutter/material.dart';
import 'package:knowit/screens/collections_screen.dart';

class Knowit extends StatelessWidget {
  const Knowit({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Knowit",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.yellow,
          brightness: Brightness.light,
        ),
        fontFamily: "QuickSand",
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.yellowAccent,
          brightness: Brightness.dark,
        ),
        fontFamily: "QuickSand",
      ),
      home: CollectionsScreen(),
    );
  }
}
