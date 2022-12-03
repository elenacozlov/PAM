import 'package:flutter/material.dart';
import 'package:lab3/quiz.dart';
import 'package:lab3/results.dart';
import 'package:lab3/firstpage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const FirstPage(),
      routes: {
        '/results': (context) => Results(),
        '/quiz': (context) => const Quiz(),
      },
    );
  }
}