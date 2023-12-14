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
import 'package:smart_rt/screens/public_screens/keuangan/iuran/tagihan_saya_page_detail.dart';
import 'package:smart_rt/utilities/string/currency_format.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class TagihanSayaPage extends StatefulWidget {
  static const String id = 'TagihanSayaPage';
  const TagihanSayaPage({Key? key}) : super(key: key);

  @override
  State<TagihanSayaPage> createState() => TagihanSayaPageState();
}

class TagihanSayaPageState extends State<TagihanSayaPage> {
  User user = AuthProvider.currentUser!;
  DateTime? _selected;
  DateTime monthYearCreated = DateTime(2023);
  String bulanTahun = '';
  String yearMonth = '';
  List<DropdownMenuItem> _filter = [];
  String _filterSelected = '0';

  Future<void> getData() async {
    context.read<AreaBillProvider>().futures[TagihanSayaPage.id] =
        context.read<AreaBillProvider>().getMyAllTagihan(yearMonth: yearMonth);
    context.read<AreaBillProvider>().updateListener();
    await context.read<AreaBillProvider>().futures[TagihanSayaPage.id];
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

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<AreaBillTransaction> listTagihanku =
        context.watch<AreaBillProvider>().listTagihanKu;
    return Scaffold(
      appBar: AppBar(
        title: Text('Tagihan Saya'),
      ),
      body: RefreshIndicator(
        onRefresh: () => getData(),
        child: FutureBuilder(
            future:
                context.watch<AreaBillProvider>().futures[TagihanSayaPage.id],
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
              //     context.watch<AreaBillProvider>().listTagihanku.isEmpty) {
              //   return Container(
              //     margin: EdgeInsets.all(15),
              //     child: ListView(
              //       children: [
              //         Text('Tidak ada riwayat transaksi!'),
              //       ],
              //     ),
              //   );
              // }

              return (snapshot.connectionState == ConnectionState.done &&
                      context.watch<AreaBillProvider>().listTagihanKu.isEmpty)
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
                      itemCount: listTagihanku.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, TagihanSayaPageDetail.id,
                                    arguments: TagihanSayaPageDetailArguments(
                                        index: index,
                                        dataAreaBill: listTagihanku[index]
                                            .dataAreaBill!));
                              },
                              title: Text(
                                listTagihanku[index].dataAreaBill!.name,
                                style: smartRTTextNormal.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: Text(
                                CurrencyFormat.convertToIdr(
                                    listTagihanku[index].bill_amount, 0),
                                style: smartRTTextNormal.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: (listTagihanku[index]
                                          .dataAreaBillRepeatDetail !=
                                      null)
                                  ? Text(
                                      'Iuran Bulanan\nBulan ${StringFormat.formatDate(dateTime: listTagihanku[index].dataAreaBillRepeatDetail!.month_year, isWithTime: false, formatDate: 'MMMM y')}',
                                      style: smartRTTextNormal,
                                    )
                                  : Text(
                                      'Iuran sekali bayar',
                                      style: smartRTTextNormal,
                                    ),
                            ),
                            if (index == listTagihanku.length - 1)
                              Divider(
                                color: smartRTPrimaryColor,
                                thickness: 1,
                                height: 5,
                              ),
                          ],
                        );
                      },
                    );
            }),
      ),
    );
  }
}
