import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/neighbourhood_head/neighbourhood_head_candidate.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:im_stepper/stepper.dart';
import 'package:smart_rt/providers/voting_provider.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/widgets/circle_avatar_loader/circle_avatar_loader.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_data_1.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_kandidat_vote.dart';

class VotingPage1 extends StatefulWidget {
  static const String id = 'VotingPage1';

  const VotingPage1({Key? key}) : super(key: key);

  @override
  State<VotingPage1> createState() => _VotingPage1State();
}

class _VotingPage1State extends State<VotingPage1> {
  User user = AuthProvider.currentUser!;
  int activeStep = 0;
  int upperBound = 2;
  List<NeighbourhoodHeadCandidate> listKandidatVote = [];
  List<bool> isChecked = [];
  List<bool> isShowMore = [];
  int checkedVoteVal = -1;

  void getData() async {
    Response<dynamic> resp = await NetUtil().dioClient.get(
        '/vote/pengurus-rt/data/list-kandidat/period/${user.area!.periode}');
    if (resp.statusCode.toString() == '200') {
      listKandidatVote
          .addAll((resp.data).map<NeighbourhoodHeadCandidate>((request) {
        return NeighbourhoodHeadCandidate.fromData(request);
      }));
    }

    for (var i = 0; i < listKandidatVote.length; i++) {
      isChecked.add(false);
      isShowMore.add(false);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Voting Kandidat'),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Padding(
            padding: paddingScreen,
            child: NumberStepper(
              enableNextPreviousButtons: false,
              stepColor: smartRTDisabledColor,
              activeStepColor: smartRTActiveColor2,
              activeStepBorderColor: smartRTPrimaryColor,
              numberStyle: smartRTTextLarge,
              lineColor: smartRTPrimaryColor,
              numbers: const [
                1,
                2,
                3,
              ],
              activeStep: activeStep,
              onStepReached: (index) {
                setState(() {
                  activeStep = index;
                });
              },
            ),
          ),
          header(),
          Expanded(child: body()),
        ]),
        bottomNavigationBar: (activeStep != 2)
            ? Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ))),
                  onPressed: () async {
                    setState(() {
                      activeStep = activeStep + 1;
                    });
                  },
                  child: Text(
                    'SELANJUTNYA',
                    style: smartRTTextLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: smartRTSecondaryColor),
                  ),
                ),
              )
            : const SizedBox());
  }

  Widget header() {
    return Container(
      padding: paddingCard,
      decoration: BoxDecoration(
        color: smartRTActiveColor2,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(headerText(), style: smartRTTextTitleCard),
          ),
        ],
      ),
    );
  }

  Widget body() {
    switch (activeStep) {
      case 1:
        return Padding(
          padding: paddingScreen,
          child: ListView.separated(
            separatorBuilder: (context, int) {
              return const Divider(
                height: 30,
              );
            },
            itemCount: listKandidatVote.length,
            itemBuilder: (context, index) {
              return ListTileKandidatVote(
                fullName: listKandidatVote[index].dataUser!.full_name,
                address: listKandidatVote[index].dataUser!.address ?? '',
                ratingTaskAvg: listKandidatVote[index].avgRatingTask ?? '0',
                ratingTaskCount: listKandidatVote[index].totalRatingTask ?? '0',
                totalTask: listKandidatVote[index].totalTask ?? '0',
                initialName: StringFormat.initialName(
                    listKandidatVote[index].dataUser!.full_name),
                visi: listKandidatVote[index].visi,
                misi: listKandidatVote[index].misi,
                isShowMore: isShowMore[index],
                isChecked: isChecked[index],
                kandidatNum: (index + 1).toString(),
                onChanged: (val) {
                  for (var i = 0; i < isChecked.length; i++) {
                    isChecked[i] = false;
                  }
                  setState(
                    () {
                      isChecked[index] = true;
                      checkedVoteVal = listKandidatVote[index].id;
                    },
                  );
                },
                onTapShowMore: () {
                  setState(
                    () {
                      isShowMore[index] = !isShowMore[index];
                    },
                  );
                },
              );
            },
          ),
        );

      case 2:
        return SingleChildScrollView(
          child: Padding(
              padding: paddingScreen,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Lottie.asset('assets/lotties/decoration/vote.json',
                      fit: BoxFit.fitWidth),
                  ConfirmationSlider(
                    backgroundColor: smartRTActiveColor2,
                    backgroundColorEnd: smartRTSuccessColor,
                    foregroundColor: smartRTPrimaryColor,
                    iconColor: smartRTActiveColor2,
                    text: 'Geser untuk Konfirmasi',
                    onConfirmation: () async {
                      debugPrint('masokkkk');
                      if (checkedVoteVal == -1) {
                        debugPrint('tampilin pesan');
                      } else {
                        bool isSuccess = await context
                            .read<VotingProvider>()
                            .sendVote(
                                idNeighbourhoodHeadCandidate: checkedVoteVal,
                                periode: user.area!.periode.toString());

                        if (isSuccess) {
                          Navigator.pop(context);
                          getData();
                          setState(() {});
                          SmartRTSnackbar.show(context,
                              message: "Berhasil mengirimkan suara!",
                              backgroundColor: smartRTSuccessColor);
                        } else {
                          SmartRTSnackbar.show(context,
                              message:
                                  "Terjadi kesalahan! Cobalah beberapa saat lagi!",
                              backgroundColor: smartRTErrorColor);
                        }
                      }
                    },
                  ),
                ],
              )),
        );

      default:
        return SingleChildScrollView(
          child: Padding(
            padding: paddingScreen,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Text(
                      '1.',
                      style: smartRTTextLarge,
                    )),
                    Expanded(
                        flex: 11,
                        child: Text(
                            'Jika anda telah membaca semua instruksi, anda dapat melanjutkan ke step berikutnya dengan menekan tombol "SELANJUTNYA" di bawah halaman atau langkah nomor "2" di atas halaman.',
                            style: smartRTTextLarge)),
                  ],
                ),
                SB_height5,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Text(
                      '2.',
                      style: smartRTTextLarge,
                    )),
                    Expanded(
                        flex: 11,
                        child: Text(
                            'Pada halaman/langkah ke dua, anda dapat memilih satu dari kandidat yang telah terdaftar dengan cara mencentang kotak cek yang telah disediakan. Pastikan bahwa diri anda sendiri yang akan melakukan voting dan suara yang anda berikan memang benar berasal dari diri anda!',
                            style: smartRTTextLarge)),
                  ],
                ),
                SB_height5,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Text(
                      '3.',
                      style: smartRTTextLarge,
                    )),
                    Expanded(
                        flex: 11,
                        child: Text(
                            'Jika anda sudah yakin dengan pilihan anda, anda dapat lanjut ke halaman/langkah selanjutnya dan melakukan konfirmasi dengan cara melakukan ...',
                            style: smartRTTextLarge)),
                  ],
                ),
              ],
            ),
          ),
        );
    }
  }

  String headerText() {
    switch (activeStep) {
      case 1:
        return 'PILIH KANDIDAT';

      case 2:
        return 'KONFIRMASI';

      default:
        return 'INSTRUKSI';
    }
  }
}
