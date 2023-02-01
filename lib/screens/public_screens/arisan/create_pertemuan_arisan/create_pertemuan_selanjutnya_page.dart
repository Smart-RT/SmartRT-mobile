import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/widgets/parts/explain_part.dart';

class CreatePertemuanSelanjutnyaPage extends StatefulWidget {
  static const String id = 'CreatePertemuanSelanjutnyaPage';
  const CreatePertemuanSelanjutnyaPage({Key? key}) : super(key: key);

  @override
  State<CreatePertemuanSelanjutnyaPage> createState() =>
      _CreatePertemuanSelanjutnyaPageState();
}

class _CreatePertemuanSelanjutnyaPageState
    extends State<CreatePertemuanSelanjutnyaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: paddingScreen,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const ExplainPart(title: 'PERTEMUAN KE-X', notes: ''),
                  SB_height15,
                  TextFormField(
                    initialValue: 'Rumah Pak RT',
                    readOnly: true,
                    autocorrect: false,
                    style: smartRTTextNormal_Primary,
                    decoration: const InputDecoration(
                      labelText: 'Tempat Pertemuan',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Tidak boleh kosong';
                      }
                    },
                  ),
                  SB_height15,
                  DateTimePicker(
                    type: DateTimePickerType.date,
                    dateMask: 'yyyy/MM/dd',
                    style: smartRTTextNormal_Primary,
                    initialDate: DateTime.now().add(Duration(days: 8)),
                    firstDate: DateTime.now().add(Duration(days: 8)),
                    lastDate: DateTime.now().add(Duration(days: 30)),
                    dateLabelText: 'Tanggal Pertemuan',
                    onChanged: (val) => print(val),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Tanggal Pertemuan tidak boleh kosong";
                      }
                    },
                    onSaved: (val) => print(val),
                  ),
                  SB_height30,
                ],
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {},
                  child: Text(
                    'SIMPAN',
                    style: smartRTTextLargeBold_Secondary,
                  ),
                ),
              ),
              SB_height15,
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {},
                  child: Text(
                    'SIMPAN DAN PUBLIKASIKAN',
                    style: smartRTTextLargeBold_Secondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
