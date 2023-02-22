import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/widgets/circle_avatar_loader/circle_avatar_loader.dart';

class ListTileUserWithCB extends StatelessWidget {
  const ListTileUserWithCB({
    Key? key,
    required this.fullName,
    required this.address,
    required this.photoPathURL,
    required this.photo,
    required this.initialName,
    required this.isChecked,
    required this.onChanged,
    this.isDisabled,
  }) : super(key: key);

  final String fullName;
  final String address;
  final String photoPathURL;
  final String photo;
  final String initialName;
  final bool isChecked;
  final bool? isDisabled;
  final ValueChanged<bool?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatarLoader(
        radius: 50,
        photoPathUrl: photoPathURL,
        photo: photo,
        initials: initialName,
        initialColor:
            (isDisabled ?? false) ? smartRTDisabledColor : smartRTPrimaryColor,
      ),
      title: (isDisabled ?? false)
          ? Text(
              fullName,
              style: TextStyle(color: smartRTDisabledColor),
            )
          : Text(fullName),
      subtitle: (isDisabled ?? false)
          ? Text(
              address,
              style: TextStyle(color: smartRTDisabledColor),
            )
          : Text(address),
      trailing: (isDisabled ?? false)
          ? const Text('')
          : Checkbox(
              checkColor: MaterialStateColor.resolveWith(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return smartRTSuccessColor;
                  }
                  return smartRTSuccessColor2;
                },
              ),
              value: isChecked,
              onChanged: onChanged,
            ),
    );
  }
}
