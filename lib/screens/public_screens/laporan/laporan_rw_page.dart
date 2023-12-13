import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/area/area.dart';
import 'package:smart_rt/models/area/area_bill/area_bill_transaction.dart';
import 'package:smart_rt/models/event/event.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/utilities/string/currency_format.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/widgets/circle_avatar_loader/circle_avatar_loader.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class LaporanRWPage extends StatefulWidget {
  static const String id = 'LaporanRWPagePage';
  const LaporanRWPage({super.key});

  @override
  State<LaporanRWPage> createState() => _LaporanRWPageState();
}

class _LaporanRWPageState extends State<LaporanRWPage> {
  DateTime? _selected;
  DateTime monthYearCreated = DateTime(2023);
  String yearMonth = '';
  String bulanTahun = '';

  void showPDF() async {
    User user = AuthProvider.currentUser!;
    var netImage;
    netImage = await networkImage(
        '${backendURL}/public/uploads/users/${user.id}/signature/${user.sign_img}');

    List<User2> dataWarga = [];
    Response<dynamic> resp = await NetUtil().dioClient.get('/users/listWarga');
    dataWarga.addAll(resp.data.map<User2>((d) {
      User2 newWarga = User2.fromData(d);
      newWarga.jumlah_task = d['total_task'];
      return newWarga;
    }));

    String wilayah =
        'Kec. ${user.data_sub_district!.name}, Kel. ${user.data_urban_village!.name.substring(10)}, RW ${user.rw_num} / RT ${user.rt_num}';

    List<Event> listEvent = <Event>[];
    resp = await NetUtil()
        .dioClient
        .get('/event/get/filtered/yearMonth/$yearMonth');
    listEvent.addAll((resp.data).map<Event>((request) {
      return Event.fromData(request);
    }));

    List<AreaBillTransaction> listTransaksi = [];
    resp = await NetUtil()
        .dioClient
        .get('/iuran/transaksi/get/all/by-area/${user.area_id}');
    listTransaksi.addAll((resp.data).map<AreaBillTransaction>((request) {
      return AreaBillTransaction.fromData(request);
    }));

    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                pw.Text(
                  'RT ${StringFormat.numFormatRTRW(user.area!.rt_num.toString())} / RW ${StringFormat.numFormatRTRW(user.area!.rw_num.toString())}'
                      .toUpperCase(),
                  style: pw.TextStyle(
                    fontSize: 25,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
                pw.Text(
                  'Kel. ${user.data_urban_village!.name.substring(10)}, Kec. ${user.data_sub_district!.name}'
                      .toUpperCase(),
                  style: pw.TextStyle(
                    fontSize: 15,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
                pw.Text(
                  'KOTA SURABAYA'.toUpperCase(),
                  style: pw.TextStyle(
                    fontSize: 15,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
                pw.Divider(
                  height: 30,
                  thickness: 5,
                  color: PdfColor.fromHex('#000000'),
                ),
                pw.Text(
                  'LAPORAN RUKUN TETANGGA'.toUpperCase(),
                  style: pw.TextStyle(
                      fontSize: 15,
                      fontWeight: pw.FontWeight.bold,
                      decoration: pw.TextDecoration.underline),
                  textAlign: pw.TextAlign.center,
                ),
                pw.SizedBox(
                  height: 25,
                ),
                pw.Text(
                  'Saya ${user.full_name} sebagai Ketua Rukun Tetangga dari $wilayah akan melaporkan data warga, kesehatan, acara serta kegiatan yang telah di selenggarakan pada bulan ${StringFormat.formatDate(dateTime: _selected!, formatDate: 'MMMM y')}. \n\nBerikut merupakan lampiran yang akan dilampirkan, yaitu\no Laporan Data Warga\no Laporan Kesehatan\no Laporan Kegiatan Acara\n\nDemikian laporan ini saya buat, untuk dipergunakan sebagaimana mestinya.',
                  style: const pw.TextStyle(
                    fontSize: 12,
                  ),
                  textAlign: pw.TextAlign.justify,
                ),
                pw.SizedBox(height: 25),
                pw.Row(children: [
                  pw.Expanded(
                    child: pw.SizedBox(),
                  ),
                  pw.Expanded(
                    child: pw.SizedBox(),
                  ),
                  pw.Expanded(
                    child: pw.Text(
                      'Surabaya, ${StringFormat.formatDate(dateTime: DateTime.now(), isWithTime: false)}',
                      style: const pw.TextStyle(
                        fontSize: 12,
                      ),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                ]),
                pw.SizedBox(height: 25),
                pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.Column(
                        children: [
                          pw.Text(
                            'Ketua RW. ${StringFormat.numFormatRTRW(user.area!.rw_num.toString())}',
                            style: const pw.TextStyle(
                              fontSize: 12,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            'Kel. ${user.data_urban_village!.name.substring(10)}'
                                .toUpperCase(),
                            style: const pw.TextStyle(
                              fontSize: 12,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            'Ketua,',
                            style: const pw.TextStyle(
                              fontSize: 12,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.SizedBox(height: 75),
                          pw.Text(
                            '(                                       ),',
                            style: const pw.TextStyle(
                                fontSize: 12,
                                decoration: pw.TextDecoration.underline),
                            textAlign: pw.TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    pw.Expanded(
                      child: pw.SizedBox(),
                    ),
                    pw.Expanded(
                      child: pw.Column(
                        children: [
                          pw.Text(
                            'Ketua RT. ${StringFormat.numFormatRTRW(user.area!.rt_num.toString())}',
                            style: const pw.TextStyle(
                              fontSize: 12,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            'Kel. ${user.data_urban_village!.name.substring(10)}'
                                .toUpperCase(),
                            style: const pw.TextStyle(
                              fontSize: 12,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            'Ketua,',
                            style: const pw.TextStyle(
                              fontSize: 12,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.SizedBox(height: 75, child: pw.Image(netImage)),
                          pw.Text(
                            '( ${user.full_name} )',
                            style: const pw.TextStyle(
                                fontSize: 12,
                                decoration: pw.TextDecoration.underline),
                            textAlign: pw.TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ];
        },
      ),
    );

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                pw.Text('LAPORAN DATA WARGA',
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: pw.TextAlign.center),
                pw.Text(wilayah,
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 15,
                    ),
                    textAlign: pw.TextAlign.center),
                pw.Divider(
                  height: 30,
                  thickness: 5,
                  color: PdfColor.fromHex('#000000'),
                ),
              ],
            ),
            pw.Row(children: [
              pw.Expanded(
                child: pw.Text(
                  'Total Warga',
                  style: pw.TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              pw.Text(
                ' : ',
                style: pw.TextStyle(
                  fontSize: 15,
                ),
              ),
              pw.Expanded(
                flex: 3,
                child: pw.Text(
                  '${dataWarga.length.toString()} Orang',
                  style: pw.TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ]),
            pw.Divider(
              height: 15,
              thickness: 1,
              color: PdfColor.fromHex('#000000'),
            ),
            pw.Text(
              'DAFTAR WARGA',
              style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 15),
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
                        child: pw.Text('Sebagai',
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
                            ': ${d.born_date == null ? '-' : StringFormat.formatDate(dateTime: d.born_date!, isWithTime: false)}'),
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
                pw.Divider(thickness: 1, height: 15)
              ];
            }).reduce((a, b) => [...a, ...b]),
          ];
        },
      ),
    );

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                pw.Text('LAPORAN KEGIATAN ACARA',
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: pw.TextAlign.center),
                pw.Text(wilayah,
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 15,
                    ),
                    textAlign: pw.TextAlign.center),
                pw.Divider(
                  height: 30,
                  thickness: 5,
                  color: PdfColor.fromHex('#000000'),
                ),
              ],
            ),
            pw.Row(children: [
              pw.Expanded(
                child: pw.Text(
                  'Total Kegiatan',
                  style: pw.TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              pw.Text(
                ' : ',
                style: pw.TextStyle(
                  fontSize: 15,
                ),
              ),
              pw.Expanded(
                flex: 3,
                child: pw.Text(
                  '${listEvent.length.toString()} Acara',
                  style: pw.TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ]),
            pw.Divider(
              height: 15,
              thickness: 1,
              color: PdfColor.fromHex('#000000'),
            ),
            pw.Text(
              'DAFTAR KEGIATAN',
              style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 15),
            ...listEvent.map((d) {
              return [
                pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Expanded(
                        child: pw.Text(
                          'o',
                          style: pw.TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      pw.Expanded(
                          flex: 10,
                          child: pw.Column(children: [
                            pw.Row(children: [
                              pw.Expanded(
                                child: pw.Text(
                                  'Tanggal',
                                  style: pw.TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              pw.Text(
                                ' : ',
                                style: pw.TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              pw.Expanded(
                                flex: 3,
                                child: pw.Text(
                                  StringFormat.formatDate(
                                      dateTime: d.event_date_start_at,
                                      isWithTime: false),
                                  style: pw.TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ]),
                            pw.Row(children: [
                              pw.Expanded(
                                child: pw.Text(
                                  'Waktu',
                                  style: pw.TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              pw.Text(
                                ' : ',
                                style: pw.TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              pw.Expanded(
                                flex: 3,
                                child: pw.Text(
                                  '${DateFormat('HH:mm', 'id_ID').format(d.event_date_start_at)} - ${DateFormat('HH:mm', 'id_ID').format(d.event_date_end_at)} WIB',
                                  style: pw.TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ]),
                            pw.Row(children: [
                              pw.Expanded(
                                child: pw.Text(
                                  'Judul',
                                  style: pw.TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              pw.Text(
                                ' : ',
                                style: pw.TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              pw.Expanded(
                                flex: 3,
                                child: pw.Text(
                                  d.title,
                                  style: pw.TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ]),
                            pw.Row(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Expanded(
                                    child: pw.Text(
                                      'Detail',
                                      style: pw.TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  pw.Text(
                                    ' : ',
                                    style: pw.TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  pw.Expanded(
                                    flex: 3,
                                    child: pw.Text(
                                      d.detail,
                                      style: pw.TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ]),
                          ]))
                    ]),
                pw.SizedBox(height: 15),
              ];
            }).reduce((a, b) => [...a, ...b]),
          ];
        },
      ),
    );

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                pw.Text('RIWAYAT TRANSAKSI',
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                    ),
                    textAlign: pw.TextAlign.center),
                pw.Text(wilayah,
                    style: pw.TextStyle(
                      fontSize: 15,
                      fontWeight: pw.FontWeight.bold,
                    ),
                    textAlign: pw.TextAlign.center),
                pw.Divider(
                  height: 30,
                  thickness: 5,
                  color: PdfColor.fromHex('#000000'),
                ),
                pw.Row(children: [
                  pw.Expanded(
                    child: pw.Text(
                      'Waktu',
                      style: pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  pw.Text(
                    ' : ',
                    style: pw.TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text(
                      bulanTahun == ''
                          ? 'Semua'
                          : bulanTahun.substring(1, bulanTahun.length - 1),
                      style: pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ]),
                pw.Row(children: [
                  pw.Expanded(
                    child: pw.Text(
                      'Total Transaksi',
                      style: pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  pw.Text(
                    ' : ',
                    style: pw.TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text(
                      CurrencyFormat.convertToIdr(
                          listTransaksi
                              .map(
                                (e) => e.bill_amount,
                              )
                              .reduce(
                                (value, element) => value + element,
                              ),
                          2),
                      style: pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ]),
                pw.Divider(
                  height: 30,
                  thickness: 1,
                  color: PdfColor.fromHex('#000000'),
                ),
              ],
            ),
            ...listTransaksi.map((trans) {
              return [
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Expanded(child: pw.Text('o')),
                      pw.Expanded(
                        flex: 10,
                        child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                'Pembayaran oleh ${trans.dataUser!.full_name}',
                                style: pw.TextStyle(
                                  fontSize: 15,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                                textAlign: pw.TextAlign.left,
                              ),
                              pw.Text(
                                'Pembayaran untuk ${trans.dataAreaBill!.name}',
                                style: pw.TextStyle(
                                  fontSize: 15,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                                textAlign: pw.TextAlign.left,
                              ),
                              pw.Text(
                                'Transaksi via ${trans.payment_type ?? 'Bank Tranfer'}',
                                style: pw.TextStyle(
                                  fontSize: 15,
                                ),
                                textAlign: pw.TextAlign.left,
                              ),
                              pw.Text(
                                StringFormat.formatDate(
                                    dateTime: trans.updated_at!),
                                style: pw.TextStyle(
                                  fontSize: 15,
                                ),
                                textAlign: pw.TextAlign.left,
                              ),
                            ]),
                      ),
                      pw.Text(
                        '+${CurrencyFormat.convertToIdr(trans.bill_amount, 0)}',
                        style: pw.TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ]),
                pw.SizedBox(height: 15)
              ];
            }).reduce((a, b) => [...a, ...b])
          ];
        },
      ),
    );

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }

  Future<void> _onPressedMonthYearPicker({
    required BuildContext context,
    String? locale,
  }) async {
    final localeObj = locale != null ? Locale(locale) : null;
    final selected = await showMonthYearPicker(
      context: context,
      initialDate: _selected ?? DateTime.now(),
      firstDate: monthYearCreated,
      lastDate: DateTime.now(),
      locale: localeObj,
    );
    if (selected != null) {
      setState(() {
        _selected = selected;
        bulanTahun =
            '(${StringFormat.formatDate(dateTime: selected, formatDate: 'MMMM y')})';

        yearMonth = DateFormat('yyyy-MM', 'id_ID').format(_selected!);
      });
      showPDF();
    }
  }

  @override
  Widget build(BuildContext context) {
    Area area = context.watch<AuthProvider>().user!.area!;

    return Scaffold(
        appBar: AppBar(
          title: Text("Laporan untuk RW"),
        ),
        body: Padding(
          padding: paddingScreen,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text(
              'Berikut merupakan daftar laporan yang akan dibuat sebagai laporan untuk RW:',
              style: smartRTTextLarge,
            ),
            Text(
              'o Laporan Data Warga',
              style: smartRTTextLarge,
            ),
            Text(
              'o Laporan Kesehatan (Bulanan)',
              style: smartRTTextLarge,
            ),
            Text(
              'o Laporan Kegiatan / Acara (Bulanan)',
              style: smartRTTextLarge,
            ),
            SB_height15,
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: smartRTActiveColor2,
                ),
                onPressed: () async {
                  _onPressedMonthYearPicker(context: context);
                },
                child: Text(
                  'LIHAT LAPORAN (PDF)',
                  style: smartRTTextLarge.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            )
          ]),
        ));
  }
}
