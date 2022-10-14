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
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class UbahProfilPage extends StatefulWidget {
  static const String id = 'UbahProfilPage';
  const UbahProfilPage({Key? key}) : super(key: key);

  @override
  State<UbahProfilPage> createState() => _UbahProfilPageState();
}

class _UbahProfilPageState extends State<UbahProfilPage> {
  final ImagePicker _picker = ImagePicker();

  final int? _IDUser = AuthProvider.currentUser!.id;
  String? _profilePictureUser = AuthProvider.currentUser!.photo_profile_img;
  String _fullNameUser = AuthProvider.currentUser!.full_name;
  String _genderUser = AuthProvider.currentUser!.gender;
  String _bornDateUser =
      DateFormat.yMMMd().format(AuthProvider.currentUser!.born_date);
  String _addressUser = AuthProvider.currentUser!.address ?? '-';
  final String _phoneUser = AuthProvider.currentUser!.phone;

  final List<String> genderItems = [
    'Laki-Laki',
    'Perempuan',
  ];

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
    exportPenColor: Colors.black,
    onDrawStart: () => print('onDrawStart called!'),
    onDrawEnd: () => print('onDrawEnd called!'),
  );

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Ubah Profil'),
      ),
      body: Column(
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
                                      '${backendURL}/public/uploads/users/${_IDUser}/${_profilePictureUser}'),
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
                        onTap: () => showDialog<String>(
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
                                initialValue: _fullNameUser,
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
                                    onPressed: () =>
                                        Navigator.pop(context, 'Selesai'),
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
                                value: _genderUser,
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
                                buttonPadding:
                                    const EdgeInsets.only(left: 25, right: 10),
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
                                    _genderUser = value.toString();
                                  });
                                },
                                onSaved: (value) {
                                  _genderUser = value.toString();
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
                                    onPressed: () =>
                                        Navigator.pop(context, 'Selesai'),
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
                        onTap: () => showDialog<String>(
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
                                type: DateTimePickerType.date,
                                dateMask: 'yyyy/MM/dd',
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
                                    onPressed: () =>
                                        Navigator.pop(context, 'Selesai'),
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
                                  'Tanggal Lahir',
                                  style: smartRTTextLarge_Primary.copyWith(
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  _bornDateUser,
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
                    // Card(
                    //   color: smartRTSecondaryColor,
                    //   child: ListTile(
                    //     title: Row(
                    //       children: [
                    //         Expanded(
                    //           child: Text(
                    //             'Kata Sandi',
                    //             style: smartRTTextLarge_Primary.copyWith(
                    //                 fontWeight: FontWeight.normal),
                    //           ),
                    //         ),
                    //         Expanded(
                    //           child: Text(
                    //             '[Kata Sandi]',
                    //             style: smartRTTextLarge_Primary.copyWith(
                    //                 fontWeight: FontWeight.normal),
                    //             textAlign: TextAlign.right,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //     trailing: Icon(
                    //       Icons.arrow_forward_ios,
                    //       color: smartRTPrimaryColor,
                    //       size: 15,
                    //     ),
                    //   ),
                    // ),
                    Card(
                      color: smartRTSecondaryColor,
                      child: GestureDetector(
                        onTap: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            backgroundColor: smartRTSecondaryColor,
                            title: Text(
                              'Tanda Tangan',
                              style: smartRTTextTitleCard_Primary,
                            ),
                            content: Text(
                              'Tanda tangan akan digunakan ketika mengurus dokumen yang membutuhkan tanda tangan anda.',
                              style: smartRTTextNormal_Primary.copyWith(
                                  fontWeight: FontWeight.normal),
                            ),
                            actions: <Widget>[
                              Signature(
                                controller: _controller,
                                height: 150,
                                backgroundColor: Colors.white,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Hapus'),
                                        child: Row(
                                          children: [
                                            Icon(Icons.restart_alt_rounded,
                                                size: 15,
                                                color: smartRTPrimaryColor),
                                            Text(
                                              'Hapus',
                                              style: smartRTTextLarge_Primary,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SB_width15,
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Batal'),
                                        child: Text(
                                          'Batal',
                                          style: smartRTTextLarge_Primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Simpan'),
                                    child: Text(
                                      'Simpan',
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
                                  'Tanda Tangan',
                                  style: smartRTTextLarge_Primary.copyWith(
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '',
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
                  ],
                ),
              ),
              // TextFormField(
              //   autocorrect: false,
              //   style: smartRTTextNormal_Primary,
              //   decoration: const InputDecoration(
              //     labelText: 'Nama Lengkap',
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Nama Lengkap tidak boleh kosong';
              //     }
              //   },
              // ),
              // SB_height15,
              // TextFormField(
              //   autocorrect: false,
              //   style: smartRTTextNormal_Primary,
              //   decoration: const InputDecoration(
              //     labelText: 'Nomor Telepon',
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Nomor Telepon tidak boleh kosong';
              //     }
              //   },
              // ),
              // SB_height15,
              // TextFormField(
              //   autocorrect: false,
              //   style: smartRTTextNormal_Primary,
              //   decoration: const InputDecoration(
              //     labelText: 'Alamat Rumah',
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Nomor Telepon tidak boleh kosong';
              //     }
              //   },
              // ),
            ],
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              onPressed: () {
                /**.... */
              },
              child: Text(
                'SIMPAN',
                style: smartRTTextLargeBold_Secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
