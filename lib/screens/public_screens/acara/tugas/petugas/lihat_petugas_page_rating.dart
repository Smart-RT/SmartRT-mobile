import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/models/event/event_task.dart';
import 'package:smart_rt/models/event/event_task_detail.dart';
import 'package:smart_rt/models/event/event_task_detail_rating.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/event_provider.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/circle_avatar_loader/circle_avatar_loader.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/parts/explain_part.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class LihatPetugasPageRatingArgument {
  String title;
  EventTaskDetail dataPetugas;
  bool isPast;
  EventTask dataTugas;
  LihatPetugasPageRatingArgument(
      {required this.title,
      required this.isPast,
      required this.dataPetugas,
      required this.dataTugas});
}

class LihatPetugasPageRating extends StatefulWidget {
  static const String id = 'LihatPetugasPageRating';
  LihatPetugasPageRatingArgument args;
  LihatPetugasPageRating({Key? key, required this.args}) : super(key: key);

  @override
  State<LihatPetugasPageRating> createState() => _LihatPetugasPageRatingState();
}

class _LihatPetugasPageRatingState extends State<LihatPetugasPageRating> {
  User user = AuthProvider.currentUser!;
  List<EventTaskDetailRating> listRating = [];
  String title = '';
  bool isPast = false;
  EventTaskDetail? dataPetugas;

  bool isShowBtnBeriRating = true;
  EventTask? dataTugas;

