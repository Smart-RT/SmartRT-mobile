import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/widgets/circle_avatar_loader/circle_avatar_loader.dart';

class ListTileUser1 extends StatelessWidget {
  const ListTileUser1({
    Key? key,
    required this.fullName,
    required this.address,
    this.photoPathURL,
    this.photo,
    required this.initialName,
  }) : super(key: key);

  final String fullName;
  final String address;
  final String? photoPathURL;
  final String? photo;
  final String initialName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
      subtitle: Text(address),
    );
  }
}
