import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';

class UbahProfilPage extends StatefulWidget {
  static const String id = 'UbahProfilPage';
  const UbahProfilPage({Key? key}) : super(key: key);

  @override
  State<UbahProfilPage> createState() => _UbahProfilPageState();
}

class _UbahProfilPageState extends State<UbahProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ubah Profil'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: paddingScreen,
                child: Center(
                  child: Icon(
                    Icons.account_circle,
                    size: 100,
                    color: smartRTPrimaryColor,
                  ),
                ),
              ),
              Container(
                height: 500,
                child: ListView(
                  children: <Widget>[
                    Card(
                      color: smartRTSecondaryColor,
                      child: ListTile(
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Nama Lengkap',
                                style: smartRTTextLarge_Primary.copyWith(
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '[Nama Lengkap]',
                                style: smartRTTextLarge_Primary.copyWith(
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: smartRTPrimaryColor,
                          size: 15,
                        ),
                      ),
                    ),
                    Card(
                      color: smartRTSecondaryColor,
                      child: ListTile(
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Jenis Kelamin',
                                style: smartRTTextLarge_Primary.copyWith(
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '[Jenis Kelamin]',
                                style: smartRTTextLarge_Primary.copyWith(
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: smartRTPrimaryColor,
                          size: 15,
                        ),
                      ),
                    ),
                    Card(
                      color: smartRTSecondaryColor,
                      child: ListTile(
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Tanggal Lahir',
                                style: smartRTTextLarge_Primary.copyWith(
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '[Tanggal Lahir]',
                                style: smartRTTextLarge_Primary.copyWith(
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: smartRTPrimaryColor,
                          size: 15,
                        ),
                      ),
                    ),
                    Card(
                      color: smartRTSecondaryColor,
                      child: ListTile(
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Alamat Rumah',
                                style: smartRTTextLarge_Primary.copyWith(
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '[Alamat Rumah]',
                                style: smartRTTextLarge_Primary.copyWith(
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: smartRTPrimaryColor,
                          size: 15,
                        ),
                      ),
                    ),
                    Card(
                      color: smartRTSecondaryColor,
                      child: ListTile(
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Nomor Telepon',
                                style: smartRTTextLarge_Primary.copyWith(
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '[Nomor Telepon]',
                                style: smartRTTextLarge_Primary.copyWith(
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: smartRTPrimaryColor,
                          size: 15,
                        ),
                      ),
                    ),
                    Card(
                      color: smartRTSecondaryColor,
                      child: ListTile(
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Kata Sandi',
                                style: smartRTTextLarge_Primary.copyWith(
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '[Kata Sandi]',
                                style: smartRTTextLarge_Primary.copyWith(
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: smartRTPrimaryColor,
                          size: 15,
                        ),
                      ),
                    ),
                    Card(
                      color: smartRTSecondaryColor,
                      child: ListTile(
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Tanda Tangan',
                                style: smartRTTextLarge_Primary.copyWith(
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '[Tanda Tangan]',
                                style: smartRTTextLarge_Primary.copyWith(
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: smartRTPrimaryColor,
                          size: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // TextFormField(
              //   autocorrect: false,
              //   style: smartRTTextNormal_Primary,
              //   decoration: const InputDecoration(
              //     labelText: 'Nama Lengkap',
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Nama Lengkap tidak boleh kosong';
              //     }
              //   },
              // ),
              // SB_height15,
              // TextFormField(
              //   autocorrect: false,
              //   style: smartRTTextNormal_Primary,
              //   decoration: const InputDecoration(
              //     labelText: 'Nomor Telepon',
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Nomor Telepon tidak boleh kosong';
              //     }
              //   },
              // ),
              // SB_height15,
              // TextFormField(
              //   autocorrect: false,
              //   style: smartRTTextNormal_Primary,
              //   decoration: const InputDecoration(
              //     labelText: 'Alamat Rumah',
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Nomor Telepon tidak boleh kosong';
              //     }
              //   },
              // ),
            ],
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
                /**.... */
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
