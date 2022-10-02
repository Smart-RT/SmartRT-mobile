import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/screens/public_screens/gabung_wilayah/gabung_wilayah_page.dart';
import 'package:smart_rt/screens/public_screens/janji_temu/list_janji_temu_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/kesehatanku_page.dart';

class BerandaPage extends StatelessWidget {
  const BerandaPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingScreen,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  // Navigator.pushNamed(context, ListAcaraPage.id);
                },
                child: Container(
                  width: 165,
                  height: 155,
                  child: Card(
                    color: smartRTCardColor,
                    shadowColor: smartRTShadowColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: paddingCard,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: smartRTSecondaryColor,
                            size: 65,
                          ),
                          Text(
                            'Acara',
                            style: smartRTTextLargeBold_Secondary,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, ListJanjiTemuPage.id);
                },
                child: Container(
                  width: 165,
                  height: 155,
                  child: Card(
                    color: smartRTCardColor,
                    shadowColor: smartRTShadowColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: paddingCard,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.handshake,
                            color: smartRTSecondaryColor,
                            size: 65,
                          ),
                          Text(
                            'Janji Temu',
                            style: smartRTTextLargeBold_Secondary,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 165,
                height: 155,
                child: Card(
                  color: smartRTCardColor,
                  shadowColor: smartRTShadowColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: paddingCard,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.article,
                          color: smartRTSecondaryColor,
                          size: 65,
                        ),
                        Text(
                          'Administrasi',
                          style: smartRTTextLargeBold_Secondary,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 165,
                height: 155,
                child: Card(
                  color: smartRTCardColor,
                  shadowColor: smartRTShadowColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: paddingCard,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.group,
                          color: smartRTSecondaryColor,
                          size: 65,
                        ),
                        Text(
                          'Arisan',
                          style: smartRTTextLargeBold_Secondary,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 165,
                height: 155,
                child: Card(
                  color: smartRTCardColor,
                  shadowColor: smartRTShadowColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: paddingCard,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.analytics,
                          color: smartRTSecondaryColor,
                          size: 65,
                        ),
                        Text(
                          'Performa Saya',
                          textAlign: TextAlign.center,
                          style: smartRTTextLargeBold_Secondary,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, KesehatankuPage.id);
                },
                child: Container(
                  width: 165,
                  height: 155,
                  child: Card(
                    color: smartRTCardColor,
                    shadowColor: smartRTShadowColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: paddingCard,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.health_and_safety,
                            color: smartRTSecondaryColor,
                            size: 65,
                          ),
                          Text(
                            'Kesehatan',
                            style: smartRTTextLargeBold_Secondary,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, GabungWilayahPage.id);
            },
            child: Container(
              width: double.infinity,
              height: 155,
              child: Card(
                color: smartRTCardColor,
                shadowColor: smartRTShadowColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: paddingCard,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.domain_add,
                        color: smartRTSecondaryColor,
                        size: 65,
                      ),
                      Text(
                        'Gabung Wilayah',
                        style: smartRTTextLargeBold_Secondary,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
