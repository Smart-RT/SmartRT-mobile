import 'package:smart_rt/constants/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/style.dart';

class CircleAvatarLoader extends StatelessWidget {
  final String? photo;
  final String? photoPathUrl;
  final String? initials;
  final double radius;
  final String? allURL;
  final double? fontSizeInitial;
  final Color? initialColor;
  final Color? initialBackgroundColor;
  final double fontHeight;
  CircleAvatarLoader(
      {this.photo,
      this.photoPathUrl,
      this.initials,
      this.radius = 20.0,
      this.allURL,
      this.fontSizeInitial,
      this.initialBackgroundColor,
      this.initialColor,
      this.fontHeight = 2.3});

  @override
  Widget build(BuildContext context) {
    if (photo == 'default.png') {
      return CircleAvatar(
        child: Text(initials!, style: TextStyle(color: Colors.white)),
        radius: radius,
        backgroundColor: Colors.black54,
      );
    }
    final String url = allURL ?? '$photoPathUrl$photo';
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) {
        return CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(url),
          radius: radius,
        );
      },
      useOldImageOnUrlChange: true,
      placeholder: (BuildContext context, String url) {
        return CircleAvatar(
          radius: radius,
          child: Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(smartRTPrimaryColor),
          )),
        );
      },
      errorWidget: (context, url, error) {
        return CircleAvatar(
          backgroundColor: initialBackgroundColor ?? smartRTSecondaryColor,
          radius: radius,
          child: Center(
            child: Text(
              '$initials',
              style: smartRTTextTitle.copyWith(
                  color: initialColor ?? smartRTPrimaryColor,
                  fontSize: fontSizeInitial ?? smartRTTextTitle.fontSize),
            ),
          ),
        );
      },
    );
  }
}
