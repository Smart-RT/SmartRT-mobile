import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/administration/administration_type.dart';
import 'package:smart_rt/models/user.dart';
import 'package:smart_rt/screens/public_screens/administration/administration_page.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/widgets/parts/explain_part.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:http_parser/http_parser.dart';

class AdministrationCreatePage5Argument {
  AdministrationType admType;
  String creatorFullname;
  String creatorAddress;
  String creatorNoKTP;
  String creatorNoKK;
  String creatorBornPlace;
  String creatorBornDate;
  String creatorGender;
  String creatorReligion;
  String creatorWeddingStatus;
  String creatorJob;
  String creatorNationality;
  AdministrationCreatePage5Argument({
    required this.admType,
    required this.creatorFullname,
    required this.creatorAddress,
    required this.creatorNoKTP,
    required this.creatorNoKK,
    required this.creatorBornPlace,
    required this.creatorBornDate,
    required this.creatorGender,
    required this.creatorReligion,
    required this.creatorWeddingStatus,
    required this.creatorJob,
    required this.creatorNationality,
  });
}

class AdministrationCreatePage5 extends StatefulWidget {
  static const String id = 'AdministrationCreatePage5';
  AdministrationCreatePage5Argument args;
  AdministrationCreatePage5({Key? key, required this.args}) : super(key: key);

  @override
  State<AdministrationCreatePage5> createState() =>
      _AdministrationCreatePage5State();
}

class _AdministrationCreatePage5State extends State<AdministrationCreatePage5> {
  User user = AuthProvider.currentUser!;
  final ImagePicker _picker = ImagePicker();
  CroppedFile? croppedImageKTP;
  CroppedFile? croppedImageKK;
  final _TECCreatorDieDateTime = TextEditingController();
  final _TECCreatorDieAge = TextEditingController();
  final _TECCreatorDieReason = TextEditingController();
  final _TECCreatorNotes = TextEditingController();

  AdministrationType? admType;
  int admTypeID = -1;

