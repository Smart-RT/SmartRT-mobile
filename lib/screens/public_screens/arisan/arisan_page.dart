import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/screens/public_screens/arisan/detail_dan_informasi_arisan_page.dart';
import 'package:smart_rt/screens/public_screens/janji_temu/buat_janji_temu_page.dart';
import 'package:smart_rt/widgets/cards/card_with_time_location.dart';

class ArisanPage extends StatefulWidget {
  static const String id = 'ArisanPage';
  const ArisanPage({Key? key}) : super(key: key);

  @override
  State<ArisanPage> createState() => _ArisanPageState();
}

class _ArisanPageState extends State<ArisanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Arisan'),
      ),
      body: Column(
        children: [
          Container(
            color: smartRTPrimaryColor,
            width: double.infinity,
            height: 125,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: paddingScreen,
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'TANGGAL PERTEMUAN SELANJUTNYA',
                    style: smartRTTextLargeBold_Success,
                  ),
                  Text(
                    '1 Januari 2023',
                    style: smartRTTextTitle_Success,
                  )
                ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 500,
            child: ListView(
              children: <Widget>[
                Card(
                  color: smartRTSecondaryColor,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, DetailDanInformasiArisanPage.id);
                    },
                    child: ListTile(
                      title: Text(
                        'Detail dan Informasi',
                        style: smartRTTextLargeBold_Primary,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: smartRTPrimaryColor,
                      ),
                    ),
                  ),
                ),
                
                Card(
                  color: smartRTSecondaryColor,
                  child: ListTile(
                    title: Text(
                      'Riwayat dan Keuangan Arisanku',
                      style: smartRTTextLargeBold_Primary,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: smartRTPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
