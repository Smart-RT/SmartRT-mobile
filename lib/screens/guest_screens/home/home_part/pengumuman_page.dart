
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/style.dart';

class PengumumanPage extends StatelessWidget {
  const PengumumanPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Card(
          color: smartRTSecondaryColor,
          child: ListTile(
            leading: Icon(
              Icons.image,
              size: 72,
            ),
            title: Text(
              '[Judul Berita]',
              style: smartRTTextLargeBold_Primary,
            ),
            subtitle: Text(
              'Senin, 1 Agustus 2022\n\nFirst blood, literally. Meski secara biologis keduanya tak bisa menghasilkan janin, namun rutinitas majikan dan budak ini bakal terus berjalan hingga Taku mengumpulkan kawanan lainnya.',
              style: smartRTTextNormal_Primary,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Card(
          color: smartRTSecondaryColor,
          child: ListTile(
            leading: Icon(
              Icons.image,
              size: 72,
            ),
            title: Text(
              '[Judul Berita]',
              style: smartRTTextLargeBold_Primary,
            ),
            subtitle: Text(
              'Senin, 1 Agustus 2022\n\nFirst blood, literally. Meski secara biologis keduanya tak bisa menghasilkan janin, namun rutinitas majikan dan budak ini bakal terus berjalan hingga Taku mengumpulkan kawanan lainnya.',
              style: smartRTTextNormal_Primary,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Card(
          color: smartRTSecondaryColor,
          child: ListTile(
            leading: Icon(
              Icons.image,
              size: 72,
            ),
            title: Text(
              '[Judul Berita]',
              style: smartRTTextLargeBold_Primary,
            ),
            subtitle: Text(
              'Senin, 1 Agustus 2022\n\nFirst blood, literally. Meski secara biologis keduanya tak bisa menghasilkan janin, namun rutinitas majikan dan budak ini bakal terus berjalan hingga Taku mengumpulkan kawanan lainnya.',
              style: smartRTTextNormal_Primary,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}

