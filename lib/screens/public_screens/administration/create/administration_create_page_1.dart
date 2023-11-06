import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/administration/administration_type.dart';
import 'package:smart_rt/screens/public_screens/administration/create/administration_create_page_2.dart';
import 'package:smart_rt/screens/public_screens/administration/create/administration_create_page_2_sk_kelahiran.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/parts/explain_part.dart';

class AdministrationCreatePage1 extends StatefulWidget {
  static const String id = 'AdministrationCreatePage1';
  const AdministrationCreatePage1({Key? key}) : super(key: key);

  @override
  State<AdministrationCreatePage1> createState() =>
      _AdministrationCreatePage1State();
}

class _AdministrationCreatePage1State extends State<AdministrationCreatePage1> {
  List<AdministrationType> listAdministrationType = [];
  String _administrationTypeSelectedItems = '';
  AdministrationType? _administrationType;
  List<DropdownMenuItem> _listAdministrationTypeItems = [
    const DropdownMenuItem(
      value: '',
      child: Text(''),
    ),
  ];

  void selanjutnya() async {
    if (_administrationType!.id == 6) {
      AdministrationCreatePage2SKKelahiranArgument args =
          AdministrationCreatePage2SKKelahiranArgument(
              admType: _administrationType!);
      Navigator.pushNamed(context, AdministrationCreatePage2SKKelahiran.id,
          arguments: args);
    } else {
      AdministrationCreatePage2Argument args =
          AdministrationCreatePage2Argument(admType: _administrationType!);
      Navigator.pushNamed(context, AdministrationCreatePage2.id,
          arguments: args);
    }
  }

  List<DropdownMenuItem<String>> _addDividersAfterItems(
      List<AdministrationType> items) {
    List<DropdownMenuItem<String>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item.id.toString(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(item.name,
                  style:
                      smartRTTextNormal.copyWith(fontWeight: FontWeight.bold)),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            DropdownMenuItem<String>(
              enabled: false,
              child: Divider(
                height: 0,
                color: smartRTTertiaryColor,
              ),
            ),
        ],
      );
    }
    return _menuItems;
  }

  void getData() async {
    Response<dynamic> resp =
        await NetUtil().dioClient.get('/administration/types');
    listAdministrationType.clear();
    listAdministrationType
        .addAll((resp.data).map<AdministrationType>((request) {
      return AdministrationType.fromData(request);
    }));

    _listAdministrationTypeItems.clear();
    _listAdministrationTypeItems =
        _addDividersAfterItems(listAdministrationType);
    _administrationTypeSelectedItems = _listAdministrationTypeItems[0].value;
    _administrationType = listAdministrationType[0];
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buat Surat Pengantar'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: paddingScreen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ExplainPart(
                  title: 'SURAT PENGANTAR',
                  notes:
                      'Anda dapat mengajukan surat pengantar kepada Ketua RT untuk dikonfirmasi! Pilihlah surat pengantar yang anda butuhkan!'),
              SB_height15,
              DropdownButtonFormField2(
                dropdownMaxHeight: 200,
                value: _listAdministrationTypeItems[0].value,
                scrollbarRadius: const Radius.circular(40),
                scrollbarThickness: 6,
                scrollbarAlwaysShow: true,
                style: smartRTTextNormal.copyWith(fontWeight: FontWeight.bold),
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
                buttonPadding: const EdgeInsets.only(left: 10, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                items: _listAdministrationTypeItems
                    .map((item) => DropdownMenuItem<String>(
                          value: item.value,
                          child: item.child,
                          enabled: item.enabled,
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
                    _administrationTypeSelectedItems = value.toString();
                    int idx = int.parse(value.toString()) - 1;
                    _administrationType = listAdministrationType[idx];
                  });
                },
                onSaved: (value) {
                  _administrationTypeSelectedItems = value.toString();
                  int idx = int.parse(value.toString()) - 1;
                  _administrationType = listAdministrationType[idx];
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ))),
          onPressed: () {
            selanjutnya();
          },
          child: Text(
            'SELANJUTNYA',
            style: smartRTTextLargeBold_Secondary,
          ),
        ),
      ),
    );
  }
}
