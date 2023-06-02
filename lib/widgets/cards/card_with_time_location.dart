import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';

class CardWithTimeLocation extends StatelessWidget {
  const CardWithTimeLocation({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.dateTime,
    required this.location,
    this.status,
    this.onTap,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String dateTime;
  final String location;
  final String? status;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Padding(
        padding: paddingCard,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: smartRTTextLargeBold_Primary,
              textAlign: TextAlign.justify,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              subtitle,
              style: smartRTTextNormal_Primary,
              textAlign: TextAlign.justify,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            SB_height15,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.access_time,
                  size: 15,
                ),
                SB_width25,
                Expanded(
                  child: Text(
                    dateTime,
                    style: smartRTTextNormal_Primary,
                  ),
                ),
              ],
            ),
            SB_height5,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_pin,
                  size: 15,
                ),
                SB_width25,
                Expanded(
                  child: Text(
                    location,
                    style: smartRTTextNormal_Primary,
                  ),
                ),
              ],
            ),
            if (status != '' && status != null)
              Text(
                status!,
                style: smartRTTextSmall,
                textAlign: TextAlign.right,
              ),
          ],
        ),
      ),
    );
  }
}