  void buatPermohonanSuratPengantar() async {
    if (croppedImageKK == null || croppedImageKTP == null) {
      SmartRTSnackbar.show(context,
          message: 'Pastikan anda sudah mengunggah foto KTP dan KK!',
          backgroundColor: smartRTErrorColor);
    } else {
      try {
        if (admTypeID == 5 &&
            (_TECCreatorDieAge.text == '' ||
                _TECCreatorDieDateTime.text == '' ||
                _TECCreatorDieReason.text == '')) {
          SmartRTSnackbar.show(context,
              message: 'Pastikan anda sudah mengisi semua field',
              backgroundColor: smartRTErrorColor);
        } else if (admTypeID == 8 && (_TECCreatorNotes.text == '')) {
          SmartRTSnackbar.show(context,
              message: 'Pastikan anda sudah mengisi semua field',
              backgroundColor: smartRTErrorColor);
        } else {
          MultipartFile multipartKTP = await MultipartFile.fromFile(
              croppedImageKTP!.path,
              filename: croppedImageKTP!.path.split('/').last,
              contentType: MediaType('image',
                  croppedImageKTP!.path.split('/').last.split('.').last));

          MultipartFile multipartKK = await MultipartFile.fromFile(
              croppedImageKK!.path,
              filename: croppedImageKK!.path.split('/').last,
              contentType: MediaType('image',
                  croppedImageKK!.path.split('/').last.split('.').last));
          var formData = FormData.fromMap({});
          if (admTypeID == 5) {
            formData = FormData.fromMap({
              "administration_type_id": widget.args.admType.id,
              "creator_fullname": widget.args.creatorFullname,
              "creator_address": widget.args.creatorAddress,
              "creator_ktp_num": widget.args.creatorNoKTP,
              "creator_kk_num": widget.args.creatorNoKK,
              "creator_born_place": widget.args.creatorBornPlace,
              "creator_born_date": widget.args.creatorBornDate,
              "creator_gender": widget.args.creatorGender,
              "creator_religion": widget.args.creatorReligion,
              "creator_wedding_status": widget.args.creatorWeddingStatus,
              "creator_job": widget.args.creatorJob,
              "creator_nationality": widget.args.creatorNationality,
              "creator_ktp_img": multipartKTP,
              "creator_kk_img": multipartKK,
              "creator_additional_datetime": _TECCreatorDieDateTime.text,
              "creator_age": _TECCreatorDieAge.text,
              "creator_notes": _TECCreatorDieReason.text
            });
          } else if (admTypeID == 8) {
            formData = FormData.fromMap({
              "administration_type_id": widget.args.admType.id,
              "creator_fullname": widget.args.creatorFullname,
              "creator_address": widget.args.creatorAddress,
              "creator_ktp_num": widget.args.creatorNoKTP,
              "creator_kk_num": widget.args.creatorNoKK,
              "creator_born_place": widget.args.creatorBornPlace,
              "creator_born_date": widget.args.creatorBornDate,
              "creator_gender": widget.args.creatorGender,
              "creator_religion": widget.args.creatorReligion,
              "creator_wedding_status": widget.args.creatorWeddingStatus,
              "creator_job": widget.args.creatorJob,
              "creator_nationality": widget.args.creatorNationality,
              "creator_ktp_img": multipartKTP,
              "creator_kk_img": multipartKK,
              "creator_notes": _TECCreatorNotes.text,
            });
          } else {
            formData = FormData.fromMap({
              "administration_type_id": widget.args.admType.id,
              "creator_fullname": widget.args.creatorFullname,
              "creator_address": widget.args.creatorAddress,
              "creator_ktp_num": widget.args.creatorNoKTP,
              "creator_kk_num": widget.args.creatorNoKK,
              "creator_born_place": widget.args.creatorBornPlace,
              "creator_born_date": widget.args.creatorBornDate,
              "creator_gender": widget.args.creatorGender,
              "creator_religion": widget.args.creatorReligion,
              "creator_wedding_status": widget.args.creatorWeddingStatus,
              "creator_job": widget.args.creatorJob,
              "creator_nationality": widget.args.creatorNationality,
              "creator_ktp_img": multipartKTP,
              "creator_kk_img": multipartKK,
            });
          }

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
        }
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

  void _pickImage(String type) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (type == 'KTP') {
        croppedImageKTP = await ImageCropper().cropImage(
            sourcePath: image.path,
            aspectRatioPresets: [CropAspectRatioPreset.ratio16x9]);
      } else {
        croppedImageKK = await ImageCropper().cropImage(
            sourcePath: image.path,
            aspectRatioPresets: [CropAspectRatioPreset.ratio4x3]);
      }
      setState(() {});
    }
  }

  void getData() async {
    admType = widget.args.admType;
    admTypeID = admType!.id;

    if (admTypeID == 8) {
      _TECCreatorNotes.text =
          'Membenarkan bahwa orang tersebut merupakan warga RT${StringFormat.numFormatRTRW(user.rt_num.toString())}/RW${StringFormat.numFormatRTRW(user.rw_num.toString())} Kel. ${user.data_urban_village!.name.substring(10)}, Kec. ${user.data_sub_district!.name} dan berkelakuan baik di masyarakat. Surat keterangan ini dibuat sebagai kelengkapan pengurusan ...';
    }
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
        title: const Text('Buat Surat Pengantar [ 4 / 4 ]'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: paddingScreen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (admTypeID == 5)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const ExplainPart(
                      title: 'DETAIL MENINGGAL',
                      notes:
                          'Pastikan anda mengisi data meninggal dengan data yang sesuai dengan kenyataan dan valid.',
                    ),
                    SB_height30,
                    DateTimePicker(
                      type: DateTimePickerType.dateTime,
                      dateMask: 'dd MMMM yyyy HH:mm',
                      locale: const Locale('id', 'ID'),
                      style: smartRTTextNormal_Primary,
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                      dateLabelText: 'Tanggal dan Waktu Meninggal',
                      onChanged: (val) => print(val),
                      onSaved: (val) => print(val),
                      controller: _TECCreatorDieDateTime,
                    ),
                    SB_height15,
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _TECCreatorDieAge,
                      autocorrect: false,
                      style: smartRTTextNormal_Primary,
                      decoration: const InputDecoration(
                        labelText: 'Usia Meninggal',
                      ),
                    ),
                    SB_height15,
                    TextFormField(
                      controller: _TECCreatorDieReason,
                      autocorrect: false,
                      style: smartRTTextNormal_Primary,
                      decoration: const InputDecoration(
                        labelText: 'Penyebab',
                      ),
                    ),
                    const Divider(
                      height: 50,
                      thickness: 5,
                    ),
                  ],
                ),
              if (admTypeID == 8)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const ExplainPart(
                      title: 'KEPERLUAN',
                      notes:
                          'Pastikan anda mengisi keperluan dengan baik dan benar sesuai dengan kebutuhan! Gunakan bahasa yang sopan!.',
                    ),
                    SB_height30,
                    TextFormField(
                      controller: _TECCreatorNotes,
                      maxLines: 10,
                      autocorrect: false,
                      style: smartRTTextNormal_Primary,
                      decoration:
                          const InputDecoration(hintText: 'Tuliskan disini...'),
                    ),
                    const Divider(
                      height: 50,
                      thickness: 5,
                    ),
                  ],
                ),
              const ExplainPart(
                  title: 'LAMPIRAN',
                  notes:
                      'Pastikan anda mengunggah foto KTP dan KK yang valid dalam bentuk .jpg , .jpeg, atau .png untuk membantu proses konfirmasi! \n\nJika anda belum mempunyai KTP, anda dapat mengunggah foto kosong!'),
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
              SB_height30,
              Text(
                'Foto KK',
                style: smartRTTextTitleCard_Primary,
              ),
              SB_height15,
              AspectRatio(
                aspectRatio: 3 / 4,
                child: croppedImageKK == null
                    ? GestureDetector(
                        onTap: () {
                          _pickImage('KK');
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
                          Image.file(File(croppedImageKK!.path)),
                          Positioned(
                              bottom: 1,
                              right: 1,
                              child: GestureDetector(
                                onTap: () {
                                  _pickImage('KK');
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
