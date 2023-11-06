import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/area/area.dart';
import 'package:smart_rt/models/area/sub_district.dart';
import 'package:smart_rt/models/area/urban_village.dart';
import 'package:smart_rt/providers/population_provider.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/widgets/cards/card_list_area.dart';
import 'package:smart_rt/screens/admin_screens/daftar_wilayah_surabaya/daftar_wilayah_surabaya_detail_page.dart';

class DaftarWilayahSurabayaPage extends StatefulWidget {
  static const String id = 'DaftarWilayahSurabayaPage';
  const DaftarWilayahSurabayaPage({Key? key}) : super(key: key);

  @override
  State<DaftarWilayahSurabayaPage> createState() =>
      _DaftarWilayahSurabayaPageState();
}

class _DaftarWilayahSurabayaPageState extends State<DaftarWilayahSurabayaPage> {
  List<Area> listAreaFiltered = [];
  List<Area> listArea = [];
  void getData() async {
    await context.read<PopulationProvider>().getListArea();
  }

  final List<SubDistrict> _listKecamatan = [];
  final List<UrbanVillage> _listKelurahan = [];
  List<UrbanVillage> _listKelurahanFiltered = [];

  final textEditingControllerKelurahan = TextEditingController();
  final textEditingControllerKecamatan = TextEditingController();
  final textEditingControllerRT = TextEditingController();
  final textEditingControllerRW = TextEditingController();

  String _kecamatanSelectedValue = '';
  String? _kelurahanSelectedValue = '';

  Future<void> loadKecamatan() async {
    Response<dynamic> resp =
        await NetUtil().dioClient.get("/addresses/subDistricts");

    setState(() {
      _listKecamatan.addAll(resp.data.map<SubDistrict>((request) {
        return SubDistrict.fromData(request);
      }));
    });
  }

  Future<void> loadKelurahan() async {
    Response<dynamic> resp =
        await NetUtil().dioClient.get("/addresses/urbanVillages");

    setState(() {
      _listKelurahan.addAll(resp.data.map<UrbanVillage>((request) {
        return UrbanVillage.fromData(request);
      }));
    });
  }

