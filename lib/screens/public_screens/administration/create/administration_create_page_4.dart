import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/administration/administration_type.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/screens/public_screens/administration/create/administration_create_page_5.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/parts/explain_part.dart';
import 'package:smart_rt/providers/auth_provider.dart';

class AdministrationCreatePage4Argument {
  AdministrationType admType;
  String creatorFullname;
  String creatorAddress;
  String creatorNoKTP;
  String creatorNoKK;
  String creatorBornPlace;
  String creatorBornDate;
  AdministrationCreatePage4Argument({
    required this.admType,
    required this.creatorFullname,
    required this.creatorAddress,
    required this.creatorNoKTP,
    required this.creatorNoKK,
    required this.creatorBornPlace,
    required this.creatorBornDate,
  });
}

class AdministrationCreatePage4 extends StatefulWidget {
  static const String id = 'AdministrationCreatePage4';
  AdministrationCreatePage4Argument args;
  AdministrationCreatePage4({Key? key, required this.args}) : super(key: key);

  @override
  State<AdministrationCreatePage4> createState() =>
      _AdministrationCreatePage4State();
}

class _AdministrationCreatePage4State extends State<AdministrationCreatePage4> {
  User user = AuthProvider.currentUser!;
  String _TECCreatorGender = '';
  String _TECCreatorReligion = '';
  String _TECCreatorWeddingStatus = '';
  String _TECCreatorNationality = '';
  String _TECCreatorJob = '';
  // final _TECCreatorJob = TextEditingController();
  int idxNationality = 0;
  int idxGender = 0;
  int idxReligion = 0;
  int idxWeddingStatus = 0;
  int idxJob = 0;
  AdministrationType? admType;
  String titleExplain = '';
  String detailExplain = '';
  final List<String> nationalityItems = [
    'WNI',
    'WNA',
  ];
  final List<String> genderItems = [
    'Laki-Laki',
    'Perempuan',
  ];
  final List<String> religionItems = [
    'Islam',
    'Kristen',
    'Katolik',
    'Hindu',
    'Budha',
    'Kong Hu Cu',
  ];
  final List<String> weddingStatusItems = [
    'Belum Kawin',
    'Kawin',
    'Cerai Hidup',
    'Cerai Mati',
  ];
  final List<String> jobItems = [
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

  void selanjutnya() async {
    if (cekData()) {
      AdministrationCreatePage5Argument args =
          AdministrationCreatePage5Argument(
        admType: widget.args.admType,
        creatorFullname: widget.args.creatorFullname,
        creatorAddress: widget.args.creatorAddress,
        creatorNoKTP: widget.args.creatorNoKTP,
        creatorNoKK: widget.args.creatorNoKK,
        creatorBornPlace: widget.args.creatorBornPlace,
        creatorBornDate: widget.args.creatorBornDate,
        creatorGender: _TECCreatorGender,
        creatorReligion: _TECCreatorReligion,
        creatorWeddingStatus: _TECCreatorWeddingStatus,
        creatorJob: _TECCreatorJob,
        creatorNationality: _TECCreatorNationality,
      );
      Navigator.pushNamed(context, AdministrationCreatePage5.id,
          arguments: args);
    }
  }

  bool cekData() {
    if (_TECCreatorJob.isEmpty) {
      SmartRTSnackbar.show(context,
          message: 'Pastikan semua data terisi !',
          backgroundColor: smartRTErrorColor);
      return false;
    }
    return true;
  }

  void getData() async {
    admType = widget.args.admType;
    if (admType!.id == 5) {
      titleExplain = 'DATA ORANG YANG MENINGGAL (3)';
      detailExplain =
          'Isilah semua form dibawah ini! Pastikan data orang yang meninggal sesuai dengan KTP atau KK !';
      _TECCreatorGender = genderItems[0];
      _TECCreatorNationality = nationalityItems[0];
      _TECCreatorReligion = religionItems[0];
      _TECCreatorWeddingStatus = weddingStatusItems[0];
    } else {
      titleExplain = 'DATA DIRI (3)';
      detailExplain =
          'Isilah semua form dibawah ini! Pastikan data diri anda sesuai dengan KTP atau KK !';
      _TECCreatorGender = user.gender;
      _TECCreatorNationality = user.nationality ?? nationalityItems[0];
      _TECCreatorReligion = user.religion ?? religionItems[0];
      _TECCreatorWeddingStatus =
          user.status_perkawinan ?? weddingStatusItems[0];
      _TECCreatorJob = user.profession ?? jobItems[0];
      if (genderItems.contains(_TECCreatorGender)) {
        idxGender = genderItems.indexOf(_TECCreatorGender);
      }
      if (religionItems.contains(_TECCreatorReligion)) {
        idxReligion = religionItems.indexOf(_TECCreatorReligion);
      }
      if (weddingStatusItems.contains(_TECCreatorWeddingStatus)) {
        idxWeddingStatus = weddingStatusItems.indexOf(_TECCreatorWeddingStatus);
      }
      if (nationalityItems.contains(_TECCreatorNationality)) {
        idxNationality = nationalityItems.indexOf(_TECCreatorNationality);
      }
      if (jobItems.contains(_TECCreatorJob)) {
        idxJob = jobItems.indexOf(_TECCreatorJob);
      }
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
        title: Text('Buat Surat Pengantar [ 3 / 4 ]'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: paddingScreen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ExplainPart(title: titleExplain, notes: detailExplain),
              SB_height30,
              Text(
                'Kewarganegaraan',
                style: smartRTTextNormal.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SB_height5,
              DropdownButtonFormField2(
                value: nationalityItems[idxNationality],
                style: smartRTTextNormal.copyWith(fontWeight: FontWeight.bold),
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
                buttonPadding: const EdgeInsets.only(left: 10, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                items: nationalityItems
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: smartRTTextNormal_Primary,
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _TECCreatorNationality = value.toString();
                  });
                },
                onSaved: (value) {
                  _TECCreatorNationality = value.toString();
                },
              ),
              SB_height15,
              Text(
                'Jenis Kelamin',
                style: smartRTTextNormal.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SB_height5,
              DropdownButtonFormField2(
                value: genderItems[idxGender],
                style: smartRTTextNormal.copyWith(fontWeight: FontWeight.bold),
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
                buttonPadding: const EdgeInsets.only(left: 10, right: 10),
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
                onChanged: (value) {
                  setState(() {
                    _TECCreatorGender = value.toString();
                  });
                },
                onSaved: (value) {
                  _TECCreatorGender = value.toString();
                },
              ),
              SB_height15,
              Text(
                'Agama',
                style: smartRTTextNormal.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SB_height5,
              DropdownButtonFormField2(
                value: religionItems[idxReligion],
                style: smartRTTextNormal.copyWith(fontWeight: FontWeight.bold),
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
                buttonPadding: const EdgeInsets.only(left: 10, right: 10),
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
                onChanged: (value) {
                  setState(() {
                    _TECCreatorReligion = value.toString();
                  });
                },
                onSaved: (value) {
                  _TECCreatorReligion = value.toString();
                },
              ),
              SB_height15,
              Text(
                'Status Perkawinan',
                style: smartRTTextNormal.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SB_height5,
              DropdownButtonFormField2(
                value: weddingStatusItems[idxWeddingStatus],
                style: smartRTTextNormal.copyWith(fontWeight: FontWeight.bold),
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
                buttonPadding: const EdgeInsets.only(left: 10, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                items: weddingStatusItems
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: smartRTTextNormal_Primary,
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _TECCreatorWeddingStatus = value.toString();
                  });
                },
                onSaved: (value) {
                  _TECCreatorWeddingStatus = value.toString();
                },
              ),
              SB_height30,
              DropdownButtonFormField2(
                value: jobItems[idxJob],
                style: smartRTTextNormal.copyWith(fontWeight: FontWeight.bold),
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
                buttonPadding: const EdgeInsets.only(left: 10, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                items: jobItems
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: smartRTTextNormal_Primary,
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _TECCreatorJob = value.toString();
                  });
                },
                onSaved: (value) {
                  _TECCreatorJob = value.toString();
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
