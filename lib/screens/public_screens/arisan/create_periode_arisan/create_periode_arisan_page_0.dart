import 'package:flutter/material.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/screens/public_screens/arisan/create_periode_arisan/create_periode_arisan_page_1.dart';
import 'package:smart_rt/widgets/parts/explain_with_button.dart';

class CreatePeriodeArisanPage0 extends StatefulWidget {
  static const String id = 'CreatePeriodeArisanPage0';
  const CreatePeriodeArisanPage0({Key? key}) : super(key: key);

  @override
  State<CreatePeriodeArisanPage0> createState() =>
      _CreatePeriodeArisanPage0State();
}

class _CreatePeriodeArisanPage0State extends State<CreatePeriodeArisanPage0> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Padding(
        padding: paddingScreen,
        child: Column(
          children: [
            // ignore: prefer_const_constructors
            ExplainWithButton(
                title: 'Arisan sedang tidak Berlangsung?',
                notes:
                    'Anda dapat membuat periode arisan baru dimana akan dimulai dari pertemuan ke-1.',
                buttonText: 'BUAT BARU SEKARANG !',
                onTapDestination: CreatePeriodeArisanPage1.id),
            SB_height50,
            // ignore: prefer_const_constructors
            ExplainWithButton(
                title: 'Arisan sedang Berlangsung?',
                notes:
                    'Anda dapat membuat periode arisan yang bukan dimulai dari pertemuan ke-1 sehingga dapat melanjutkan periode arisan wilayah anda yang sedang berjalan. \n\nPastikan semua member arisan anda memiliki aplikasi ini!',
                buttonText: 'BUAT LANJUTAN SEKARANG !',
                onTapDestination: ""),
          ],
        ),
      ),
    );
  }
}
