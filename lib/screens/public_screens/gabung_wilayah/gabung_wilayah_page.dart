import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/user_role_request.dart';
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
  List<UserRoleRequests> listUserRoleRequests =
      AuthProvider.currentUser!.user_role_requests;
  bool userRoleActive = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (listUserRoleRequests.isNotEmpty) {
      userRoleActive =
          listUserRoleRequests[0].confirmater_id == null ? true : false;
    }
  }

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
          child: userRoleActive
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Gabung Wilayah',
                          style: smartRTTextTitle_Primary,
                        ),
                        SB_height15,
                        Text(
                          'Anda telah melakukan permintaan gabung wilayah dengan data sebagai berikut.\n\nTanggal Permintaan : ${DateFormat.yMMMMd().format(DateTime.parse(listUserRoleRequests[0].created_at.toString()))}\nKode Wilayah : ${listUserRoleRequests[0].request_code} \n\nSilahkan menunggu permintaan anda di konfirmasi oleh Ketua RT dari kode wilayah tersebut atau anda dapat membatalkan permintaan tersebut dengan cara menekan tombol BATALKAN di bawah halaman ini.',
                          style: smartRTTextNormal_Primary,
                          textAlign: TextAlign.justify,
                        ),
                        
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          await context.read<AuthProvider>().updateUserRoleRequest(
                            context: context,
                            user_role_requests_id: listUserRoleRequests[0].id,
                            isAccepted: false,
                          );
                          setState(() {
                            userRoleActive = false;
                          });
                        },
                        child: Text(
                          'BATALKAN',
                          style: smartRTTextLargeBold_Secondary,
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
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
                        onPressed: () async{
                          if (_formKey.currentState!.validate()) {
                            await context.read<AuthProvider>().reqGabungWilayah(
                                context: context,
                                request_code: _requestCodeController.text);
                            setState(() {
                              userRoleActive = true;
                            });
                            _requestCodeController.clear();
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
