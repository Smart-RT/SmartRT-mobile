import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';

class ListTileData3 extends StatelessWidget {
  const ListTileData3({
    Key? key,
    required this.title,
    required this.detail,
    required this.createdAt,
    this.imgNetworkDirect,
    this.onTap,
  }) : super(key: key);

  final String title;
  final String detail;
  final String createdAt;
  final String? imgNetworkDirect;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Padding(
        padding: EdgeInsets.only(
            top: paddingCard.top,
            right: 10,
            left: 10,
            bottom: paddingCard.bottom),
        child: Row(
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: imgNetworkDirect == ''
                    ? const FittedBox(
                        child: Icon(
                          Icons.image_outlined,
                        ),
                      )
                    : Image.network(
                        imgNetworkDirect!,
                        fit: BoxFit.fill,
                      ),
              ),
            ),
            SB_width15,
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: smartRTTextLarge.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    detail,
                    style: smartRTTextLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                  ),
                  SB_height15,
                  Text(
                    createdAt,
                    style: smartRTTextSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
