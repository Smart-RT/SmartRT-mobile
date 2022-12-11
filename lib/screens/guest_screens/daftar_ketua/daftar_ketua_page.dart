import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/user_role_request.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/screens/guest_screens/daftar_ketua/daftar_ketua_form_page_1.dart';
import 'package:provider/provider.dart';

class DaftarKetuaPage extends StatefulWidget {
  static const String id = 'DaftarKetuaPage';
  const DaftarKetuaPage({Key? key}) : super(key: key);

  @override
  State<DaftarKetuaPage> createState() => _DaftarKetuaPageState();
}

class _DaftarKetuaPageState extends State<DaftarKetuaPage> {
  List<UserRoleRequests> listUserRoleRequests =
      AuthProvider.currentUser!.user_role_requests;
  bool userRoleActive = false;
  int? request_role;
  String? _reqRoleWords;
  String? _dataWords;
  String? _roleConfirmater;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (listUserRoleRequests.isNotEmpty) {
      userRoleActive =
          listUserRoleRequests[0].confirmater_id == null ? true : false;
      request_role = listUserRoleRequests[0].request_role;
      if (request_role == 3) {
        _reqRoleWords = "gabung wilayah";
        _dataWords =
            "Tanggal Permintaan : ${DateFormat.yMMMMd().format(DateTime.parse(listUserRoleRequests[0].created_at.toString()))}\nKode Wilayah : ${listUserRoleRequests[0].request_code}";
        _roleConfirmater = "Ketua RT dari kode wilayah tersebut";
      } else if (request_role == 7) {
        _reqRoleWords = "mengubah jabatan menjadi Ketua RT";
        _dataWords =
            "Tanggal Permintaan : ${DateFormat.yMMMMd().format(DateTime.parse(listUserRoleRequests[0].created_at.toString()))}\n\nWilayah :  \nRT/RW ${listUserRoleRequests[0].rt_num}/${listUserRoleRequests[0].rw_num}, ${listUserRoleRequests[0].urban_village_id!.name}, Kec. ${listUserRoleRequests[0].sub_district_id!.name}";
        _roleConfirmater = "Admin";
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Padding(
        padding: paddingScreen,
        child: 
        userRoleActive ?
        Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Maaf anda tidak dapat melakukan permintaan gabung wilayah dikarenakan terdapat permintaan yang masih aktif.\n\nAnda telah melakukan permintaan ${_reqRoleWords} dengan data sebagai berikut.\n\n${_dataWords}\n\nSilahkan menunggu permintaan anda di konfirmasi oleh ${_roleConfirmater} atau anda dapat membatalkan permintaan tersebut dengan cara menekan tombol BATALKAN di bawah halaman ini.',
                          style: smartRTTextNormal_Primary,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          await context
                              .read<AuthProvider>()
                              .updateUserRoleRequest(
                                context: context,
                                user_role_requests_id:
                                    listUserRoleRequests[0].id,
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
              :
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daftar Menjadi\nKetua RT',
                  style: smartRTTextTitle_Primary,
                ),
                Text(
                  'Anda menjabat sebagai Ketua RT di wilayah anda? Yuk daftarkan diri anda pada aplikasi ini sebagai ketua RT agar dapat mengajak warga anda untuk masuk ke wilayah anda dan mengakses fitur-fitur yang akan membantu warga serta pengurus wilayah RT anda.',
                  style: smartRTTextNormal_Primary,
                ),
              ],
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, DaftarKetuaFormPage1.id);
                },
                child: Text(
                  'DAFTAR SEKARANG',
                  style: smartRTTextLargeBold_Secondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
