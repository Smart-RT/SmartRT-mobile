import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/news/news.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/screens/public_screens/home/public_home.dart';
import 'package:smart_rt/screens/public_screens/image_view/image_view_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';

class PengumumanDetailPageArgument {
  News dataPengumuman;

  PengumumanDetailPageArgument({
    required this.dataPengumuman,
  });
}

class PengumumanDetailPage extends StatefulWidget {
  static const String id = 'PengumumanDetailPage';
  PengumumanDetailPageArgument args;
  PengumumanDetailPage({Key? key, required this.args}) : super(key: key);

  @override
  State<PengumumanDetailPage> createState() => _PengumumanDetailPageState();
}

class _PengumumanDetailPageState extends State<PengumumanDetailPage> {
  News? dataPengumuman;
  User user = AuthProvider.currentUser!;
  String txtTitle = '';
  String txtDetail = '';
  String txtImgDirectory = '';
  String createdBy = '';
  String createdAt = '';

  void hapusPengumuman() async {
    Response<dynamic> resp = await NetUtil()
        .dioClient
        .patch('/news/delete/id-news/${dataPengumuman!.id}');

    if (resp.statusCode.toString() == '200') {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, PublicHome.id);
      SmartRTSnackbar.show(context,
          message: resp.data, backgroundColor: smartRTSuccessColor);
    } else {
      SmartRTSnackbar.show(context,
          message: resp.data, backgroundColor: smartRTErrorColor);
    }
  }

  void showConfirmation() async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Hai Sobat Pintar,',
          style: smartRTTextTitleCard,
        ),
        content: Text(
          'Apakah anda yakin menghapus pengumuman ini?\n\n*Setelah anda hapus, anda tidak dapat memulihkannya kembali.',
          style: smartRTTextNormal.copyWith(fontWeight: FontWeight.normal),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'Batal'),
                child: Text(
                  'Batal',
                  style:
                      smartRTTextNormal.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {
                  hapusPengumuman();
                },
                child: Text(
                  'HAPUS SEKARANG',
                  style: smartRTTextNormal.copyWith(
                      fontWeight: FontWeight.bold,
                      color: smartRTStatusRedColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void getData() async {
    dataPengumuman = widget.args.dataPengumuman;
    txtTitle = dataPengumuman!.title;
    txtDetail = dataPengumuman!.detail;

    if (dataPengumuman!.file_img != null && dataPengumuman!.file_img != '') {
      txtImgDirectory =
          '$backendURL/public/uploads/pengumuman/file_lampiran/${dataPengumuman!.id}/${dataPengumuman!.file_img}';
    }

    createdBy = dataPengumuman!.created_by!.full_name;
    createdAt =
        DateFormat('d MMMM y', 'id_ID').format(dataPengumuman!.created_at);

    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pengumuman'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: paddingScreen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                txtTitle,
                style: smartRTTextTitle,
                textAlign: TextAlign.center,
              ),
              SB_height15,
              AspectRatio(
                aspectRatio: 1 / 1,
                child: txtImgDirectory == ''
                    ? const FittedBox(
                        child: Icon(
                          Icons.image_outlined,
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, ImageViewPage.id,
                              arguments: ImageViewPageArgument(
                                  imgLocation: txtImgDirectory));
                        },
                        child: Image.network(
                          txtImgDirectory,
                          fit: BoxFit.fill,
                        ),
                      ),
              ),
              SB_height15,
              Text(
                txtDetail,
                style: smartRTTextLarge,
                textAlign: TextAlign.justify,
              ),
              SB_height15,
              Text(
                'Dibuat oleh:\n$createdBy\n$createdAt',
                style: smartRTTextLarge,
                textAlign: TextAlign.right,
              ),
              SB_height30,
              if (user.user_role == Role.Ketua_RT ||
                  user.user_role == Role.Wakil_RT ||
                  user.user_role == Role.Sekretaris)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ))),
                    onPressed: () async {
                      showConfirmation();
                    },
                    child: Text(
                      'HAPUS',
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
