import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/widgets/circle_avatar_loader/circle_avatar_loader.dart';
import 'package:smart_rt/screens/public_screens/data_warga/data_warga_detail.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class DataWargaPage extends StatefulWidget {
  static const String id = 'DataWargaPage';
  const DataWargaPage({super.key});

  @override
  State<DataWargaPage> createState() => _DataWargaPageState();
}

class _DataWargaPageState extends State<DataWargaPage> {
  List<User2> dataWarga = [];

  Future<void> getData() async {
    try {
      Response<dynamic> resp =
          await NetUtil().dioClient.get('/users/listWarga');
      if (resp.statusCode.toString() == '200') {
        dataWarga.addAll(resp.data.map<User2>((d) {
          User2 newWarga = User2.fromData(d);
          newWarga.jumlah_task = d['total_task'];
          return newWarga;
        }));
        setState(() {});
      }
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  void exportPdf() async {
    User user = AuthProvider.currentUser!;
    String wilayah =
        'Kec. ${user.data_sub_district!.name}, Kel. ${user.data_urban_village!.name.substring(10)}\nRW ${user.rw_num} / RT ${user.rt_num}';
    final pdf = pw.Document();
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              pw.Text('LAPORAN DATA WARGA',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.center),
              pw.Text(wilayah,
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.center),
              pw.Divider(
                height: 30,
                thickness: 5,
                color: PdfColor.fromHex('#000000'),
              ),
            ],
          ),
          ...dataWarga.map((d) {
            return [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Expanded(
                      child: pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text('Nama Lengkap',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              )))),
                  pw.Expanded(
                      flex: 2,
                      child: pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text(': ${d.full_name}'))),
                ],
              ),
              pw.SizedBox(
                height: 5,
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text('Role',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          )),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(
                          ': ${d.user_role.toString().split('.').last.replaceAll('_', ' ')}'),
                    ),
                  ),
                ],
              ),
              pw.SizedBox(
                height: 5,
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text('Nomor Telepon',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          )),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(': ${d.phone}'),
                    ),
                  ),
                ],
              ),
              pw.SizedBox(
                height: 5,
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text('Alamat',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          )),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(': ${d.address ?? '-'}'),
                    ),
                  ),
                ],
              ),
              pw.SizedBox(
                height: 5,
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text('Jenis Kelamin',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          )),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(': ${d.gender}'),
                    ),
                  ),
                ],
              ),
              pw.SizedBox(
                height: 5,
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text('Tanggal Lahir',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          )),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(
                          ': ${d.born_date == null ? '-' : DateFormat('dd-MM-yyyy').format(d.born_date!)}'),
                    ),
                  ),
                ],
              ),
              pw.SizedBox(
                height: 5,
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text('Tempat Lahir',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          )),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(': ${d.born_at ?? '-'}'),
                    ),
                  ),
                ],
              ),
              pw.SizedBox(
                height: 5,
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text('Agama',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          )),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(': ${d.religion ?? '-'}'),
                    ),
                  ),
                ],
              ),
              pw.SizedBox(
                height: 5,
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text('Status Perkawinan',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          )),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(': ${d.status_perkawinan ?? '-'}'),
                    ),
                  ),
                ],
              ),
              pw.SizedBox(
                height: 5,
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text('Pekerjaan',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          )),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(': ${d.profession ?? '-'}'),
                    ),
                  ),
                ],
              ),
              pw.SizedBox(
                height: 5,
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text('Status Kesehatan',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          )),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(
                          ': ${d.is_health == 1 ? 'Sehat' : 'Kurang Sehat'}'),
                    ),
                  ),
                ],
              ),
              pw.SizedBox(
                height: 5,
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text('Komite Pemilihan',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          )),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(': ${d.is_health == 1 ? 'Ya' : 'Bukan'}'),
                    ),
                  ),
                ],
              ),
              pw.SizedBox(
                height: 5,
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text('Jumlah Menjadi Ketua RT',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          )),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(
                          ': ${d.total_serving_as_neighbourhood_head} kali'),
                    ),
                  ),
                ],
              ),
              pw.SizedBox(
                height: 5,
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text('Jumlah Menjadi Petugas',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          )),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(': ${d.jumlah_task} kali'),
                    ),
                  ),
                ],
              ),
              pw.SizedBox(
                height: 5,
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Expanded(
                    flex: 1,
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text('Rating',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          )),
                    ),
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(': ${d.task_rating} dari 5'),
                    ),
                  ),
                ],
              ),
              pw.Divider(thickness: 5, height: 15)
            ];
          }).reduce((a, b) => [...a, ...b]),
        ];
      },
    ));

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Data Warga'), actions: [
        IconButton(
            onPressed: () {
              exportPdf();
            },
            icon: Icon(Icons.picture_as_pdf))
      ]),
      body: Container(
        child: ListView.separated(
          separatorBuilder: (context, int) {
            return Divider(
              color: smartRTPrimaryColor,
              height: 5,
            );
          },
          itemCount: dataWarga.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatarLoader(
                radius: 50,
                photoPathUrl:
                    '${backendURL}/public/uploads/users/${dataWarga[index].id}/profile_picture/',
                photo: dataWarga[index].photo_profile_img.toString(),
                initials: StringFormat.initialName(dataWarga[index].full_name),
                initialColor: smartRTPrimaryColor,
              ),
              title: Text('${dataWarga[index].full_name}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dataWarga[index].address ?? '-'),
                  Text(dataWarga[index].user_role != Role.Warga
                      ? dataWarga[index]
                          .user_role
                          .toString()
                          .split('.')
                          .last
                          .replaceAll('_', ' ')
                      : 'Warga (${dataWarga[index].is_temporary_inhabitant == 0 ? 'Tetap' : 'Sementara'})')
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, DataWargaDetailPage.id,
                    arguments:
                        DataWargaDetailPageArguments(warga: dataWarga[index]));
              },
            );
          },
        ),
      ),
    );
  }
}
