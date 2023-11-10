import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/models/user/user_role_request.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';

class ReqUpdateRolePage extends StatefulWidget {
  static const String id = 'ReqUpdateRolePage';
  const ReqUpdateRolePage({Key? key}) : super(key: key);

  @override
  State<ReqUpdateRolePage> createState() => _ReqUpdateRolePageState();
}

class _ReqUpdateRolePageState extends State<ReqUpdateRolePage> {
  final _formKey = GlobalKey<FormState>();
  final _requestCodeController = TextEditingController();

  void kirim() async {
    if (_formKey.currentState!.validate()) {
      bool success = await context.read<AuthProvider>().reqPengurusWilayah(
          context: context, request_code: _requestCodeController.text);

      if (success) {
        _requestCodeController.text = '';
      }
    }
  }

  void batal(BuildContext context, UserRoleRequest roleRequest) async {
    bool success = await context.read<AuthProvider>().updateUserRoleRequest(
          context: context,
          user_role_requests_id: roleRequest.id,
          isAccepted: false,
        );
    if (success) {
      SmartRTSnackbar.show(context,
          message: 'Berhasil batalkan request pengurus!',
          backgroundColor: smartRTSuccessColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isHaveUserRoleActive = false;
    int? request_role;
    List<UserRoleRequest> listUserRoleRequests =
        context.watch<AuthProvider>().user!.user_role_requests;
    void getData() {
      if (listUserRoleRequests.isNotEmpty) {
        isHaveUserRoleActive = listUserRoleRequests[0].confirmater_id == null;
        request_role = listUserRoleRequests[0].request_role;
      }
    }

    getData();

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Padding(
        padding: paddingScreen,
        child: isHaveUserRoleActive
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Anda mempunyai Permintaan yang masih Aktif !',
                    style: smartRTTextTitle,
                  ),
                  SB_height15,
                  Text(
                    'Maaf anda tidak dapat melakukan permintaan update jabatan dikarenakan terdapat permintaan yang masih aktif.',
                    style: smartRTTextNormal,
                    textAlign: TextAlign.justify,
                  ),
                  SB_height15,
                  Text(
                    'Anda telah melakukan permintaan update jabatan dengan data sebagai berikut.',
                    style: smartRTTextNormal,
                    textAlign: TextAlign.justify,
                  ),
                  SB_height15,
                  Text(
                    "Tanggal Permintaan : ${DateFormat('d MMMM y', 'id_ID').format(DateTime.parse(listUserRoleRequests[0].created_at.toString()))}\n\nJabatan: ${Role.values[listUserRoleRequests[0].request_role - 1].toString().split('.').last.replaceAll('_', ' ')}",
                    style:
                        smartRTTextNormal.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.justify,
                  ),
                  SB_height15,
                  Text(
                    'Silahkan menunggu permintaan anda di konfirmasi oleh ketua RT atau anda dapat membatalkan permintaan tersebut dengan cara menekan tombol BATALKAN di bawah halaman ini.',
                    style: smartRTTextNormal,
                    textAlign: TextAlign.justify,
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Anda Pengurus Wilayah?',
                          style: smartRTTextTitle_Primary,
                        ),
                        Text(
                          'Masukkan kode kepengurusan wilayah anda yang didapatkan dari Ketua RT wilayah anda agar dapat mengakses fitur-fitur pengurus wilayah yang sudah disediakan',
                          style: smartRTTextNormal_Primary,
                        ),
                        SB_height15,
                        TextFormField(
                          controller: _requestCodeController,
                          autocorrect: false,
                          style: smartRTTextNormal_Primary,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Kode kepengurusan tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
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
            isHaveUserRoleActive
                ? batal(context, listUserRoleRequests[0])
                : kirim();
          },
          child: Text(
            isHaveUserRoleActive ? 'BATALKAN' : 'KIRIM',
            style: smartRTTextLargeBold_Secondary,
          ),
        ),
      ),
    );
  }
}
