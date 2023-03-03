import 'dart:typed_data';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';

class UbahProfilPage extends StatefulWidget {
  static const String id = 'UbahProfilPage';
  const UbahProfilPage({Key? key}) : super(key: key);

  @override
  State<UbahProfilPage> createState() => _UbahProfilPageState();
}

class _UbahProfilPageState extends State<UbahProfilPage> {
  final TextEditingController _fullNameUserController = TextEditingController();
  final TextEditingController _bornDateUserController = TextEditingController();
  final TextEditingController _addressUserController = TextEditingController();
  late String _genderUserSelected;

  final ImagePicker _picker = ImagePicker();

  late int? _IDUser;
  late String? _profilePictureUser;
  late String _fullNameUser;
  late String _genderUser;
  late String _bornDateUser;
  late String _addressUser;
  late String _phoneUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    User u = AuthProvider.currentUser!;

    _IDUser = u.id;
    _profilePictureUser = u.photo_profile_img;
    _fullNameUser = u.full_name;
    _genderUser = u.gender;
    _bornDateUser = u.born_date.toString();
    _addressUser = u.address ?? '-';
    _phoneUser = u.phone;

    _genderUserSelected = u.gender;

    _bornDateUserController.text = u.born_date.toString();
  }

  final List<String> genderItems = [
    'Laki-Laki',
    'Perempuan',
  ];

  void _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      CroppedFile? croppedImage = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [CropAspectRatioPreset.square]);
      if (croppedImage != null) {
        bool isSuccess = await context
            .read<AuthProvider>()
            .uploadProfilePicture(context: context, file: croppedImage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = context.watch<AuthProvider>().user;
    _profilePictureUser = user!.photo_profile_img;
    return Scaffold(
      appBar: AppBar(
        title: Text('Ubah Profil'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: paddingScreen,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        _pickImage();
                      },
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 75,
                            backgroundColor: smartRTPrimaryColor,
                            child: _profilePictureUser == null ||
                                    _profilePictureUser == ""
                                ? Icon(
                                    Icons.account_circle,
                                    size: 150,
                                    color: smartRTSecondaryColor,
                                  )
                                : CircleAvatar(
                                    radius: 70,
                                    backgroundImage: NetworkImage(
                                        '${backendURL}/public/uploads/users/${_IDUser}/profile_picture/${_profilePictureUser}'),
                                  ),
                          ),
                          Positioned(
                            bottom: 1,
                            right: 1,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Icon(Icons.edit,
                                    color: smartRTSecondaryColor),
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 3,
                                    color: smartRTPrimaryColor,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      50,
                                    ),
                                  ),
                                  color: smartRTPrimaryColor,
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(2, 4),
                                      color: smartRTShadowColor,
                                      blurRadius: 3,
                                    ),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 500,
                  child: ListView(
                    children: <Widget>[
                      Card(
                        color: smartRTSecondaryColor,
                        child: GestureDetector(
                          onTap: () {
                            _fullNameUserController.text = _fullNameUser;
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                backgroundColor: smartRTSecondaryColor,
                                title: Text(
                                  'Nama Lengkap',
                                  style: smartRTTextTitleCard_Primary,
                                ),
                                content: Text(
                                  'Pastikan nama anda sesuai dengan KTP demi mempermudah pengurusan data administrasi dan sebagainya.',
                                  style: smartRTTextNormal_Primary.copyWith(
                                      fontWeight: FontWeight.normal),
                                ),
                                actions: <Widget>[
                                  TextFormField(
                                    controller: _fullNameUserController,
                                    autocorrect: false,
                                    style: smartRTTextNormal_Primary,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Nama tidak boleh kosong';
                                      }
                                    },
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Batal'),
                                        child: Text(
                                          'Batal',
                                          style: smartRTTextLarge_Primary,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          debugPrint(
                                              _fullNameUserController.text);
                                          if (_fullNameUserController.text ==
                                                  null ||
                                              _fullNameUserController
                                                  .text.isEmpty) {
                                            SmartRTSnackbar.show(context,
                                                message:
                                                    'Nama Lengkap tidak boleh kosong',
                                                backgroundColor:
                                                    smartRTErrorColor);
                                          } else {
                                            setState(() {
                                              _fullNameUser =
                                                  _fullNameUserController.text;
                                            });
                                            Navigator.pop(context, 'Selesai');
                                          }
                                        },
                                        child: Text(
                                          'Selesai',
                                          style: smartRTTextLargeBold_Primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          child: ListTile(
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Nama Lengkap',
                                    style: smartRTTextLarge_Primary.copyWith(
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    _fullNameUser,
                                    style: smartRTTextLarge_Primary.copyWith(
                                        fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: smartRTPrimaryColor,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                      Card(
                        color: smartRTSecondaryColor,
                        child: GestureDetector(
                          onTap: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              backgroundColor: smartRTSecondaryColor,
                              title: Text(
                                'Jenis Kelamin',
                                style: smartRTTextTitleCard_Primary,
                              ),
                              content: Text(
                                'Pastikan jenis kelamin anda sesuai dengan KTP demi mempermudah pengurusan data administrasi dan sebagainya.',
                                style: smartRTTextNormal_Primary.copyWith(
                                    fontWeight: FontWeight.normal),
                              ),
                              actions: <Widget>[
                                DropdownButtonFormField2(
                                  value: _genderUserSelected,
                                  style: smartRTTextLarge_Primary,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  isExpanded: true,
                                  hint: Text(
                                    'Jenis Kelamin',
                                    style: smartRTTextLargeBold_Primary,
                                  ),
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: smartRTPrimaryColor,
                                  ),
                                  iconSize: 30,
                                  buttonHeight: 60,
                                  buttonPadding: const EdgeInsets.only(
                                      left: 25, right: 10),
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  items: genderItems
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: smartRTTextNormal_Primary,
                                            ),
                                          ))
                                      .toList(),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Jenis Kelamin tidak boleh kosong';
                                    }
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _genderUserSelected = value.toString();
                                    });
                                  },
                                  onSaved: (value) {
                                    _genderUserSelected = value.toString();
                                  },
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _genderUserSelected = _genderUser;
                                        });
                                        Navigator.pop(context, 'Batal');
                                      },
                                      child: Text(
                                        'Batal',
                                        style: smartRTTextLarge_Primary,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _genderUser = _genderUserSelected;
                                        });
                                        Navigator.pop(context, 'Selesai');
                                      },
                                      child: Text(
                                        'Selesai',
                                        style: smartRTTextLargeBold_Primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          child: ListTile(
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Jenis Kelamin',
                                    style: smartRTTextLarge_Primary.copyWith(
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    _genderUser,
                                    style: smartRTTextLarge_Primary.copyWith(
                                        fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: smartRTPrimaryColor,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                      Card(
                        color: smartRTSecondaryColor,
                        child: GestureDetector(
                          onTap: () {
                            _bornDateUserController.text =
                                _bornDateUser.toString();
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                backgroundColor: smartRTSecondaryColor,
                                title: Text(
                                  'Tanggal Lahir',
                                  style: smartRTTextTitleCard_Primary,
                                ),
                                content: Text(
                                  'Pastikan tanggal lahir anda sesuai dengan KTP demi mempermudah pengurusan data administrasi dan sebagainya.',
                                  style: smartRTTextNormal_Primary.copyWith(
                                      fontWeight: FontWeight.normal),
                                ),
                                actions: <Widget>[
                                  DateTimePicker(
                                    controller: _bornDateUserController,
                                    // initialValue: _bornDateUser,
                                    type: DateTimePickerType.date,
                                    dateMask: 'MMM dd, yyyy',
                                    style: smartRTTextNormal_Primary,
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                    onChanged: (val) => print(val),
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return "Tanggal Lahir tidak boleh kosong";
                                      }
                                    },
                                    onSaved: (val) => print(val),
                                    // controller: _tanggalLahirController,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Batal'),
                                        child: Text(
                                          'Batal',
                                          style: smartRTTextLarge_Primary,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            _bornDateUser =
                                                _bornDateUserController.text;
                                          });
                                          Navigator.pop(context, 'Selesai');
                                        },
                                        child: Text(
                                          'Selesai',
                                          style: smartRTTextLargeBold_Primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          child: ListTile(
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Tanggal Lahir',
                                    style: smartRTTextLarge_Primary.copyWith(
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    DateFormat.yMMMd().format(DateTime.parse(
                                        _bornDateUserController.text)),
                                    style: smartRTTextLarge_Primary.copyWith(
                                        fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: smartRTPrimaryColor,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                      Card(
                        color: smartRTSecondaryColor,
                        child: GestureDetector(
                          onTap: () {
                            _addressUserController.text =
                                _addressUser == '-' ? '' : _addressUser;
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                backgroundColor: smartRTSecondaryColor,
                                title: Text(
                                  'Alamat Rumah',
                                  style: smartRTTextTitleCard_Primary,
                                ),
                                content: Text(
                                  'Pastikan alamat anda sesuai dengan KTP demi mempermudah pengurusan data administrasi dan sebagainya.',
                                  style: smartRTTextNormal_Primary.copyWith(
                                      fontWeight: FontWeight.normal),
                                ),
                                actions: <Widget>[
                                  TextFormField(
                                    controller: _addressUserController,
                                    autocorrect: false,
                                    style: smartRTTextNormal_Primary,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Alamat tidak boleh kosong';
                                      }
                                    },
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Batal'),
                                        child: Text(
                                          'Batal',
                                          style: smartRTTextLarge_Primary,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          if (_addressUserController.text ==
                                                  null ||
                                              _addressUserController
                                                  .text.isEmpty) {
                                            SmartRTSnackbar.show(context,
                                                message:
                                                    'Alamat tidak boleh kosong',
                                                backgroundColor:
                                                    smartRTErrorColor);
                                          } else {
                                            setState(() {
                                              _addressUser =
                                                  _addressUserController.text;
                                            });
                                            Navigator.pop(context, 'Selesai');
                                          }
                                        },
                                        child: Text(
                                          'Selesai',
                                          style: smartRTTextLargeBold_Primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          child: ListTile(
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Alamat Rumah',
                                    style: smartRTTextLarge_Primary.copyWith(
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    _addressUser,
                                    style: smartRTTextLarge_Primary.copyWith(
                                        fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: smartRTPrimaryColor,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                      Card(
                        color: smartRTSecondaryColor,
                        child: ListTile(
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Nomor Telepon',
                                  style: smartRTTextLarge_Primary.copyWith(
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  _phoneUser,
                                  style: smartRTTextLarge_Primary.copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: smartRTDisabledColor),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: smartRTDisabledColor,
                            size: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          onPressed: () {
            context.read<AuthProvider>().updateProfile(
                context: context,
                fullName: _fullNameUser,
                address: _addressUser,
                bornDate: DateTime.parse(_bornDateUserController.text),
                gender: _genderUser);
            Navigator.pop(context);
            SmartRTSnackbar.show(context,
                message: 'Update Profile Berhasil',
                backgroundColor: smartRTSuccessColor);
          },
          child: Text(
            'SIMPAN',
            style: smartRTTextLargeBold_Secondary,
          ),
        ),
      ),
    );
  }
}
