import 'package:flutter/material.dart';
import 'package:adem/pages/loading_pages.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoadingPage(), // Use LoadingPage as the initial screen
    );
  }
}
