import 'package:flutter/material.dart';

class TestScreen2 extends StatefulWidget {
  static const String id = 'TestScreen2';
  const TestScreen2({Key? key}) : super(key: key);

  @override
  State<TestScreen2> createState() => _TestScreen2State();
}

class _TestScreen2State extends State<TestScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WKAOKWAOWAKOWA')),
      body: const Text('WKAOKWAOWAKOWAWKAOKWAOWAKOWAWKAOKWAOWAKOWA'),
    );
  }
}
