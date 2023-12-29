import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/screens/public_screens/image_view/image_view_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/widgets/circle_avatar_loader/circle_avatar_loader.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_data_1.dart';
import 'package:http_parser/http_parser.dart';

class DataWargaDetailPageArguments {
  User2 warga;
  DataWargaDetailPageArguments({required this.warga});
}

class DataWargaDetailPage extends StatefulWidget {
  static const String id = "DataWargaDetailPage";
  DataWargaDetailPageArguments args;
  DataWargaDetailPage({super.key, required this.args});

  @override
  State<DataWargaDetailPage> createState() => _DataWargaDetailPageState();
}

class _DataWargaDetailPageState extends State<DataWargaDetailPage> {
  @override
  Widget build(BuildContext context) {
    User2 warga = widget.args.warga;
    final ImagePicker _picker = ImagePicker();
    final List<String> jenisPenduduk = [
      'Tetap',
      'Sementara',
    ];

    void _pickImage(String type) async {
      CroppedFile? croppedImageKTP;
      CroppedFile? croppedImageKK;
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        if (type == 'KTP') {
          croppedImageKTP = await ImageCropper().cropImage(
            sourcePath: image.path,
          );
          MultipartFile multipartKTP = await MultipartFile.fromFile(
              croppedImageKTP!.path,
              filename: croppedImageKTP!.path.split('/').last,
              contentType: MediaType('image',
                  croppedImageKTP!.path.split('/').last.split('.').last));
          var formData =
              FormData.fromMap({"ktp": multipartKTP, "uid": warga.id});

          Response<dynamic> resp = await NetUtil()
              .dioClient
              .patch('/users/upload/ktp', data: formData);

          setState(() {});
          if (resp.statusCode == 200) {
            warga.ktp_photo = resp.data.toString();
            SmartRTSnackbar.show(context,
                message: 'Berhasil mengunggah foto KTP',
                backgroundColor: smartRTSuccessColor);
          } else {
            SmartRTSnackbar.show(context,
                message: 'Gagal mengunggah foto KTP',
                backgroundColor: smartRTErrorColor);
          }
        } else {
          croppedImageKK =
              await ImageCropper().cropImage(sourcePath: image.path);
          MultipartFile multipartKK = await MultipartFile.fromFile(
              croppedImageKK!.path,
              filename: croppedImageKK!.path.split('/').last,
              contentType: MediaType('image',
                  croppedImageKK.path.split('/').last.split('.').last));
          var formData = FormData.fromMap({"kk": multipartKK, "uid": warga.id});

          Response<dynamic> resp = await NetUtil()
              .dioClient
              .patch('/users/upload/kk', data: formData);

          setState(() {});
          if (resp.statusCode == 200) {
            warga.kk_photo = resp.data.toString();
            SmartRTSnackbar.show(context,
                message: 'Berhasil mengunggah foto KK',
                backgroundColor: smartRTSuccessColor);
          } else {
            SmartRTSnackbar.show(context,
                message: 'Gagal mengunggah foto KK',
                backgroundColor: smartRTErrorColor);
          }
        }
      }
    }

