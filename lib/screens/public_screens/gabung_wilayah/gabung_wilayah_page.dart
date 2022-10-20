import 'package:flutter/material.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/providers/auth_provider.dart';

import 'package:provider/provider.dart';

class GabungWilayahPage extends StatefulWidget {
  static const String id = 'GabungWilayahPage';
  const GabungWilayahPage({Key? key}) : super(key: key);

  @override
  State<GabungWilayahPage> createState() => _GabungWilayahPageState();
}

class _GabungWilayahPageState extends State<GabungWilayahPage> {
  final _formKey = GlobalKey<FormState>();
  final _requestCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: paddingScreen,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gabung Wilayah',
                    style: smartRTTextTitle_Primary,
                  ),
                  Text(
                    'Masukkan kode wilayah anda yang didapatkan dari Ketua RT wilayah anda agar dapat bergabung dengan wilayah anda dan menikmati fitur-fitur yang telah disediakan',
                    style: smartRTTextNormal_Primary,
                  ),
                  SB_height15,
                  TextFormField(
                    autocorrect: false,
                    style: smartRTTextNormal_Primary,
                    controller: _requestCodeController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Kode Wilayah tidak boleh kosong';
                      }
                    },
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthProvider>().reqGabungWilayah(
                          context: context,
                          request_code: _requestCodeController.text);
                    }
                  },
                  child: Text(
                    'KIRIM',
                    style: smartRTTextLargeBold_Secondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