  // void filterDialog() async {
  //   showDialog<String>(
  //     context: context,
  //     builder: (BuildContext context) => AlertDialog(
  //       title: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text(
  //             'FILTER',
  //             style: smartRTTextTitleCard,
  //           ),
  //           GestureDetector(
  //               onTap: () {
  //                 Navigator.pop(context);
  //               },
  //               child: Icon(Icons.close)),
  //         ],
  //       ),
  //       actions: <Widget>[
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //           child: DropdownButtonFormField2(
  //             style: smartRTTextLargeBold_Primary,
  //             decoration: InputDecoration(
  //               isDense: true,
  //               contentPadding: EdgeInsets.zero,
  //               border: OutlineInputBorder(
  //                 borderRadius: BorderRadius.circular(15),
  //               ),
  //             ),
  //             dropdownMaxHeight: 200,
  //             searchController: textEditingControllerKecamatan,
  //             searchInnerWidget: Padding(
  //               padding: const EdgeInsets.only(
  //                 top: 8,
  //                 bottom: 4,
  //                 right: 8,
  //                 left: 8,
  //               ),
  //               child: TextFormField(
  //                 controller: textEditingControllerKecamatan,
  //                 decoration: InputDecoration(
  //                   isDense: true,
  //                   contentPadding: const EdgeInsets.symmetric(
  //                     horizontal: 10,
  //                     vertical: 8,
  //                   ),
  //                   hintText: 'Search for an item...',
  //                   hintStyle: smartRTTextLargeBold_Primary,
  //                   border: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(8),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             searchMatchFn: (item, searchValue) {
  //               debugPrint(item.toString());
  //               List<String> ids = _listKecamatan
  //                   .where(
  //                     (element) => element.name
  //                         .toUpperCase()
  //                         .contains(searchValue.toUpperCase()),
  //                   )
  //                   .map(
  //                     (e) => e.id.toString(),
  //                   )
  //                   .toList();
  //               return ids.contains(item.value.toString());
  //             },
  //             onMenuStateChange: (isOpen) {
  //               if (!isOpen) {
  //                 textEditingControllerKecamatan.clear();
  //               }
  //             },
  //             isExpanded: true,
  //             hint: Text(
  //               'Kecamatan',
  //               style: smartRTTextLargeBold_Primary,
  //             ),
  //             icon: Icon(
  //               Icons.arrow_drop_down,
  //               color: smartRTPrimaryColor,
  //             ),
  //             iconSize: 30,
  //             buttonHeight: 60,
  //             buttonPadding: const EdgeInsets.only(left: 25, right: 10),
  //             dropdownDecoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(5),
  //             ),
  //             items: _listKecamatan
  //                 .map((item) => DropdownMenuItem<String>(
  //                       value: item.id.toString(),
  //                       child: Text(
  //                         item.name,
  //                         style: smartRTTextNormal_Primary,
  //                       ),
  //                     ))
  //                 .toList(),
  //             validator: (value) {
  //               if (value == null) {
  //                 return 'Kecamatan tidak boleh kosong';
  //               }
  //             },
  //             onChanged: (value) {
  //               setState(() {
  //                 _kecamatanSelectedValue = value.toString();
  //                 _kelurahanSelectedValue = null;
  //                 _listKelurahanFiltered = _listKelurahan
  //                     .where((element) =>
  //                         element.idKecamatan.toString() ==
  //                         _kecamatanSelectedValue)
  //                     .toList();
  //               });
  //             },
  //             onSaved: (value) {
  //               _kecamatanSelectedValue = value.toString();
  //             },
  //           ),
  //         ),
  //         SB_height15,
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //           child: DropdownButtonFormField2(
  //               style: smartRTTextLargeBold_Primary,
  //               decoration: InputDecoration(
  //                 isDense: true,
  //                 contentPadding: EdgeInsets.zero,
  //                 border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(15),
  //                 ),
  //               ),
  //               dropdownMaxHeight: 200,
  //               searchController: textEditingControllerKelurahan,
  //               searchInnerWidget: Padding(
  //                 padding: const EdgeInsets.only(
  //                   top: 8,
  //                   bottom: 4,
  //                   right: 8,
  //                   left: 8,
  //                 ),
  //                 child: TextFormField(
  //                   controller: textEditingControllerKelurahan,
  //                   decoration: InputDecoration(
  //                     isDense: true,
  //                     contentPadding: const EdgeInsets.symmetric(
  //                       horizontal: 10,
  //                       vertical: 8,
  //                     ),
  //                     hintText: 'Search for an item...',
  //                     hintStyle: smartRTTextLargeBold_Primary,
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               searchMatchFn: (item, searchValue) {
  //                 debugPrint(item.toString());
  //                 List<String> ids = _listKelurahanFiltered
  //                     .where(
  //                       (element) => element.name
  //                           .toUpperCase()
  //                           .contains(searchValue.toUpperCase()),
  //                     )
  //                     .map(
  //                       (e) => e.id.toString(),
  //                     )
  //                     .toList();
  //                 return ids.contains(item.value.toString());
  //               },
  //               onMenuStateChange: (isOpen) {
  //                 if (!isOpen) {
  //                   textEditingControllerKelurahan.clear();
  //                 }
  //               },
  //               isExpanded: true,
  //               hint: Text(
  //                 'Kelurahan',
  //                 style: smartRTTextLargeBold_Primary,
  //               ),
  //               disabledHint: Text(
  //                 'Kelurahan',
  //                 style: smartRTTextLargeBold_Primary.copyWith(
  //                     color: smartRTDisabledColor),
  //               ),
  //               icon: const Icon(
  //                 Icons.arrow_drop_down,
  //               ),
  //               iconDisabledColor: smartRTDisabledColor,
  //               iconEnabledColor: smartRTPrimaryColor,
  //               iconSize: 30,
  //               buttonHeight: 60,
  //               buttonPadding: const EdgeInsets.only(left: 25, right: 10),
  //               dropdownDecoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(5),
  //               ),
  //               items: _listKelurahanFiltered
  //                   .map((item) => DropdownMenuItem<String>(
  //                         value: item.id.toString(),
  //                         child: Text(
  //                           item.name,
  //                           style: smartRTTextNormal_Primary,
  //                         ),
  //                       ))
  //                   .toList(),
  //               validator: (value) {
  //                 if (value == null) {
  //                   return 'Kelurahan tidak boleh kosong';
  //                 }
  //               },
  //               onChanged: _kecamatanSelectedValue.isNotEmpty
  //                   ? (value) {
  //                       setState(() {
  //                         _kelurahanSelectedValue = value.toString();
  //                       });
  //                     }
  //                   : null,
  //               onSaved: (value) {
  //                 _kelurahanSelectedValue = value.toString();
  //               },
  //               value: _kelurahanSelectedValue),
  //         ),
  //         SB_height15,
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //           child: Row(
  //             children: [
  //               Expanded(
  //                 child: TextFormField(
  //                   controller: textEditingControllerRW,
  //                   autocorrect: false,
  //                   style: smartRTTextNormal_Primary,
  //                   decoration: const InputDecoration(
  //                     labelText: 'RW',
  //                   ),
  //                 ),
  //               ),
  //               SB_width15,
  //               Expanded(
  //                 child: TextFormField(
  //                   controller: textEditingControllerRT,
  //                   autocorrect: false,
  //                   style: smartRTTextNormal_Primary,
  //                   decoration: const InputDecoration(
  //                     labelText: 'RT',
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         SB_height15,
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             TextButton(
  //               onPressed: () {
  //                 _kecamatanSelectedValue = '';
  //                 _kelurahanSelectedValue = '';
  //                 textEditingControllerRT.text = '';
  //                 textEditingControllerRW.text = '';
  //                 filter();
  //               },
  //               child: Text(
  //                 'Clear',
  //                 style: smartRTTextNormal,
  //               ),
  //             ),
  //             TextButton(
  //               onPressed: () {
  //                 filter();
  //               },
  //               child: Text(
  //                 'CARI SEKARANG!',
  //                 style: smartRTTextNormal.copyWith(
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  void filterDialog() async {
    // Buat Data yang akan dilempar ke widget Filter
    DaftarWilayahFilterState last = DaftarWilayahFilterState(
        currentKecamatan: _kecamatanSelectedValue,
        currentKelurahan: _kelurahanSelectedValue ?? "",
        currentRT: textEditingControllerRT.text,
        currentRW: textEditingControllerRW.text);

    showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'FILTER',
                style: smartRTTextTitleCard,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.close)),
            ],
          ),
          content: DaftarWilayahFilter(
            lastState: last,
            listKecamatan: _listKecamatan,
            listKelurahan: _listKelurahan,
            filterCallback:
                (String kecamatan, String kelurahan, String RT, String RW) {
              setState(() {
                _kecamatanSelectedValue = kecamatan;
                _kelurahanSelectedValue = kelurahan;
                textEditingControllerRT.text = RT;
                textEditingControllerRW.text = RW;
              });
            },
          ),
        );
      },
    );
  }

  void filter() async {
    debugPrint('-----------------0');
    if (_kecamatanSelectedValue == '' &&
        _kelurahanSelectedValue == '' &&
        textEditingControllerRT.text == '' &&
        textEditingControllerRW.text == '') {
      listAreaFiltered = listArea;
      debugPrint('-----------------1');
      debugPrint(listAreaFiltered.length.toString());
    } else {
      debugPrint('textEditingControllerKecamatan.text');
      debugPrint(_kecamatanSelectedValue);
      listAreaFiltered = listArea
          .where((x) =>
              (_kecamatanSelectedValue == '' ||
                  x.data_kecamatan!.id
                      .toString()
                      .contains(_kecamatanSelectedValue)) &&
              (_kelurahanSelectedValue == '' ||
                  x.data_kelurahan!.id
                      .toString()
                      .contains(_kelurahanSelectedValue ?? '')) &&
              (textEditingControllerRT.text == '' ||
                  x.rt_num.toString().contains(textEditingControllerRT.text)) &&
              (textEditingControllerRW.text == '' ||
                  x.rw_num.toString().contains(textEditingControllerRW.text)))
          .toList();
    }
    debugPrint('aaaaaaaaaaaaaaaaaaaaa');
    debugPrint(listAreaFiltered.length.toString());
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    loadKecamatan();
    loadKelurahan();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    listArea = context.watch<PopulationProvider>().listArea;
    listAreaFiltered = listArea.where(
      (element) {
        return ((_kecamatanSelectedValue == "" ||
                element.data_kecamatan!.id.toString() ==
                    _kecamatanSelectedValue) &&
            (_kelurahanSelectedValue == "" ||
                element.data_kelurahan!.id.toString() ==
                    _kelurahanSelectedValue) &&
            (textEditingControllerRT.text == "" ||
                element.rt_num.toString() == textEditingControllerRT.text) &&
            (textEditingControllerRW.text == "" ||
                element.rw_num.toString() == textEditingControllerRW.text));
      },
    ).toList();

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Daftar Wilayah Surabaya'),
          actions: [
            GestureDetector(
                onTap: () {
                  filterDialog();
                },
                child: Icon(Icons.filter_alt)),
            SB_width15,
          ],
        ),
        body: listAreaFiltered.isNotEmpty
            ? ListView.separated(
                separatorBuilder: (context, int) {
                  return Divider(
                    color: smartRTPrimaryColor,
                    thickness: 1,
                    height: 5,
                  );
                },
                itemCount: listAreaFiltered.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      CardListArea(
                          kecamatan: StringFormat.kecamatanFormat(
                              kecamatan:
                                  listAreaFiltered[index].data_kecamatan!.name),
                          kelurahan: StringFormat.kelurahanFormat(
                              kelurahan:
                                  listAreaFiltered[index].data_kelurahan!.name),
                          rtNum: listAreaFiltered[index].rt_num.toString(),
                          rwNum: listAreaFiltered[index].rw_num.toString(),
                          totalPopulasi: listAreaFiltered[index]
                              .total_population
                              .toString(),
                          ketuaRTNama:
                              listAreaFiltered[index].ketua_id!.full_name,
                          ketuaRTAlamat:
                              listAreaFiltered[index].ketua_id!.address ?? '',
                          ketuaRTTelp: listAreaFiltered[index].ketua_id!.phone,
                          onTap: () {
                            Navigator.pushNamed(
                                context, DaftarWilayahSurabayaDetailPage.id,
                                arguments:
                                    DaftarWilayahSurabayaDetailPageArguments(
                                        index: index));
                          }),
                      if (index == listArea.length - 1)
                        Divider(
                          color: smartRTPrimaryColor,
                          thickness: 1,
                          height: 5,
                        ),
                    ],
                  );
                },
              )
            : Center(
                child: Text(
                  "Tidak ada Wilayah Terdaftar",
                  style: smartRTTextLarge.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
      ),
    );
  }
}

