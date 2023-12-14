import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:smart_rt/models/area/area_bill/area_bill_transaction.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/area_bill_provider.dart';
import 'package:smart_rt/screens/public_screens/keuangan/iuran/lihat_list_iuran_page_detail.dart';
import 'package:smart_rt/utilities/string/currency_format.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class RiwayatTransaksiKu extends StatefulWidget {
  static const String id = 'RiwayatTransaksiKu';
  const RiwayatTransaksiKu({Key? key}) : super(key: key);

  @override
  State<RiwayatTransaksiKu> createState() => RiwayatTransaksiKuState();
}

class RiwayatTransaksiKuState extends State<RiwayatTransaksiKu> {
  User user = AuthProvider.currentUser!;
  DateTime? _selected;
  DateTime monthYearCreated = DateTime(2023);
  String bulanTahun = '';
  String yearMonth = '';
  List<DropdownMenuItem> _filter = [];
  String _filterSelected = '0';

  Future<void> getData() async {
    context.read<AreaBillProvider>().futures[RiwayatTransaksiKu.id] =
        context.read<AreaBillProvider>().getMyTransaksi(yearMonth: yearMonth);
    context.read<AreaBillProvider>().updateListener();
    await context.read<AreaBillProvider>().futures[RiwayatTransaksiKu.id];
    _filter = [
      DropdownMenuItem(
        value: '0',
        child: Text('Semua'),
      ),
      DropdownMenuItem(
        value: '1',
        child: Text('Bulanan ${bulanTahun}'),
      ),
    ];
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
      getData();
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<AreaBillTransaction> listTransaksi =
        context.watch<AreaBillProvider>().listTransaksiKu;
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Transaksiku'),
      ),
      body: RefreshIndicator(
        onRefresh: () => getData(),
        child: FutureBuilder(
            future: context
                .watch<AreaBillProvider>()
                .futures[RiwayatTransaksiKu.id],
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Container(
                  margin: EdgeInsets.all(15),
                  child: ListView(
                    children: [
                      Text('Terjadi kesalahan, mohon refresh data...'),
                    ],
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  margin: EdgeInsets.all(15),
                  child: ListView(
                    children: [
                      Text('Sedang mengambil data, mohon tunggu...'),
                    ],
                  ),
                );
              }

              // if (snapshot.connectionState == ConnectionState.done &&
              //     context.watch<AreaBillProvider>().listTransaksi.isEmpty) {
              //   return Container(
              //     margin: EdgeInsets.all(15),
              //     child: ListView(
              //       children: [
              //         Text('Tidak ada riwayat transaksi!'),
              //       ],
              //     ),
              //   );
              // }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: smartRTActiveColor,
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        DropdownButtonFormField2(
                          dropdownMaxHeight: 200,
                          value: _filterSelected,
                          style: smartRTTextNormal.copyWith(
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          isExpanded: true,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: smartRTPrimaryColor,
                          ),
                          iconSize: 30,
                          buttonHeight: 60,
                          buttonPadding:
                              const EdgeInsets.only(left: 10, right: 10),
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          items: _filter
                              .map((item) => DropdownMenuItem<String>(
                                    value: item.value,
                                    child: item.child,
                                  ))
                              .toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'Tidak boleh kosong';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              _filterSelected = value.toString();
                              debugPrint(_filterSelected);
                              if (value == '1') {
                                _onPressedMonthYearPicker(context: context);
                              } else {
                                yearMonth = '';
                                bulanTahun = '';
                              }
                              getData();
                            });
                          },
                          onSaved: (value) {
                            _filterSelected = value.toString();
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: (snapshot.connectionState == ConnectionState.done &&
                            context
                                .watch<AreaBillProvider>()
                                .listTransaksiKu
                                .isEmpty)
                        ? Center(
                            child: Text(
                              'Tidak ada transaksi',
                              style: smartRTTextLarge.copyWith(
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        : ListView.separated(
                            separatorBuilder: (context, int) {
                              return Divider(
                                color: smartRTPrimaryColor,
                                height: 5,
                                thickness: 1,
                              );
                            },
                            itemCount: listTransaksi.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ListTile(
                                      onTap: () {},
                                      title: Text(
                                        'Pembayaran oleh ${listTransaksi[index].dataUser!.full_name}',
                                        style: smartRTTextNormal.copyWith(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      trailing: Text(
                                        '+${CurrencyFormat.convertToIdr(listTransaksi[index].bill_amount, 0)}',
                                        style: smartRTTextNormal.copyWith(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              'Pembayaran untuk ${listTransaksi[index].dataAreaBill!.name}',
                                              style: smartRTTextNormal,
                                            ),
                                            Text(
                                              'Transaksi via ${listTransaksi[index].payment_type ?? 'Bank Transfer'}',
                                              style: smartRTTextNormal,
                                            ),
                                            SB_height5,
                                            Text(
                                              StringFormat.formatDate(
                                                  dateTime: listTransaksi[index]
                                                      .updated_at!),
                                              style: smartRTTextSmall,
                                            ),
                                          ])),
                                  if (index == listTransaksi.length - 1)
                                    Divider(
                                      color: smartRTPrimaryColor,
                                      thickness: 1,
                                      height: 5,
                                    ),
                                ],
                              );
                            },
                          ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
