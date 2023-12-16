import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/models/user/user_role_request.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/screens/public_screens/daftar_ketua/daftar_ketua_form_page_1.dart';
import 'package:provider/provider.dart';

class DaftarKetuaPage extends StatefulWidget {
  static const String id = 'DaftarKetuaPage';
  const DaftarKetuaPage({Key? key}) : super(key: key);

  @override
  State<DaftarKetuaPage> createState() => _DaftarKetuaPageState();
}

class _DaftarKetuaPageState extends State<DaftarKetuaPage> {
  final _formKey = GlobalKey<FormState>();
  final _requestCodeController = TextEditingController();

  List<UserRoleRequest> listUserRoleRequests =
      AuthProvider.currentUser!.user_role_requests;

  bool isHasUserRoleReqActive = false;

  int? request_role;
  String? _reqRoleWords;
  String? _dataWords;
  String? _roleConfirmater;
  String btnText = 'DAFTAR SEKARANG';
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
            "Tanggal Permintaan : ${DateFormat('d MMMM y', 'id_ID').format(DateTime.parse(listUserRoleRequests[0].created_at.toString()))}\n\nWilayah :  \nRT/RW ${listUserRoleRequests[0].rt_num}/${listUserRoleRequests[0].rw_num}, \n${listUserRoleRequests[0].urban_village_id!.name}, \nKec. ${listUserRoleRequests[0].sub_district_id!.name}";
        _roleConfirmater = "Admin";
      }
    }

    if (isHasUserRoleReqActive) {
      btnText = 'BATALKAN';
    }
    setState(() {});
  }

  void batalkan() async {
    await context.read<AuthProvider>().updateUserRoleRequest(
          context: context,
          user_role_requests_id: listUserRoleRequests[0].id,
          isAccepted: false,
        );
    Navigator.popAndPushNamed(context, DaftarKetuaPage.id);
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = context.watch<AuthProvider>().user!;
    isHasUserRoleReqActive = listUserRoleRequests.isNotEmpty &&
            listUserRoleRequests[0].confirmater_id == null
        ? true
        : false;
    if (isHasUserRoleReqActive) {
      btnText = 'BATALKAN';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SingleChildScrollView(
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
                      'Daftar Menjadi\nKetua RT',
                      style: smartRTTextTitle_Primary,
                    ),
                    Text(
                      'Anda menjabat sebagai Ketua RT di wilayah anda? Yuk daftarkan diri anda pada aplikasi ini sebagai ketua RT agar dapat mengajak warga anda untuk masuk ke wilayah anda dan mengakses fitur-fitur yang akan membantu warga serta pengurus wilayah RT anda.',
                      style: smartRTTextNormal_Primary,
                    ),
                  ],
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
            isHasUserRoleReqActive
                ? batalkan()
                : Navigator.pushNamed(context, DaftarKetuaFormPage1.id);
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
