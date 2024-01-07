import 'package:flutter/material.dart';
import 'ReportList.dart';

//Lab
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ReportList(),
    );
  }
}
