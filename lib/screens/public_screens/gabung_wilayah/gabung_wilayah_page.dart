import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/user.dart';
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

  List<UserRoleRequest> listUserRoleRequests =
      AuthProvider.currentUser!.user_role_requests;

  bool isHasUserRoleReqActive = false;

  int? request_role;
  String? _reqRoleWords;
  String? _dataWords;
  String? _roleConfirmater;
  String btnText = 'KIRIM';
  User user = AuthProvider.currentUser!;

  void getData() async {
    if (listUserRoleRequests.isNotEmpty) {
      isHasUserRoleReqActive =
          listUserRoleRequests[0].confirmater_id == null ? true : false;
      request_role = listUserRoleRequests[0].request_role;
      if (request_role == 3) {
        _reqRoleWords = "gabung wilayah";
        _dataWords =
            "Tanggal Permintaan : ${DateFormat('d MMMM y', 'id_ID').format(DateTime.parse(listUserRoleRequests[0].created_at.toString()))}";
        _roleConfirmater = "Ketua RT dari kode wilayah tersebut";
      } else if (request_role == 7) {
        _reqRoleWords = "mengubah jabatan menjadi Ketua RT";
        _dataWords =
            "Tanggal Permintaan : ${DateFormat('d MMMM y', 'id_ID').format(DateTime.parse(listUserRoleRequests[0].created_at.toString()))}\n\nWilayah :  \nRT/RW ${listUserRoleRequests[0].rt_num}/${listUserRoleRequests[0].rw_num}, ${listUserRoleRequests[0].urban_village_id!.name}, Kec. ${listUserRoleRequests[0].sub_district_id!.name}";
        _roleConfirmater = "Admin";
      }
    }

    if (isHasUserRoleReqActive) {
      btnText = 'BATALKAN';
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  void batalkan() async {
    await context.read<AuthProvider>().updateUserRoleRequest(
          context: context,
          user_role_requests_id: listUserRoleRequests[0].id,
          isAccepted: false,
        );
    Navigator.popAndPushNamed(context, GabungWilayahPage.id);
  }

  void kirim() async {
    if (_formKey.currentState!.validate()) {
      await context.read<AuthProvider>().reqGabungWilayah(
          context: context, request_code: _requestCodeController.text);
      debugPrint(user.user_role_requests.toString());
      if (user.user_role_requests.isNotEmpty) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: paddingScreen,
            child: isHasUserRoleReqActive
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Anda mempunyai Permintaan yang masih Aktif !',
                        style: smartRTTextTitle,
                      ),
                      SB_height15,
                      Text(
                        'Maaf anda tidak dapat melakukan permintaan gabung wilayah dikarenakan terdapat permintaan yang masih aktif.',
                        style: smartRTTextNormal,
                        textAlign: TextAlign.justify,
                      ),
                      SB_height15,
                      Text(
                        'Anda telah melakukan permintaan ${_reqRoleWords} dengan data sebagai berikut.',
                        style: smartRTTextNormal,
                        textAlign: TextAlign.justify,
                      ),
                      SB_height15,
                      Text(
                        _dataWords ?? '',
                        style: smartRTTextNormal.copyWith(
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.justify,
                      ),
                      SB_height15,
                      Text(
                        'Silahkan menunggu permintaan anda di konfirmasi oleh ${_roleConfirmater} atau anda dapat membatalkan permintaan tersebut dengan cara menekan tombol BATALKAN di bawah halaman ini.',
                        style: smartRTTextNormal,
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gabung Wilayah',
                        style: smartRTTextTitle_Primary,
                      ),
                      Text(
                        'Masukkan kode wilayah anda yang didapatkan dari Ketua RT wilayah anda agar dapat bergabung dengan wilayah anda dan menikmati fitur-fitur yang telah disediakan',
                        style: smartRTTextNormal,
                      ),
                      SB_height15,
                      TextFormField(
                        autocorrect: false,
                        style: smartRTTextNormal,
                        controller: _requestCodeController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kode Wilayah tidak boleh kosong';
                          }
                        },
                      ),
                    ],
                  ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          onPressed: () async {
            isHasUserRoleReqActive ? batalkan() : kirim();
          },
          child: Text(
            btnText,
            style: smartRTTextLargeBold_Secondary,
          ),
        ),
      ),
    );
  }
}
