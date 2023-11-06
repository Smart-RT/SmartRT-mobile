import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  static const String id = 'TestScreen';
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {

  int a = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('test')),
      body: Row(children: [
        Text('Test ${a}'),
        TextButton(
            onPressed: () {
              // Navigator.pushNamed(context, TestScreen2.id);
              setState(() {
                a++;
              });
            },
            child: Text('KE Test2')),
      ]),
    );
  }
}
