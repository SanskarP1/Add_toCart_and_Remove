import 'package:exam/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const Exam(),
  );
}

class Exam extends StatelessWidget {
  const Exam({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const ShoppingCartScreen(),
    );
  }
}
