import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';

class CardWithTimeLocation extends StatelessWidget {
  const CardWithTimeLocation(
      {Key? key,
      required this.title,
      required this.dateTime,
      required this.location})
      : super(key: key);

  final String title;
  final String dateTime;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: smartRTTextLargeBold_Primary,),
          SB_height15,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.access_time, size: 15,),
              SB_width25,
              Text(location, style: smartRTTextNormal_Primary,),
            ],
          ),
           Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.location_pin, size: 15,),
              SB_width25,
              Text(location, style: smartRTTextNormal_Primary,),
            ],
          ),
        ],
      ),
    );
  }
}
