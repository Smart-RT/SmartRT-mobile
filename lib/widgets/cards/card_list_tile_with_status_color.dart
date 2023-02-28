import 'package:flutter/material.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';

class CardListTileWithStatusColor extends StatelessWidget {
  const CardListTileWithStatusColor({
    Key? key,
    required this.title,
    required this.subtitle,
    this.maxLineSubtitle,
    required this.bottomText,
    required this.statusColor,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final int? maxLineSubtitle;
  final String bottomText;
  final Color statusColor;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: paddingCard,
        child: Row(
          children: [
            Expanded(
                child: Container(
              height: 75,
              color: statusColor,
            )),
            SB_width15,
            Expanded(
              flex: 20,
              child: SizedBox(
                height: 75,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          title,
                          style: smartRTTextLarge.copyWith(
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.justify,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          subtitle,
                          style: smartRTTextNormal,
                          textAlign: TextAlign.justify,
                          maxLines: maxLineSubtitle ?? 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Text(
                      bottomText,
                      style: smartRTTextNormal,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
