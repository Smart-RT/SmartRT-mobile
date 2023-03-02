import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/widgets/circle_avatar_loader/circle_avatar_loader.dart';

class ListTileUser2 extends StatelessWidget {
  const ListTileUser2({
    Key? key,
    required this.fullName,
    required this.address,
    this.photoPathURL,
    this.photo,
    required this.initialName,
    required this.tileColor,
    this.via,
    this.paymentDate,
    this.onTap,
  }) : super(key: key);

  final String fullName;
  final String address;
  final String? photoPathURL;
  final String? photo;
  final String initialName;
  final String? via;
  final String? paymentDate;
  final Color tileColor;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: ListTile(
        tileColor: tileColor,
        leading: CircleAvatarLoader(
          radius: 50,
          photoPathUrl: photoPathURL,
          photo: photo,
          initials: initialName,
        ),
        title: Text(fullName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(address),
            SB_height15,
            paymentDate != ''
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pembayaran Via $via'),
                      Text('Tanggal Pembayaran $paymentDate')
                    ],
                  )
                : Text('Belum Bayar'),
          ],
        ),
      ),
    );
  }
}