class DaftarWilayahFilterState {
  final String currentKecamatan;
  final String currentKelurahan;
  final String currentRT;
  final String currentRW;

  DaftarWilayahFilterState(
      {required this.currentKecamatan,
      required this.currentKelurahan,
      required this.currentRT,
      required this.currentRW});
}

class DaftarWilayahFilter extends StatefulWidget {
  final DaftarWilayahFilterState lastState;
  final List<SubDistrict> listKecamatan;
  final List<UrbanVillage> listKelurahan;
  final Function filterCallback;

  const DaftarWilayahFilter(
      {super.key,
      required this.lastState,
      required this.listKecamatan,
      required this.listKelurahan,
      required this.filterCallback});

  @override
  State<DaftarWilayahFilter> createState() => _DaftarWilayahFilterState();
}

class _DaftarWilayahFilterState extends State<DaftarWilayahFilter> {
  final TextEditingController textEditingControllerKecamatan =
      TextEditingController();
  final TextEditingController textEditingControllerKelurahan =
      TextEditingController();
  final TextEditingController textEditingControllerRT = TextEditingController();
  final TextEditingController textEditingControllerRW = TextEditingController();

  List<UrbanVillage> _filteredKelurahan = [];

  String selectedKecamatan = "";
  String selectedKelurahan = "";