    void showFormJenisPenduduk() async {
      String _jenisPendudukUserSelected =
          warga.is_temporary_inhabitant == 0 ? 'Tetap' : 'Sementara';

      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          backgroundColor: smartRTSecondaryColor,
          title: Text(
            'Jenis Penduduk',
            style: smartRTTextTitleCard_Primary,
          ),
          content: Text(
            'Penduduk tetap adalah penduduk yang mempunyai KK dan KTP berdomisili pada wilayah anda, sedangkan sementara adalah penduduk pendatang sementara.',
            style: smartRTTextNormal_Primary.copyWith(
                fontWeight: FontWeight.normal),
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingCard.bottom),
              child: DropdownButtonFormField2(
                value: _jenisPendudukUserSelected,
                style: smartRTTextLarge_Primary,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                isExpanded: true,
                hint: Text(
                  'Jenis Penduduk',
                  style: smartRTTextLargeBold_Primary,
                ),
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: smartRTPrimaryColor,
                ),
                iconSize: 30,
                buttonHeight: 60,
                buttonPadding: const EdgeInsets.only(left: 25, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                items: jenisPenduduk
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: smartRTTextNormal_Primary,
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  _jenisPendudukUserSelected = value.toString();
                },
                onSaved: (value) {
                  _jenisPendudukUserSelected = value.toString();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingCard.bottom),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Batal'),
                    child: Text(
                      'Batal',
                      style: smartRTTextLarge_Primary,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      Response<dynamic> resp = await NetUtil()
                          .dioClient
                          .patch('/users/update/jenis-penduduk', data: {
                        "is_temporary_inhabitant":
                            _jenisPendudukUserSelected == 'Tetap' ? 0 : 1,
                        "uid": warga.id,
                      });
                      warga.is_temporary_inhabitant =
                          _jenisPendudukUserSelected == 'Tetap' ? 0 : 1;
                      setState(() {});
                      Navigator.pop(context);
                      if (resp.statusCode == 200) {
                        SmartRTSnackbar.show(context,
                            message: 'Berhasil merubah jenis penduduk',
                            backgroundColor: smartRTSuccessColor);
                      } else {
                        SmartRTSnackbar.show(context,
                            message: 'Gagal merubah jenis penduduk',
                            backgroundColor: smartRTErrorColor);
                      }
                    },
                    child: Text(
                      'Simpan',
                      style: smartRTTextLarge.copyWith(
                          color: smartRTActiveColor2,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Warga'),
      ),
      body: Container(
        child: Column(children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    color: smartRTPrimaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatarLoader(
                            radius: 50,
                            photoPathUrl:
                                '${backendURL}/public/uploads/users/${warga.id}/profile_picture/',
                            photo: warga.photo_profile_img,
                            initials: warga.initialName(),
                          ),
                          SB_height15,
                          Text('${warga.full_name}',
                              style: smartRTTextTitleCard.copyWith(
                                  color: smartRTSecondaryColor)),
                          Text(
                            warga.address ?? '-',
                            style: smartRTTextLarge.copyWith(
                                color: smartRTSecondaryColor),
                          ),
                          Text(
                            warga.phone,
                            style: smartRTTextLarge.copyWith(
                                color: smartRTSecondaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            flex: 1,
          ),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListTileData1(
                        txtLeft: 'Nama Lengkap',
                        txtRight: warga.full_name,
                      ),
                      Divider(
                        thickness: 1,
                        color: smartRTActiveColor,
                        height: 15,
                      ),
                      ListTileData1(
                          txtLeft: 'Jabatan',
                          txtRight: warga.user_role
                              .toString()
                              .split('.')
                              .last
                              .replaceAll('_', ' ')),
                      Divider(
                        thickness: 1,
                        color: smartRTActiveColor,
                        height: 15,
                      ),
                      ListTileData1(
                          txtLeft: 'Jenis Penduduk',
                          txtRight: warga.is_temporary_inhabitant == 0
                              ? 'Tetap'
                              : 'Sementara',
                          onTap: () {
                            showFormJenisPenduduk();
                          },
                          isShowIconArrow: true),
                      Divider(
                        thickness: 1,
                        color: smartRTActiveColor,
                        height: 15,
                      ),
                      ListTileData1(
                          txtLeft: 'Nomor Telepon', txtRight: warga.phone),
                      Divider(
                        thickness: 1,
                        color: smartRTActiveColor,
                        height: 15,
                      ),
                      ListTileData1(
                          txtLeft: 'Warga Negara',
                          txtRight: warga.nationality ?? '-'),
                      Divider(
                        thickness: 1,
                        color: smartRTActiveColor,
                        height: 15,
                      ),
                      ListTileData1(
                          txtLeft: 'Alamat', txtRight: warga.address ?? '-'),
                      Divider(
                        thickness: 1,
                        color: smartRTActiveColor,
                        height: 15,
                      ),
                      ListTileData1(
                          txtLeft: 'Jenis Kelamin', txtRight: warga.gender),
                      Divider(
                        thickness: 1,
                        color: smartRTActiveColor,
                        height: 15,
                      ),
                      ListTileData1(
                          txtLeft: 'Tempat Lahir',
                          txtRight: warga.born_at ?? '-'),
                      Divider(
                        thickness: 1,
                        color: smartRTActiveColor,
                        height: 15,
                      ),
                      ListTileData1(
                          txtLeft: 'Tanggal Lahir',
                          txtRight: StringFormat.formatDate(
                              dateTime: warga.born_date!, isWithTime: false)),
                      Divider(
                        thickness: 1,
                        color: smartRTActiveColor,
                        height: 15,
                      ),
                      ListTileData1(
                          txtLeft: 'Agama', txtRight: warga.religion ?? '-'),
                      Divider(
                        thickness: 1,
                        color: smartRTActiveColor,
                        height: 15,
                      ),
                      ListTileData1(
                          txtLeft: 'Status Perkawinan',
                          txtRight: warga.status_perkawinan ?? '-'),
                      Divider(
                        thickness: 1,
                        color: smartRTActiveColor,
                        height: 15,
                      ),
                      ListTileData1(
                          txtLeft: 'Pekerjaan',
                          txtRight: warga.profession ?? '-'),
                      Divider(
                        thickness: 1,
                        color: smartRTActiveColor,
                        height: 15,
                      ),
                      ListTileData1(
                        txtLeft: 'Foto KTP',
                        txtRight: warga.ktp_photo == null ? '-' : 'Lihat File',
                        isShowIconArrow: warga.ktp_photo == null ? false : true,
                        onTap: () {
                          ImageViewPageArgument args = ImageViewPageArgument(
                              imgLocation:
                                  '${backendURL}/public/uploads/users/${warga.id}/KTP/${warga.ktp_photo}');
                          Navigator.pushNamed(context, ImageViewPage.id,
                              arguments: args);
                        },
                      ),
                      SB_height15,
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _pickImage('KTP');
                            // Navigator.pushNamed(context, FormTugasPage.id,
                            //     arguments: FormTugasPageArgument(
                            //         dataEventIdx: dataEventIdx));
                          },
                          child: Text(
                            'Unggah Foto KTP',
                            style: smartRTTextLargeBold_Secondary,
                          ),
                        ),
                      ),

                      Divider(
                        thickness: 1,
                        color: smartRTActiveColor,
                        height: 15,
                      ),
                      ListTileData1(
                        txtLeft: 'Foto KK',
                        txtRight: warga.kk_photo == null ? '-' : 'Lihat File',
                        isShowIconArrow: warga.kk_photo == null ? false : true,
                        onTap: () {
                          ImageViewPageArgument args = ImageViewPageArgument(
                              imgLocation:
                                  '${backendURL}/public/uploads/users/${warga.id}/KK/${warga.kk_photo}');
                          Navigator.pushNamed(context, ImageViewPage.id,
                              arguments: args);
                        },
                      ),
                      SB_height15,
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _pickImage('KK');
                            // Navigator.pushNamed(context, FormTugasPage.id,
                            //     arguments: FormTugasPageArgument(
                            //         dataEventIdx: dataEventIdx));
                          },
                          child: Text(
                            'Unggah Foto KK',
                            style: smartRTTextLargeBold_Secondary,
                          ),
                        ),
                      ),

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Expanded(
                      //       flex: 1,
                      //       child: Align(
                      //         alignment: Alignment.centerLeft,
                      //         child: Text('Jenis Kelamin',
                      //             style: smartRTTextNormalBold_Primary),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       flex: 2,
                      //       child: Align(
                      //         alignment: Alignment.centerLeft,
                      //         child: Text(': ${warga.gender}'),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SB_height5,
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Expanded(
                      //       flex: 1,
                      //       child: Align(
                      //         alignment: Alignment.centerLeft,
                      //         child: Text('Tanggal Lahir',
                      //             style: smartRTTextNormalBold_Primary),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       flex: 2,
                      //       child: Align(
                      //         alignment: Alignment.centerLeft,
                      //         child: Text(
                      //             ': ${warga.born_date == null ? '-' : DateFormat('dd-MM-yyyy').format(warga.born_date!)}'),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SB_height5,
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Expanded(
                      //       flex: 1,
                      //       child: Align(
                      //         alignment: Alignment.centerLeft,
                      //         child: Text('Tempat Lahir',
                      //             style: smartRTTextNormalBold_Primary),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       flex: 2,
                      //       child: Align(
                      //         alignment: Alignment.centerLeft,
                      //         child: Text(': ${warga.born_at ?? '-'}'),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SB_height5,
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Expanded(
                      //       flex: 1,
                      //       child: Align(
                      //         alignment: Alignment.centerLeft,
                      //         child: Text('Agama',
                      //             style: smartRTTextNormalBold_Primary),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       flex: 2,
                      //       child: Align(
                      //         alignment: Alignment.centerLeft,
                      //         child: Text(': ${warga.religion ?? '-'}'),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SB_height5,
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Expanded(
                      //       flex: 1,
                      //       child: Align(
                      //         alignment: Alignment.centerLeft,
                      //         child: Text('Status Perkawinan',
                      //             style: smartRTTextNormalBold_Primary),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       flex: 2,
                      //       child: Align(
                      //         alignment: Alignment.centerLeft,
                      //         child:
                      //             Text(': ${warga.status_perkawinan ?? '-'}'),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SB_height5,
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Expanded(
                      //       flex: 1,
                      //       child: Align(
                      //         alignment: Alignment.centerLeft,
                      //         child: Text('Pekerjaan',
                      //             style: smartRTTextNormalBold_Primary),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       flex: 2,
                      //       child: Align(
                      //         alignment: Alignment.centerLeft,
                      //         child: Text(': ${warga.profession ?? '-'}'),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SB_height5,
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Expanded(
                      //       flex: 1,
                      //       child: Align(
                      //         alignment: Alignment.centerLeft,
                      //         child: Text('Status Kesehatan',
                      //             style: smartRTTextNormalBold_Primary),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       flex: 2,
                      //       child: Align(
                      //         alignment: Alignment.centerLeft,
                      //         child: Text(
                      //             ': ${warga.is_health == 1 ? 'Sehat' : 'Kurang Sehat'}'),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SB_height5,
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Expanded(
                      //       flex: 1,
                      //       child: Align(
                      //         alignment: Alignment.centerLeft,
                      //         child: Text('Komite Pemilihan',
                      //             style: smartRTTextNormalBold_Primary),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       flex: 2,
                      //       child: Align(
                      //         alignment: Alignment.centerLeft,
                      //         child: Text(
                      //             ': ${warga.is_health == 1 ? 'Ya' : 'Bukan'}'),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SB_height5,
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Expanded(
                      //       flex: 1,
                      //       child: Align(
                      //         alignment: Alignment.centerLeft,
                      //         child: Text('Jumlah Menjadi Ketua RT',
                      //             style: smartRTTextNormalBold_Primary),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       flex: 2,
                      //       child: Align(
                      //         alignment: Alignment.centerLeft,
                      //         child: Text(
                      //             ': ${warga.total_serving_as_neighbourhood_head} kali'),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SB_height5,
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Expanded(
                      //       flex: 1,
                      //       child: Align(
                      //         alignment: Alignment.centerLeft,
                      //         child: Text('Jumlah Menjadi Petugas',
                      //             style: smartRTTextNormalBold_Primary),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       flex: 2,
                      //       child: Align(
                      //         alignment: Alignment.centerLeft,
                      //         child: Text(': ${warga.jumlah_task} kali'),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SB_height5,
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Expanded(
                      //       flex: 1,
                      //       child: Align(
                      //         alignment: Alignment.centerLeft,
                      //         child: Text('Rating',
                      //             style: smartRTTextNormalBold_Primary),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       flex: 2,
                      //       child: Align(
                      //         alignment: Alignment.centerLeft,
                      //         child: Text(': ${warga.task_rating} dari 5'),
                      //       ),
                      //     ),
                      //   ],
                      // )
                    ],
                  ),
                ),
              ))
        ]),
      ),
    );
  }
}
