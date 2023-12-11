import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/widgets/circle_avatar_loader/circle_avatar_loader.dart';

class DataWargaDetailPageArguments {
  User2 warga;
  DataWargaDetailPageArguments({required this.warga});
}

class DataWargaDetailPage extends StatelessWidget {
  static const String id = "DataWargaDetailPage";
  DataWargaDetailPageArguments args;
  DataWargaDetailPage({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    User2 warga = args.warga;
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
                          Text(
                            '${warga.full_name}',
                            style: smartRTTextLargeBold_Primary.copyWith(
                                color: Colors.white),
                          ),
                          Text(
                            warga.address ?? '-',
                            style:
                                smartRTTextNormal.copyWith(color: Colors.white),
                          ),
                          Text(
                            warga.phone,
                            style:
                                smartRTTextSmall.copyWith(color: Colors.white),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Nama Lengkap',
                                      style: smartRTTextNormalBold_Primary))),
                          Expanded(
                              flex: 2,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(': ${warga.full_name}'))),
                        ],
                      ),
                      SB_height5,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Role',
                                  style: smartRTTextNormalBold_Primary),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  ': ${warga.user_role.toString().split('.').last.replaceAll('_', ' ')}'),
                            ),
                          ),
                        ],
                      ),
                      SB_height5,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Nomor Telepon',
                                  style: smartRTTextNormalBold_Primary),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(': ${warga.phone}'),
                            ),
                          ),
                        ],
                      ),
                      SB_height5,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Alamat',
                                  style: smartRTTextNormalBold_Primary),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(': ${warga.address ?? '-'}'),
                            ),
                          ),
                        ],
                      ),
                      SB_height5,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Jenis Kelamin',
                                  style: smartRTTextNormalBold_Primary),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(': ${warga.gender}'),
                            ),
                          ),
                        ],
                      ),
                      SB_height5,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Tanggal Lahir',
                                  style: smartRTTextNormalBold_Primary),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  ': ${warga.born_date == null ? '-' : DateFormat('dd-MM-yyyy').format(warga.born_date!)}'),
                            ),
                          ),
                        ],
                      ),
                      SB_height5,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Tempat Lahir',
                                  style: smartRTTextNormalBold_Primary),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(': ${warga.born_at ?? '-'}'),
                            ),
                          ),
                        ],
                      ),
                      SB_height5,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Agama',
                                  style: smartRTTextNormalBold_Primary),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(': ${warga.religion ?? '-'}'),
                            ),
                          ),
                        ],
                      ),
                      SB_height5,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Status Perkawinan',
                                  style: smartRTTextNormalBold_Primary),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child:
                                  Text(': ${warga.status_perkawinan ?? '-'}'),
                            ),
                          ),
                        ],
                      ),
                      SB_height5,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Pekerjaan',
                                  style: smartRTTextNormalBold_Primary),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(': ${warga.profession ?? '-'}'),
                            ),
                          ),
                        ],
                      ),
                      SB_height5,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Status Kesehatan',
                                  style: smartRTTextNormalBold_Primary),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  ': ${warga.is_health == 1 ? 'Sehat' : 'Kurang Sehat'}'),
                            ),
                          ),
                        ],
                      ),
                      SB_height5,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Komite Pemilihan',
                                  style: smartRTTextNormalBold_Primary),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  ': ${warga.is_health == 1 ? 'Ya' : 'Bukan'}'),
                            ),
                          ),
                        ],
                      ),
                      SB_height5,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Jumlah Menjadi Ketua RT',
                                  style: smartRTTextNormalBold_Primary),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  ': ${warga.total_serving_as_neighbourhood_head} kali'),
                            ),
                          ),
                        ],
                      ),
                      SB_height5,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Jumlah Menjadi Petugas',
                                  style: smartRTTextNormalBold_Primary),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(': ${warga.jumlah_task} kali'),
                            ),
                          ),
                        ],
                      ),
                      SB_height5,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Rating',
                                  style: smartRTTextNormalBold_Primary),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(': ${warga.task_rating} dari 5'),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ))
        ]),
      ),
    );
  }
}
