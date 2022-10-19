import 'dart:typed_data';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
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
import 'package:smart_rt/screens/public_screens/tanda_tangan_saya/tanda_tangan_saya_canvas_page.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';

class TandaTanganSayaPage extends StatefulWidget {
  static const String id = 'TandaTanganSayaPage';
  const TandaTanganSayaPage({Key? key}) : super(key: key);

  @override
  State<TandaTanganSayaPage> createState() => _TandaTanganSayaPageState();
}

class _TandaTanganSayaPageState extends State<TandaTanganSayaPage> {
  late bool _isSignatureNull = true;
  late int? _IDUser;
  late String? _signatureUser;
  User u = AuthProvider.currentUser!;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isSignatureNull = u.sign_img!.isEmpty;
    _IDUser = u.id;
    _signatureUser = u.sign_img;
  }

  @override
  Widget build(BuildContext context) {
    _signatureUser = context.watch<AuthProvider>().user!.sign_img;
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        children: [
          Padding(
            padding: paddingScreen,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tanda Tangan Saya',
                  style: smartRTTextTitle_Primary,
                ),
                Text(
                  'Tanda tangan akan digunakan ketika mengurus dokumen yang membutuhkan tanda tangan anda.',
                  style: smartRTTextNormal_Primary,
                ),
                SB_height15,
                Visibility(
                  visible: _isSignatureNull ? true : false,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, TandaTanganSayaCanvasPage.id);
                          },
                          child: Text(
                            'BUAT DAN LAMPIRKAN SEKARANG',
                            style: smartRTTextLargeBold_Secondary,
                          ),
                        ),
                      ),
                      SB_height15,
                      Text(
                        '*Anda belum melampirkan tanda tangan anda!',
                        style: smartRTTextNormal_Primary,
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: _isSignatureNull ? false : true,
                  child: Column(
                    children: [
                      Container(
                        height: 250,
                        child: Image.network(
                          '${backendURL}/public/uploads/users/${_IDUser}/signature/${_signatureUser}',
                        ),
                      ),
                      SB_height15,
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, TandaTanganSayaCanvasPage.id);
                          },
                          child: Text(
                            'UBAH TANDA TANGAN',
                            style: smartRTTextLargeBold_Secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