  @override
  void initState() {
    super.initState();
    selectedKecamatan = widget.lastState.currentKecamatan;
    selectedKelurahan = widget.lastState.currentKelurahan;
    textEditingControllerRT.text = widget.lastState.currentRT;
    textEditingControllerRW.text = widget.lastState.currentRW;
  }

  @override
  Widget build(BuildContext context) {
    // Ambil data kelurahan yang kecamatannya = selectedKecamatan
    _filteredKelurahan = widget.listKelurahan
        .where((kelurahan) =>
            kelurahan.idKecamatan.toString() == selectedKecamatan)
        .toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: DropdownButtonFormField2(
            style: smartRTTextLargeBold_Primary,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            dropdownMaxHeight: 200,
            searchController: textEditingControllerKecamatan,
            searchInnerWidget: Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 4,
                right: 8,
                left: 8,
              ),
              child: TextFormField(
                controller: textEditingControllerKecamatan,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  hintText: 'Search for an item...',
                  hintStyle: smartRTTextLargeBold_Primary,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            searchMatchFn: (item, searchValue) {
              List<String> ids = widget.listKecamatan
                  .where(
                    (element) => element.name
                        .toUpperCase()
                        .contains(searchValue.toUpperCase()),
                  )
                  .map(
                    (e) => e.id.toString(),
                  )
                  .toList();
              return ids.contains(item.value.toString());
            },
            onMenuStateChange: (isOpen) {
              if (!isOpen) {
                textEditingControllerKecamatan.clear();
              }
            },
            isExpanded: true,
            hint: Text(
              'Kecamatan',
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
            items: widget.listKecamatan
                .map((item) => DropdownMenuItem<String>(
                      value: item.id.toString(),
                      child: Text(
                        item.name,
                        style: smartRTTextNormal_Primary,
                      ),
                    ))
                .toList(),
            validator: (value) {
              if (value == null) {
                return 'Kecamatan tidak boleh kosong';
              }
              return null;
            },
            value: selectedKecamatan.isNotEmpty ? selectedKecamatan : null,
            onChanged: (value) {
              setState(() {
                selectedKecamatan = value.toString();
                selectedKelurahan = "";
              });
            },
          ),
        ),
        SB_height15,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: DropdownButtonFormField2(
            style: smartRTTextLargeBold_Primary,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            dropdownMaxHeight: 200,
            searchController: textEditingControllerKelurahan,
            searchInnerWidget: Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 4,
                right: 8,
                left: 8,
              ),
              child: TextFormField(
                controller: textEditingControllerKelurahan,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  hintText: 'Search for an item...',
                  hintStyle: smartRTTextLargeBold_Primary,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            searchMatchFn: (item, searchValue) {
              debugPrint(item.toString());
              List<String> ids = _filteredKelurahan
                  .where(
                    (element) => element.name
                        .toUpperCase()
                        .contains(searchValue.toUpperCase()),
                  )
                  .map(
                    (e) => e.id.toString(),
                  )
                  .toList();
              return ids.contains(item.value.toString());
            },
            onMenuStateChange: (isOpen) {
              if (!isOpen) {
                textEditingControllerKelurahan.clear();
              }
            },
            isExpanded: true,
            hint: Text(
              'Kelurahan',
              style: smartRTTextLargeBold_Primary,
            ),
            disabledHint: Text(
              'Kelurahan',
              style: smartRTTextLargeBold_Primary.copyWith(
                  color: smartRTDisabledColor),
            ),
            icon: const Icon(
              Icons.arrow_drop_down,
            ),
            iconDisabledColor: smartRTDisabledColor,
            iconEnabledColor: smartRTPrimaryColor,
            iconSize: 30,
            buttonHeight: 60,
            buttonPadding: const EdgeInsets.only(left: 25, right: 10),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            items: _filteredKelurahan
                .map((item) => DropdownMenuItem<String>(
                      value: item.id.toString(),
                      child: Text(
                        item.name,
                        style: smartRTTextNormal_Primary,
                      ),
                    ))
                .toList(),
            validator: (value) {
              if (value == null) {
                return 'Kelurahan tidak boleh kosong';
              }
              return null;
            },
            value: selectedKelurahan.isNotEmpty ? selectedKelurahan : null,
            onChanged: _filteredKelurahan.isNotEmpty
                ? (value) {
                    setState(() {
                      selectedKelurahan = value.toString();
                    });
                  }
                : null,
          ),
        ),
        SB_height15,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: textEditingControllerRW,
                  autocorrect: false,
                  style: smartRTTextNormal_Primary,
                  decoration: const InputDecoration(
                    labelText: 'RW',
                  ),
                ),
              ),
              SB_width15,
              Expanded(
                child: TextFormField(
                  controller: textEditingControllerRT,
                  autocorrect: false,
                  style: smartRTTextNormal_Primary,
                  decoration: const InputDecoration(
                    labelText: 'RT',
                  ),
                ),
              ),
            ],
          ),
        ),
        SB_height15,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                widget.filterCallback("", "", "", "");
                Navigator.pop(context);
              },
              child: Text(
                'Clear',
                style: smartRTTextNormal,
              ),
            ),
            TextButton(
              onPressed: () {
                widget.filterCallback(selectedKecamatan, selectedKelurahan,
                    textEditingControllerRT.text, textEditingControllerRW.text);
                Navigator.pop(context);
              },
              child: Text(
                'CARI SEKARANG!',
                style: smartRTTextNormal.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
