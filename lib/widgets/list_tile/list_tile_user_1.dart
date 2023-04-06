import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/widgets/circle_avatar_loader/circle_avatar_loader.dart';

class ListTileUser1 extends StatelessWidget {
  const ListTileUser1({
    Key? key,
    required this.fullName,
    required this.address,
    this.photoPathURL,
    this.photo,
    this.ratingAVG,
    this.ratingCTR,
    required this.initialName,
    this.onTap,
  }) : super(key: key);

  final String fullName;
  final String address;
  final String? photoPathURL;
  final String? photo;
  final String? ratingAVG;
  final String? ratingCTR;
  final String initialName;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: ListTile(
        leading: CircleAvatarLoader(
          radius: 50,
          photoPathUrl: photoPathURL ?? '',
          photo: photo ?? '',
          initials: initialName,
          initialBackgroundColor: smartRTPrimaryColor,
          initialColor: smartRTSecondaryColor,
          fontSizeInitial: 20,
        ),
        title: Text(fullName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              address,
              textAlign: TextAlign.left,
            ),
            if (ratingAVG != null) SB_height15,
            if (ratingAVG != null)
              Row(
                children: [
                  Text(
                    ratingAVG!,
                    textAlign: TextAlign.left,
                  ),
                  SB_width5,
                  Icon(
                    Icons.star,
                    color: smartRTStatusYellowColor,
                    size: 20,
                  ),
                  SB_width5,
                  Text(
                    '|  $ratingCTR penilaian',
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
