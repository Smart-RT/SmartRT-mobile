
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';

class KeuanganPage extends StatelessWidget {
  const KeuanganPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: smartRTPrimaryColor,
          width: double.infinity,
          height: 125,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Padding(
                padding: paddingScreen,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'DOMPET SAYA',
                      style: smartRTTextLargeBold_Success,
                    ),
                    Text(
                      'IDR 0,00',
                      style: smartRTTextTitle_Success,
                    )
                  ],
                ),
              )),
              Expanded(
                  child: Padding(
                padding: paddingScreen,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'HUTANG',
                      style: smartRTTextLargeBold_Error,
                    ),
                    Text(
                      'IDR 0,00',
                      style: smartRTTextTitle_Error,
                    )
                  ],
                ),
              )),
            ],
          ),
        ),
        Container(
          height: 500,
          child: ListView(
            children: <Widget>[
              Card(
                color: smartRTSecondaryColor,
                child: ListTile(
                  title: Text(
                    'Semua Tagihan (0)',
                    style: smartRTTextLargeBold_Primary,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: smartRTPrimaryColor,
                  ),
                ),
              ),
              Card(
                color: smartRTSecondaryColor,
                child: ListTile(
                  title: Text(
                    'Keuangan Kas',
                    style: smartRTTextLargeBold_Primary,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: smartRTPrimaryColor,
                  ),
                ),
              ),
              Card(
                color: smartRTSecondaryColor,
                child: ListTile(
                  title: Text(
                    'Keuangan Iuran',
                    style: smartRTTextLargeBold_Primary,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: smartRTPrimaryColor,
                  ),
                ),
              ),
              Card(
                color: smartRTSecondaryColor,
                child: ListTile(
                  title: Text(
                    'Keuangan Arisan',
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
    );
  }
}
