import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';

class CardWithStatus extends StatelessWidget {
  const CardWithStatus(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.dateTime,
      required this.onTap,
      })
      : super(key: key);

  final String title;
  final String subtitle;
  final String dateTime;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: paddingCard,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: smartRTTextLargeBold_Primary, textAlign: TextAlign.justify, maxLines: 1, overflow: TextOverflow.ellipsis,),
            Text(subtitle, style: smartRTTextNormal_Primary, textAlign: TextAlign.justify, maxLines: 2, overflow: TextOverflow.ellipsis,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Status : ', style: smartRTTextNormal_Primary,),
                Text(dateTime, style: smartRTTextNormal_Primary,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
