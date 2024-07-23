import 'package:flutter/material.dart';
import 'package:portfolio/pages/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.black87),
      title: 'Divyam\'s website',
      home: const Homepage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
