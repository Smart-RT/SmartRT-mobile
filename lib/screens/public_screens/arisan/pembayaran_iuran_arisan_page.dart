import 'package:flutter/material.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';

class PembayaranIuranArisan extends StatefulWidget {
  static const String id = 'PembayaranIuranArisan';
  const PembayaranIuranArisan({Key? key}) : super(key: key);

  @override
  State<PembayaranIuranArisan> createState() => _PembayaranIuranArisanState();
}

class _PembayaranIuranArisanState extends State<PembayaranIuranArisan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Padding(
        padding: paddingScreen,
        child: Column(
          children: [
            Text(
              'PEMBAYARAN ARISAN',
              style: smartRTTextTitle,
              textAlign: TextAlign.center,
            ),
            Text(
              'PERIODE X PERTEMUAN X',
              style: smartRTTextLarge,
              textAlign: TextAlign.center,
            ),
            SB_height30,
          ],
        ),
      ),
    );
  }
}
