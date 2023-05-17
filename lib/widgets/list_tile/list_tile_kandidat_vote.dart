import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/widgets/circle_avatar_loader/circle_avatar_loader.dart';

class ListTileKandidatVote extends StatelessWidget {
  const ListTileKandidatVote(
      {Key? key,
      required this.fullName,
      required this.address,
      this.photoPathURL,
      this.photo,
      required this.ratingTaskAvg,
      required this.ratingTaskCount,
      required this.totalTask,
      required this.initialName,
      required this.visi,
      required this.misi,
      required this.isShowMore,
      required this.isChecked,
      required this.kandidatNum,
      required this.onTapShowMore,
      required this.onChanged})
      : super(key: key);

  final String fullName;
  final String address;
  final String? photoPathURL;
  final String? photo;
  final String ratingTaskAvg;
  final String ratingTaskCount;
  final String totalTask;
  final String initialName;
  final String visi;
  final String misi;
  final bool isShowMore;
  final bool isChecked;
  final String kandidatNum;
  final ValueChanged<bool?> onChanged;
  final Function() onTapShowMore;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: smartRTQuaternaryColor,
      ),
      padding: paddingCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'KANDIDAT NO $kandidatNum',
            style: smartRTTextTitleCard.copyWith(letterSpacing: 5),
            textAlign: TextAlign.left,
          ),
          const Divider(
            thickness: 2,
          ),
          Row(
            children: [
              Expanded(
                child: Checkbox(
                  value: isChecked,
                  onChanged: onChanged,
                ),
              ),
              SB_width15,
              Expanded(
                flex: 3,
                child: CircleAvatarLoader(
                  radius: 50,
                  initials: initialName,
                  photo: photo,
                  photoPathUrl: photoPathURL,
                  initialColor: smartRTPrimaryColor,
                  initialBackgroundColor: smartRTShadowColor,
                ),
              ),
              SB_width15,
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      fullName,
                      style: smartRTTextTitleCard,
                    ),
                    Text(
                      address,
                      style: smartRTTextNormal,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            thickness: 2,
          ),
          if (isShowMore)
            Column(
              children: [
                SB_height15,
                Row(
                  children: [
                    const Expanded(flex: 5, child: Text('Penilaian Keaktifan')),
                    const Expanded(child: Text(':')),
                    Expanded(
                        flex: 5,
                        child: Row(
                          children: [
                            Text(ratingTaskAvg),
                            Icon(
                              Icons.star,
                              size: 15,
                              color: smartRTTertiaryColor,
                            ),
                            SB_width5,
                            Text('($ratingTaskCount Penilaian)'),
                          ],
                        )),
                  ],
                ),
                Row(
                  children: [
                    const Expanded(flex: 5, child: Text('Total Keaktifan ')),
                    const Expanded(child: Text(':')),
                    Expanded(flex: 5, child: Text(totalTask)),
                  ],
                ),
                SB_height15,
                const Divider(
                  thickness: 2,
                ),
                SB_height15,
                Text(
                  'VISI MISI',
                  style: smartRTTextLarge,
                ),
                SB_height15,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(flex: 3, child: Text('Visi')),
                    const Expanded(child: Text(':')),
                    Expanded(flex: 15, child: Text(visi)),
                  ],
                ),
                SB_height15,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(flex: 3, child: Text('Misi')),
                    const Expanded(child: Text(':')),
                    Expanded(flex: 15, child: Text(misi)),
                  ],
                ),
                SB_height15,
                const Divider(
                  thickness: 2,
                ),
              ],
            ),
          GestureDetector(
            onTap: onTapShowMore,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  (isShowMore) ? 'SEMBUNYIKAN' : 'LIHAT DETAIL',
                  style: smartRTTextSmall.copyWith(color: smartRTTertiaryColor),
                ),
                Icon(
                    (isShowMore)
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: smartRTTertiaryColor)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
