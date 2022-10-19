import 'dart:typed_data';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';

class TandaTanganSayaCanvasPage extends StatefulWidget {
  static const String id = 'TandaTanganSayaCanvasPage';
  const TandaTanganSayaCanvasPage({Key? key}) : super(key: key);

  @override
  State<TandaTanganSayaCanvasPage> createState() =>
      _TandaTanganSayaCanvasPageState();
}

class _TandaTanganSayaCanvasPageState extends State<TandaTanganSayaCanvasPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    User u = AuthProvider.currentUser!;
  }

  Future<void> exportImage(BuildContext context) async {
    if (_signatureController.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('No content')));
      return;
    }

    final Uint8List? data = await _signatureController.toPngBytes();
    if (data != null) {
      await context
            .read<AuthProvider>()
            .uploadSignatureImage(context: context, file: data);
            
      Navigator.pop(context);
    }
  }

  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.transparent,
    exportPenColor: Colors.black,
    onDrawStart: () => print('onDrawStart called!'),
    onDrawEnd: () => print('onDrawEnd called!'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buat dan Lampirkan Tanda Tangan'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: paddingScreen,
            child: Column(
              children: [
                Signature(
                  controller: _signatureController,
                  height: 250,
                  width: MediaQuery.of(context).size.width - 50,
                  backgroundColor: Colors.white,
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        _signatureController.clear();
                      },
                      child: Row(
                        children: [
                          Icon(Icons.restart_alt_rounded,
                              size: 15, color: smartRTPrimaryColor),
                          Text(
                            ' Reset',
                            style: smartRTTextLarge_Primary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              onPressed: () {
                exportImage(context);
              },
              child: Text(
                'SIMPAN',
                style: smartRTTextLargeBold_Secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
