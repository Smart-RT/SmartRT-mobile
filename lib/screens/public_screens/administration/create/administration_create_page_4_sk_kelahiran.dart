import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/administration/administration_type.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/screens/public_screens/administration/administration_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/parts/explain_part.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:http_parser/http_parser.dart';

class AdministrationCreatePage4SKKelahiranArgument {
  AdministrationType admType;
  String creatorFullname;
  String creatorAnakKe;
  String creatorBornplace;
  String creatorBorndate;
  String creatorGender;

  String creatorDadFullname;
  String creatorDadBornDate;
  String creatorDadBornPlace;
  String creatorDadKTPNum;
  String creatorDadAddress;
  String creatorDadJob;
  CroppedFile croppedDadImageKTP;
  AdministrationCreatePage4SKKelahiranArgument(
      {required this.admType,
      required this.creatorFullname,
      required this.creatorAnakKe,
      required this.creatorBornplace,
      required this.creatorBorndate,
      required this.creatorGender,
      required this.creatorDadAddress,
      required this.creatorDadBornDate,
      required this.creatorDadBornPlace,
      required this.creatorDadFullname,
      required this.creatorDadJob,
      required this.creatorDadKTPNum,
      required this.croppedDadImageKTP});
}

class AdministrationCreatePage4SKKelahiran extends StatefulWidget {
  static const String id = 'AdministrationCreatePage4SKKelahiran';
  AdministrationCreatePage4SKKelahiranArgument args;
  AdministrationCreatePage4SKKelahiran({Key? key, required this.args})
      : super(key: key);

  @override
  State<AdministrationCreatePage4SKKelahiran> createState() =>
      _AdministrationCreatePage4SKKelahiranState();
}

class _AdministrationCreatePage4SKKelahiranState
    extends State<AdministrationCreatePage4SKKelahiran> {
  User user = AuthProvider.currentUser!;
  final _TECCreatorMomFullname = TextEditingController();
  final _TECCreatorMomKTPNum = TextEditingController();
  final _TECCreatorMomBornPlace = TextEditingController();
  final _TECCreatorMomBornDate = TextEditingController();
  final _TECCreatorMomAddress = TextEditingController();
  final _TECCreatorMomJob = TextEditingController();
  AdministrationType? admType;
  String titleExplain = '';
  String detailExplain = '';

  CroppedFile? croppedImageKTP;
  final ImagePicker _picker = ImagePicker();

  void getData() async {
    admType = widget.args.admType;
    titleExplain = 'DATA IBU';
    detailExplain =
        'Isilah semua form dibawah ini! Pastikan data ibu sudah sesuai dan valid!';

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

  void buatPermohonanSuratPengantar() async {
    if (cekData()) {
      try {
        MultipartFile multipartKTPDad = await MultipartFile.fromFile(
            (widget.args.croppedDadImageKTP).path,
            filename: (widget.args.croppedDadImageKTP).path.split('/').last,
            contentType: MediaType(
                'image',
                (widget.args.croppedDadImageKTP)
                    .path
                    .split('/')
                    .last
                    .split('.')
                    .last));

        MultipartFile multipartKTPMom = await MultipartFile.fromFile(
            croppedImageKTP!.path,
            filename: croppedImageKTP!.path.split('/').last,
            contentType: MediaType('image',
                croppedImageKTP!.path.split('/').last.split('.').last));
        var formData = FormData.fromMap({});

        formData = FormData.fromMap({
          "administration_type_id": widget.args.admType.id,
          "creator_fullname": widget.args.creatorFullname,
          "creator_anak_ke": widget.args.creatorAnakKe,
          "creator_born_place": widget.args.creatorBornplace,
          "creator_born_date": widget.args.creatorDadBornDate,
          "creator_gender": widget.args.creatorGender,
          "creator_dad_name": widget.args.creatorDadFullname,
          "creator_dad_bornplace": widget.args.creatorDadBornPlace,
          "creator_dad_borndate": widget.args.creatorDadBornDate,
          "creator_dad_job": widget.args.creatorDadJob,
          "creator_dad_address": widget.args.creatorDadAddress,
          "creator_dad_ktp_num": widget.args.creatorDadKTPNum,
          "creator_dad_ktp_img": multipartKTPDad,
          "creator_mom_name": _TECCreatorMomFullname.text,
          "creator_mom_bornplace": _TECCreatorMomBornPlace.text,
          "creator_mom_borndate": _TECCreatorMomBornDate.text,
          "creator_mom_job": _TECCreatorMomJob.text,
          "creator_mom_address": _TECCreatorMomAddress.text,
          "creator_mom_ktp_num": _TECCreatorMomKTPNum.text,
          "creator_mom_ktp_img": multipartKTPMom,
        });

        Response<dynamic> resp = await NetUtil().dioClient.post(
            '/administration/add/permohonan-surat-pengantar',
            data: formData);

        SmartRTSnackbar.show(context,
            message: resp.data.toString(),
            backgroundColor: smartRTSuccessColor);

        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.popAndPushNamed(context, AdministrationPage.id);
      } on DioError catch (e) {
        if (e.response != null) {
          debugPrint(e.response!.data.toString());
          SmartRTSnackbar.show(context,
              message: e.response!.data.toString(),
              backgroundColor: smartRTErrorColor);
        }
      }
    }
  }

  bool cekData() {
    if (_TECCreatorMomFullname.text.isEmpty ||
        _TECCreatorMomKTPNum.text.isEmpty ||
        _TECCreatorMomAddress.text.isEmpty ||
        _TECCreatorMomBornDate.text.isEmpty ||
        _TECCreatorMomBornPlace.text.isEmpty ||
        _TECCreatorMomJob.text.isEmpty ||
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
        title: Text('Buat Surat Pengantar [ 3 / 3 ]'),
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
                controller: _TECCreatorMomFullname,
                autocorrect: false,
                style: smartRTTextNormal_Primary,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                ),
              ),
              SB_height15,
              TextFormField(
                controller: _TECCreatorMomKTPNum,
                autocorrect: false,
                style: smartRTTextNormal_Primary,
                decoration: const InputDecoration(
                  labelText: 'Nomor KTP',
                ),
              ),
              SB_height15,
              TextFormField(
                controller: _TECCreatorMomBornPlace,
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
                controller: _TECCreatorMomBornDate,
              ),
              SB_height15,
              TextFormField(
                controller: _TECCreatorMomAddress,
                autocorrect: false,
                style: smartRTTextNormal_Primary,
                decoration: const InputDecoration(
                  labelText: 'Alamat',
                ),
              ),
              SB_height15,
              TextFormField(
                controller: _TECCreatorMomJob,
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
            buatPermohonanSuratPengantar();
          },
          child: Text(
            'BUAT PERMOHONAN',
            style: smartRTTextLargeBold_Secondary,
          ),
        ),
      ),
    );
  }
}
