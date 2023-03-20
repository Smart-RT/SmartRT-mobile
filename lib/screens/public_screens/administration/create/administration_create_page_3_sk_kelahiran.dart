import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/administration/administration_type.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/parts/explain_part.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:smart_rt/screens/public_screens/administration/create/administration_create_page_4_sk_kelahiran.dart';

class AdministrationCreatePage3SKKelahiranArgument {
  AdministrationType admType;
  String creatorFullname;
  String creatorAnakKe;
  String creatorBornplace;
  String creatorBorndate;
  String creatorGender;
  AdministrationCreatePage3SKKelahiranArgument({
    required this.admType,
    required this.creatorFullname,
    required this.creatorAnakKe,
    required this.creatorBornplace,
    required this.creatorBorndate,
    required this.creatorGender,
  });
}

class AdministrationCreatePage3SKKelahiran extends StatefulWidget {
  static const String id = 'AdministrationCreatePage3SKKelahiran';
  AdministrationCreatePage3SKKelahiranArgument args;
  AdministrationCreatePage3SKKelahiran({Key? key, required this.args})
      : super(key: key);

  @override
  State<AdministrationCreatePage3SKKelahiran> createState() =>
      _AdministrationCreatePage3SKKelahiranState();
}

class _AdministrationCreatePage3SKKelahiranState
    extends State<AdministrationCreatePage3SKKelahiran> {
  User user = AuthProvider.currentUser!;
  final _TECCreatorDadFullname = TextEditingController();
  final _TECCreatorDadKTPNum = TextEditingController();
  final _TECCreatorDadBornPlace = TextEditingController();
  final _TECCreatorDadBornDate = TextEditingController();
  final _TECCreatorDadAddress = TextEditingController();
  final _TECCreatorDadJob = TextEditingController();
  AdministrationType? admType;
  String titleExplain = '';
  String detailExplain = '';

  CroppedFile? croppedImageKTP;
  final ImagePicker _picker = ImagePicker();

  void getData() async {
    debugPrint(widget.args.creatorBorndate);
    admType = widget.args.admType;
    titleExplain = 'DATA AYAH';
    detailExplain =
        'Isilah semua form dibawah ini! Pastikan data ayah sudah sesuai dan valid!';

    setState(() {});
  }

  void _pickImage(String type) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      croppedImageKTP = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [CropAspectRatioPreset.ratio16x9]);
      setState(() {});
    }
  }

  void selanjutnya() async {
    if (cekData()) {
      AdministrationCreatePage4SKKelahiranArgument args =
          AdministrationCreatePage4SKKelahiranArgument(
        admType: admType!,
        creatorFullname: widget.args.creatorFullname,
        creatorAnakKe: widget.args.creatorAnakKe,
        creatorBorndate: widget.args.creatorBorndate,
        creatorBornplace: widget.args.creatorBornplace,
        creatorGender: widget.args.creatorGender,
        creatorDadFullname: _TECCreatorDadFullname.text,
        creatorDadAddress: _TECCreatorDadAddress.text,
        creatorDadBornDate: _TECCreatorDadBornDate.text,
        creatorDadBornPlace: _TECCreatorDadBornPlace.text,
        creatorDadJob: _TECCreatorDadJob.text,
        creatorDadKTPNum: _TECCreatorDadKTPNum.text,
        croppedDadImageKTP: croppedImageKTP!,
      );
      Navigator.pushNamed(context, AdministrationCreatePage4SKKelahiran.id,
          arguments: args);
    }
  }

  bool cekData() {
    if (_TECCreatorDadFullname.text.isEmpty ||
        _TECCreatorDadKTPNum.text.isEmpty ||
        _TECCreatorDadAddress.text.isEmpty ||
        _TECCreatorDadBornDate.text.isEmpty ||
        _TECCreatorDadBornPlace.text.isEmpty ||
        _TECCreatorDadJob.text.isEmpty ||
        croppedImageKTP == null) {
      SmartRTSnackbar.show(context,
          message: 'Pastikan semua data terisi !',
          backgroundColor: smartRTErrorColor);
      return false;
    }
    return true;
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
        title: Text('Buat Surat Pengantar [ 2 / 3 ]'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: paddingScreen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ExplainPart(
                title: titleExplain,
                notes: detailExplain,
              ),
              SB_height30,
              TextFormField(
                controller: _TECCreatorDadFullname,
                autocorrect: false,
                style: smartRTTextNormal_Primary,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                ),
              ),
              SB_height15,
              TextFormField(
                controller: _TECCreatorDadKTPNum,
                autocorrect: false,
                style: smartRTTextNormal_Primary,
                decoration: const InputDecoration(
                  labelText: 'Nomor KTP',
                ),
              ),
              SB_height15,
              TextFormField(
                controller: _TECCreatorDadBornPlace,
                autocorrect: false,
                style: smartRTTextNormal_Primary,
                decoration: const InputDecoration(
                  labelText: 'Tempat Lahir',
                ),
              ),
              SB_height15,
              DateTimePicker(
                type: DateTimePickerType.date,
                locale: const Locale('id', 'ID'),
                dateMask: 'dd MMMM yyyy',
                style: smartRTTextNormal_Primary,
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                dateLabelText: 'Tanggal Lahir',
                onChanged: (val) => print(val),
                onSaved: (val) => print(val),
                controller: _TECCreatorDadBornDate,
              ),
              SB_height15,
              TextFormField(
                controller: _TECCreatorDadAddress,
                autocorrect: false,
                style: smartRTTextNormal_Primary,
                decoration: const InputDecoration(
                  labelText: 'Alamat',
                ),
              ),
              SB_height15,
              TextFormField(
                controller: _TECCreatorDadJob,
                autocorrect: false,
                style: smartRTTextNormal_Primary,
                decoration: const InputDecoration(
                  labelText: 'Pekerjaan',
                ),
              ),
              SB_height30,
              Text(
                'Foto KTP',
                style: smartRTTextTitleCard_Primary,
              ),
              SB_height15,
              AspectRatio(
                aspectRatio: 16 / 9,
                child: croppedImageKTP == null
                    ? GestureDetector(
                        onTap: () {
                          _pickImage('KTP');
                        },
                        child: Container(
                          color: smartRTShadowColor,
                          child: Icon(
                            Icons.add_circle_outlined,
                            size: 50,
                            color: smartRTPrimaryColor,
                          ),
                        ),
                      )
                    : Stack(
                        children: [
                          Image.file(File(croppedImageKTP!.path)),
                          Positioned(
                              bottom: 1,
                              right: 1,
                              child: GestureDetector(
                                onTap: () {
                                  _pickImage('KTP');
                                },
                                child: Stack(
                                  children: [
                                    Icon(
                                      Icons.image,
                                      size: 45,
                                      color: smartRTPrimaryColor,
                                    ),
                                    Positioned(
                                      top: 1,
                                      right: 1,
                                      child: Icon(
                                        Icons.change_circle,
                                        size: 20,
                                        color: smartRTTertiaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
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
