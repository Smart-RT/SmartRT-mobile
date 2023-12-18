import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
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
  final TextEditingController _bornPlaceUserController =
      TextEditingController();
  final TextEditingController _addressUserController = TextEditingController();
  late String _genderUserSelected;
  late String _religionUserSelected;
  late String _statusMarriageUserSelected;
  late String _pekerjaanUserSelected;
  late String _kewarganegaraanUserSelected;

  final ImagePicker _picker = ImagePicker();

  late int? _IDUser;
  late String? _profilePictureUser;
  late String _fullNameUser;
  late String _genderUser;
  late String _religionUser;
  late String _bornDateUser;
  late String _addressUser;
  late String _phoneUser;
  late String _bornPlaceUser;
  late String _statusMarriageUser;
  late String _pekerjaanUser;
  late String _kewarganegaraanUser;

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
    _bornPlaceUser = u.born_at ?? '-';
    _religionUser = u.religion ?? '-';
    _statusMarriageUser = u.status_perkawinan ?? '-';
    _pekerjaanUser = u.profession ?? 'Belum/ Tidak Bekerja';
    _kewarganegaraanUser = u.nationality ?? '-';

    _genderUserSelected = u.gender;
    _religionUserSelected = u.religion ?? 'Kristen';
    _statusMarriageUserSelected = u.status_perkawinan ?? 'Belum Kawin';
    _pekerjaanUserSelected = u.profession ?? 'Belum/ Tidak Bekerja';
    _kewarganegaraanUserSelected = u.nationality ?? 'WNI';

    _bornDateUserController.text = u.born_date.toString();
  }

  final List<String> genderItems = [
    'Laki-Laki',
    'Perempuan',
  ];

  final List<String> religionItems = [
    'Kristen',
    'Katolik',
    'Islam',
    'Buddha',
    'Hindu',
    'Kong Hu Cu',
  ];

  final List<String> statusMarriageItems = [
    'Belum Kawin',
    'Kawin',
    'Cerai Hidup',
    'Cerai Mati',
  ];

  final List<String> kewarganegaraanItems = [
    'WNI',
    'WNA',
  ];

  final List<String> pekerjaanItems = [
    'Belum/ Tidak Bekerja',
    'Mengurus Rumah Tangga',
    'Pelajar/ Mahasiswa',
    'Pensiunan',
    'Pewagai Negeri Sipil',
    'Tentara Nasional Indonesia',
    'Kepolisisan RI',
    'Perdagangan',
    'Petani/ Pekebun',
    'Peternak',
    'Nelayan/ Perikanan',
    'Industri',
    'Konstruksi',
    'Transportasi',
    'Karyawan Swasta',
    'Karyawan BUMN',
    'Karyawan BUMD',
    'Karyawan Honorer',
    'Buruh Harian Lepas',
    'Buruh Tani/ Perkebunan',
    'Buruh Nelayan/ Perikanan',
    'Buruh Peternakan',
    'Pembantu Rumah Tangga',
    'Tukang Cukur',
    'Tukang Listrik',
    'Tukang Batu',
    'Tukang Kayu',
    'Tukang Sol Sepatu',
    'Tukang Las/ Pandai Besi',
    'Tukang Jahit',
    'Tukang Gigi',
    'Penata Rias',
    'Penata Busana',
    'Penata Rambut',
    'Mekanik',
    'Seniman',
    'Tabib',
    'Paraji',
    'Perancang Busana',
    'Penterjemah',
    'Imam Masjid',
    'Pendeta',
    'Pastor',
    'Wartawan',
    'Ustadz/ Mubaligh',
    'Juru Masak',
    'Promotor Acara',
    'Anggota DPR-RI',
    'Anggota DPD',
    'Anggota BPK',
    'Presiden',
    'Wakil Presiden',
    'Anggota Mahkamah Konstitusi',
    'Anggota Kabinet/ Kementerian',
    'Duta Besar',
    'Gubernur',
    'Wakil Gubernur',
    'Bupati',
    'Wakil Bupati',
    'Walikota',
    'Wakil Walikota',
    'Anggota DPRD Provinsi',
    'Anggota DPRD Kabupaten/ Kota',
    'Dosen',
    'Guru',
    'Pilot',
    'Pengacara',
    'Notaris',
    'Arsitek',
    'Akuntan',
    'Konsultan',
    'Dokter',
    'Bidan',
    'Perawat',
    'Apoteker',
    'Psikiater/ Psikolog',
    'Penyiar Televisi',
    'Penyiar Radio',
    'Pelaut',
    'Peneliti',
    'Sopir',
    'Pialang',
    'Paranormal',
    'Pedagang',
    'Perangkat Desa',
    'Kepala Desa',
    'Biarawati',
    'Wiraswasta',
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
                      GestureDetector(
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
                                    return null;
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
                                        if (_fullNameUserController
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
                      ListTile(
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
                          trailing: SizedBox()),
                      Divider(
                        height: 25,
                        thickness: 2,
                        color: smartRTPrimaryColor,
                      ),
                      Text(
                        'ALAMAT RUMAH',
                        style: smartRTTextTitleCard,
                        textAlign: TextAlign.center,
                      ),
                      GestureDetector(
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
                                    return null;
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
                                        if (_addressUserController
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
                      ListTile(
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Kecamatan',
                                  style: smartRTTextLarge_Primary.copyWith(
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  user.data_sub_district == null
                                      ? '-'
                                      : user.data_sub_district!.name,
                                  style: smartRTTextLarge_Primary.copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: smartRTDisabledColor),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                          trailing: SizedBox()),
                      ListTile(
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Kelurahan',
                                  style: smartRTTextLarge_Primary.copyWith(
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  user.data_urban_village == null
                                      ? '-'
                                      : user.data_urban_village!.name
                                          .substring(10),
                                  style: smartRTTextLarge_Primary.copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: smartRTDisabledColor),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                          trailing: SizedBox()),
                      ListTile(
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'RT/RW',
                                  style: smartRTTextLarge_Primary.copyWith(
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  user.rt_num == null || user.rw_num == null
                                      ? '-'
                                      : '${StringFormat.numFormatRTRW(user.rt_num.toString())} / ${StringFormat.numFormatRTRW(user.rw_num.toString())}',
                                  style: smartRTTextLarge_Primary.copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: smartRTDisabledColor),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                          trailing: SizedBox()),
                      Divider(
                        height: 25,
                        thickness: 2,
                        color: smartRTPrimaryColor,
                      ),
                      Text(
                        'TEMPAT DAN TANGGAL LAHIR',
                        style: smartRTTextTitleCard,
                        textAlign: TextAlign.center,
                      ),
                      GestureDetector(
                        onTap: () {
                          _bornPlaceUserController.text = _bornPlaceUser;
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              backgroundColor: smartRTSecondaryColor,
                              title: Text(
                                'Tempat Lahir',
                                style: smartRTTextTitleCard_Primary,
                              ),
                              content: Text(
                                'Pastikan tempat lahir anda sesuai dengan KTP demi mempermudah pengurusan data administrasi dan sebagainya.',
                                style: smartRTTextNormal_Primary.copyWith(
                                    fontWeight: FontWeight.normal),
                              ),
                              actions: <Widget>[
                                TextFormField(
                                  controller: _bornPlaceUserController,
                                  autocorrect: false,
                                  style: smartRTTextNormal_Primary,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Tempat Lahir tidak boleh kosong';
                                    }
                                    return null;
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
                                            _bornPlaceUserController.text);
                                        if (_bornPlaceUserController
                                            .text.isEmpty) {
                                          SmartRTSnackbar.show(context,
                                              message:
                                                  'Tempat Lahir tidak boleh kosong',
                                              backgroundColor:
                                                  smartRTErrorColor);
                                        } else {
                                          setState(() {
                                            _bornPlaceUser =
                                                _bornPlaceUserController.text;
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
                                  'Tempat Lahir',
                                  style: smartRTTextLarge_Primary.copyWith(
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  _bornPlaceUser,
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
                      GestureDetector(
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
                                  locale: const Locale('id', 'ID'),
                                  dateMask: 'MMM dd, yyyy',
                                  style: smartRTTextNormal_Primary,
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                  onChanged: (val) => print(val),
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return "Tanggal Lahir tidak boleh kosong";
                                    }
                                    return null;
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
                                  DateFormat('y MMMM d', 'id_ID').format(
                                      DateTime.parse(
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
                      Divider(
                        height: 25,
                        thickness: 2,
                        color: smartRTPrimaryColor,
                      ),
                      Text(
                        'LAINNYA',
                        style: smartRTTextTitleCard,
                        textAlign: TextAlign.center,
                      ),
                      GestureDetector(
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
                                  return null;
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
                      GestureDetector(
                        onTap: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            backgroundColor: smartRTSecondaryColor,
                            title: Text(
                              'Kewarganegaraan',
                              style: smartRTTextTitleCard_Primary,
                            ),
                            content: Text(
                              'Pastikan Kewarganegaraan anda sesuai dengan KTP demi mempermudah pengurusan data administrasi dan sebagainya.',
                              style: smartRTTextNormal_Primary.copyWith(
                                  fontWeight: FontWeight.normal),
                            ),
                            actions: <Widget>[
                              DropdownButtonFormField2(
                                dropdownMaxHeight: 200,
                                value: _kewarganegaraanUserSelected,
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
                                  'Kewarganegaraan',
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
                                items: kewarganegaraanItems
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
                                    return 'Kewarganegaraan tidak boleh kosong';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _kewarganegaraanUserSelected =
                                        value.toString();
                                  });
                                },
                                onSaved: (value) {
                                  _kewarganegaraanUserSelected =
                                      value.toString();
                                },
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _kewarganegaraanUserSelected =
                                            user.nationality ?? 'WNI';
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
                                        _kewarganegaraanUser =
                                            _kewarganegaraanUserSelected;
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
                                  'Kewarganegaraan',
                                  style: smartRTTextLarge_Primary.copyWith(
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  _kewarganegaraanUser,
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
                      GestureDetector(
                        onTap: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            backgroundColor: smartRTSecondaryColor,
                            title: Text(
                              'Agama',
                              style: smartRTTextTitleCard_Primary,
                            ),
                            content: Text(
                              'Pastikan agama anda sesuai dengan KTP demi mempermudah pengurusan data administrasi dan sebagainya.',
                              style: smartRTTextNormal_Primary.copyWith(
                                  fontWeight: FontWeight.normal),
                            ),
                            actions: <Widget>[
                              DropdownButtonFormField2(
                                value: _religionUserSelected,
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
                                  'Agama',
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
                                items: religionItems
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
                                    return 'Agama tidak boleh kosong';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _religionUserSelected = value.toString();
                                  });
                                },
                                onSaved: (value) {
                                  _religionUserSelected = value.toString();
                                },
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _religionUserSelected =
                                            user.religion ?? 'Kristen';
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
                                        _religionUser = _religionUserSelected;
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
                                  'Agama',
                                  style: smartRTTextLarge_Primary.copyWith(
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  _religionUser,
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
                      GestureDetector(
                        onTap: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            backgroundColor: smartRTSecondaryColor,
                            title: Text(
                              'Status Perkawinan',
                              style: smartRTTextTitleCard_Primary,
                            ),
                            content: Text(
                              'Pastikan status perkawinan anda sesuai dengan KTP demi mempermudah pengurusan data administrasi dan sebagainya.',
                              style: smartRTTextNormal_Primary.copyWith(
                                  fontWeight: FontWeight.normal),
                            ),
                            actions: <Widget>[
                              DropdownButtonFormField2(
                                value: _statusMarriageUserSelected,
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
                                  'Status Perkawinan',
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
                                items: statusMarriageItems
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
                                    return 'Status Perkawinan tidak boleh kosong';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _statusMarriageUserSelected =
                                        value.toString();
                                  });
                                },
                                onSaved: (value) {
                                  _statusMarriageUserSelected =
                                      value.toString();
                                },
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _statusMarriageUserSelected =
                                            user.status_perkawinan ??
                                                'Belum Kawin';
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
                                        _statusMarriageUser =
                                            _statusMarriageUserSelected;
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
                                  'Status Perkawinan',
                                  style: smartRTTextLarge_Primary.copyWith(
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  _statusMarriageUser,
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
                      GestureDetector(
                        onTap: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            backgroundColor: smartRTSecondaryColor,
                            title: Text(
                              'Pekerjaan',
                              style: smartRTTextTitleCard_Primary,
                            ),
                            content: Text(
                              'Pastikan Pekerjaan anda sesuai dengan KTP demi mempermudah pengurusan data administrasi dan sebagainya.',
                              style: smartRTTextNormal_Primary.copyWith(
                                  fontWeight: FontWeight.normal),
                            ),
                            actions: <Widget>[
                              DropdownButtonFormField2(
                                dropdownMaxHeight: 200,
                                value: _pekerjaanUserSelected,
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
                                  'Pekerjaan',
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
                                items: pekerjaanItems
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
                                    return 'Pekerjaan tidak boleh kosong';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _pekerjaanUserSelected = value.toString();
                                  });
                                },
                                onSaved: (value) {
                                  _pekerjaanUserSelected = value.toString();
                                },
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        _pekerjaanUserSelected =
                                            user.profession ??
                                                'Belum/ Tidak Bekerja';
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
                                        _pekerjaanUser = _pekerjaanUserSelected;
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
                                  'Pekerjaan',
                                  style: smartRTTextLarge_Primary.copyWith(
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  _pekerjaanUser,
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
                      SizedBox(
                        height: 50,
                      )
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
                  bornPlace: _bornPlaceUser,
                  nationality: _kewarganegaraanUser,
                  religion: _religionUser,
                  status_perkawinan: _statusMarriageUser,
                  profession: _pekerjaanUser,
                  bornDate: DateTime.parse(_bornDateUserController.text),
                  gender: _genderUser,
                );
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
