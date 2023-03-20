import 'package:flutter/material.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/user/user.dart';
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
  User user = AuthProvider.currentUser!;

  void getData() async {
    _isSignatureNull = user.sign_img == null ? true : false;
    _IDUser = user.id;
    _signatureUser = user.sign_img;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
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