  void showDialogRatingReview() {
    final _reviewController = TextEditingController();
    double tempCtrRating = 0;
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Hai Sobat Pintar,',
          style: smartRTTextTitleCard,
        ),
        content: Text(
          'Anda dapat memberikan penilaian pada petugas untuk meningkatkan performa dan memberikan apresiasi',
          style: smartRTTextNormal.copyWith(fontWeight: FontWeight.normal),
        ),
        actions: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: RatingBar.builder(
                  initialRating: tempCtrRating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemPadding: const EdgeInsets.all(5),
                  itemCount: 5,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: smartRTStatusYellowColor,
                  ),
                  onRatingUpdate: (rating) {
                    tempCtrRating = rating;
                  },
                ),
              ),
            ],
          ),
          SB_height30,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _reviewController,
              maxLines: 5,
              autocorrect: false,
              style: smartRTTextNormal_Primary,
              decoration: InputDecoration(
                labelText: 'Review',
              ),
            ),
          ),
          SB_height30,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  _reviewController.text = '';
                  tempCtrRating = 3;
                  Navigator.pop(context, 'Batal');
                },
                child: Text(
                  'Batal',
                  style: smartRTTextNormal.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  beriPenilaian(_reviewController.text, tempCtrRating);
                },
                child: Text(
                  'KIRIM',
                  style: smartRTTextNormal.copyWith(
                      fontWeight: FontWeight.bold,
                      color: smartRTStatusGreenColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void beriPenilaian(String review, double rating) async {
    await context.read<EventProvider>().giveRating(
        idTaskDetail: dataPetugas!.id, rating: rating, review: review);
    Response<dynamic> resp = await NetUtil()
        .dioClient
        .get('/event//task/detail/byID/${dataPetugas!.id}');
    dataPetugas = EventTaskDetail.fromData(resp.data);
    Navigator.pop(context);
    SmartRTSnackbar.show(context,
        message: 'Berhasil memberikan rating !',
        backgroundColor: smartRTSuccessColor);
  }

  void getData() async {
    dataPetugas = widget.args.dataPetugas;
    await context
        .read<EventProvider>()
        .getRating(idTaskDetail: dataPetugas!.id);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    List<EventTaskDetailRating> listRating =
        context.watch<EventProvider>().dataListRating;
    if (listRating.isNotEmpty) {
      for (var i = 0; i < listRating.length; i++) {
        if (user.id == listRating[i].created_by!.id) {
          isShowBtnBeriRating = false;
        }
      }
    }
    if (user.id == dataPetugas!.user_id) {
      isShowBtnBeriRating = false;
    }
    title = widget.args.title;
    dataTugas = widget.args.dataTugas;
    isPast = widget.args.isPast;
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Column(
        children: [
          Padding(
            padding: paddingScreen,
            child: Column(
              children: [
                ExplainPart(title: 'PENILAIAN', notes: title),
                SB_height5,
                Row(
                  children: [
                    Text(
                      (dataPetugas!.rating_avg ?? '0').toString(),
                      textAlign: TextAlign.left,
                    ),
                    SB_width5,
                    Icon(
                      Icons.star,
                      color: smartRTStatusYellowColor,
                      size: 20,
                    ),
                    SB_width5,
                    Text(
                      '|  ${dataPetugas!.rating_ctr.toString()} penilaian',
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            color: smartRTPrimaryColor,
            height: 2,
          ),
          Expanded(
            child: (listRating.isNotEmpty)
                ? ListView.separated(
                    separatorBuilder: (context, int) {
                      return Divider(
                        color: smartRTPrimaryColor,
                        height: 5,
                      );
                    },
                    itemCount: listRating.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        child: ListTile(
                          leading: CircleAvatarLoader(
                            radius: 50,
                            initials: StringFormat.initialName(
                                listRating[index].created_by!.full_name),
                            initialBackgroundColor: smartRTPrimaryColor,
                            initialColor: smartRTSecondaryColor,
                            fontSizeInitial: 20,
                          ),
                          title: Text(listRating[index].created_by!.full_name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SB_width5,
                              if (listRating[index].rating == 5)
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: smartRTStatusYellowColor,
                                      size: 15,
                                    ),
                                    SB_width5,
                                    Icon(
                                      Icons.star,
                                      color: smartRTStatusYellowColor,
                                      size: 15,
                                    ),
                                    SB_width5,
                                    Icon(
                                      Icons.star,
                                      color: smartRTStatusYellowColor,
                                      size: 15,
                                    ),
                                    SB_width5,
                                    Icon(
                                      Icons.star,
                                      color: smartRTStatusYellowColor,
                                      size: 15,
                                    ),
                                    SB_width5,
                                    Icon(
                                      Icons.star,
                                      color: smartRTStatusYellowColor,
                                      size: 15,
                                    ),
                                  ],
                                ),
                              if (listRating[index].rating == 4)
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: smartRTStatusYellowColor,
                                      size: 15,
                                    ),
                                    SB_width5,
                                    Icon(
                                      Icons.star,
                                      color: smartRTStatusYellowColor,
                                      size: 15,
                                    ),
                                    SB_width5,
                                    Icon(
                                      Icons.star,
                                      color: smartRTStatusYellowColor,
                                      size: 15,
                                    ),
                                    SB_width5,
                                    Icon(
                                      Icons.star,
                                      color: smartRTStatusYellowColor,
                                      size: 15,
                                    ),
                                    SB_width5,
                                    Icon(
                                      Icons.star,
                                      color: smartRTStatusGreyColor,
                                      size: 15,
                                    ),
                                  ],
                                ),
                              if (listRating[index].rating == 3)
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: smartRTStatusYellowColor,
                                      size: 15,
                                    ),
                                    SB_width5,
                                    Icon(
                                      Icons.star,
                                      color: smartRTStatusYellowColor,
                                      size: 15,
                                    ),
                                    SB_width5,
                                    Icon(
                                      Icons.star,
                                      color: smartRTStatusYellowColor,
                                      size: 15,
                                    ),
                                    SB_width5,
                                    Icon(
                                      Icons.star,
                                      color: smartRTStatusGreyColor,
                                      size: 15,
                                    ),
                                    SB_width5,
                                    Icon(
                                      Icons.star,
                                      color: smartRTStatusGreyColor,
                                      size: 15,
                                    ),
                                  ],
                                ),
                              if (listRating[index].rating == 2)
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: smartRTStatusYellowColor,
                                      size: 15,
                                    ),
                                    SB_width5,
                                    Icon(
                                      Icons.star,
                                      color: smartRTStatusYellowColor,
                                      size: 15,
                                    ),
                                    SB_width5,
                                    Icon(
                                      Icons.star,
                                      color: smartRTStatusGreyColor,
                                      size: 15,
                                    ),
                                    SB_width5,
                                    Icon(
                                      Icons.star,
                                      color: smartRTStatusGreyColor,
                                      size: 15,
                                    ),
                                    SB_width5,
                                    Icon(
                                      Icons.star,
                                      color: smartRTStatusGreyColor,
                                      size: 15,
                                    ),
                                  ],
                                ),
                              if (listRating[index].rating == 1)
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: smartRTStatusYellowColor,
                                      size: 15,
                                    ),
                                    SB_width5,
                                    Icon(
                                      Icons.star,
                                      color: smartRTStatusGreyColor,
                                      size: 15,
                                    ),
                                    SB_width5,
                                    Icon(
                                      Icons.star,
                                      color: smartRTStatusGreyColor,
                                      size: 15,
                                    ),
                                    SB_width5,
                                    Icon(
                                      Icons.star,
                                      color: smartRTStatusGreyColor,
                                      size: 15,
                                    ),
                                    SB_width5,
                                    Icon(
                                      Icons.star,
                                      color: smartRTStatusGreyColor,
                                      size: 15,
                                    ),
                                  ],
                                ),
                              if (listRating[index].rating == 0)
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: smartRTStatusGreyColor,
                                      size: 15,
                                    ),
                                    SB_width5,
                                    Icon(
                                      Icons.star,
                                      color: smartRTStatusGreyColor,
                                      size: 15,
                                    ),
                                    SB_width5,
                                    Icon(
                                      Icons.star,
                                      color: smartRTStatusGreyColor,
                                      size: 15,
                                    ),
                                    SB_width5,
                                    Icon(
                                      Icons.star,
                                      color: smartRTStatusGreyColor,
                                      size: 15,
                                    ),
                                    SB_width5,
                                    Icon(
                                      Icons.star,
                                      color: smartRTStatusGreyColor,
                                      size: 15,
                                    ),
                                  ],
                                ),
                              Text(
                                listRating[index].review ?? '',
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      'Tidak ada Penilaian',
                      style: smartRTTextLarge,
                    ),
                  ),
          ),
          if (isShowBtnBeriRating)
            Padding(
              padding: paddingScreen,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    showDialogRatingReview();
                  },
                  child: Text(
                    'BERIKAN PENILAIAN',
                    style: smartRTTextLargeBold_Secondary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
