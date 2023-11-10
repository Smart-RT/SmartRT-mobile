import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KonfirmasiRequestJabatan extends StatelessWidget {
  static const String id = 'KonfirmasiRequestJabatan';
  const KonfirmasiRequestJabatan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Konfirmasi Request Jabatan"),
      ),
      body: Container(
          child: ListView(
        children: [Text('Konfirmasi Request')],
      )),
    );
  }
}
