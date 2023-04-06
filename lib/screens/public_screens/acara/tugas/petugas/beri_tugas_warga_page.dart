import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/event/event.dart';
import 'package:smart_rt/models/event/event_task.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/event_provider.dart';
import 'package:smart_rt/screens/public_screens/acara/acara_page.dart';
import 'package:smart_rt/screens/public_screens/acara/acara_page_detail.dart';
import 'package:smart_rt/screens/public_screens/acara/tugas/tugas_page_detail.dart';
import 'package:smart_rt/screens/public_screens/arisan/create_periode_arisan/create_periode_arisan_page_2.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/form_lapor_kesehatan_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_user_with_cb.dart';
import 'package:smart_rt/widgets/parts/explain_part.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/utilities/string/string_format.dart';

class BeriTugasWargaPageArgument {
  List<int> listPetugasActiveID;
  List<int> listPetugasRequestID;
  int totalSlotKosong;
  int taskID;
  String title;
  EventTask dataTugas;
  bool isPast;
  BeriTugasWargaPageArgument(
      {required this.listPetugasActiveID,
      required this.listPetugasRequestID,
      required this.totalSlotKosong,
      required this.taskID,
      required this.dataTugas,
      required this.isPast,
      required this.title});
}

class BeriTugasWargaPage extends StatefulWidget {
  static const String id = 'BeriTugasWargaPage';
  BeriTugasWargaPageArgument args;
  BeriTugasWargaPage({Key? key, required this.args}) : super(key: key);

  @override
  State<BeriTugasWargaPage> createState() => _BeriTugasWargaPageState();
}

class _BeriTugasWargaPageState extends State<BeriTugasWargaPage> {
  User user = AuthProvider.currentUser!;
  List<User>? listUserWilayah = [];
  List<int> listPetugasActiveID = [];
  List<int> listPetugasRequestID = [];
  List<bool> isChecked = [];
  List<bool> isDisabled = [];
  int totalSlotKosong = 1;
  EventTask? dataTugas;

  void berikanTugas() async {
    List<int> listID = [];
    for (var i = 0; i < listUserWilayah!.length; i++) {
      if (isChecked[i]) {
        listID.add(listUserWilayah![i].id);
      }
    }

    await context
        .read<EventProvider>()
        .giveTask(idTask: widget.args.taskID, listUserID: listID);
    Navigator.pop(context);
    SmartRTSnackbar.show(context,
        message: 'Berhasil memberikan tugas ke warga !',
        backgroundColor: smartRTSuccessColor);
  }

  void getData() async {
    dataTugas = widget.args.dataTugas;
    listPetugasActiveID = widget.args.listPetugasActiveID;
    listPetugasRequestID = widget.args.listPetugasRequestID;
    totalSlotKosong = widget.args.totalSlotKosong;
    listUserWilayah =
        await context.read<AuthProvider>().getListUserWilayah(context: context);
    for (var i = 0; i < listUserWilayah!.length; i++) {
      isChecked.add(false);
      isDisabled.add(false);
    }

    for (var i = 0; i < listUserWilayah!.length; i++) {
      if (user.id == listUserWilayah![i].id) {
        isDisabled[i] = true;
      } else {
        for (var i2 = 0; i2 < listPetugasActiveID.length; i2++) {
          if (listUserWilayah![i].id == listPetugasActiveID[i2]) {
            isDisabled[i] = true;
          }
        }
        for (var i2 = 0; i2 < listPetugasRequestID.length; i2++) {
          if (listUserWilayah![i].id == listPetugasRequestID[i2]) {
            isDisabled[i] = true;
          }
        }
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        children: [
          Padding(
            padding: paddingScreen,
            child: ExplainPart(
                title: 'BERI TUGAS WARGA',
                notes:
                    'Pilihlah warga anda yang ingin anda beri tugas!\n\nTersisa ${totalSlotKosong.toString()} slot kosong'),
          ),
          Divider(
            color: smartRTPrimaryColor,
            height: 2,
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, int) {
                return Divider(
                  color: smartRTPrimaryColor,
                  height: 5,
                );
              },
              itemCount: listUserWilayah!.length,
              itemBuilder: (context, index) {
                return ListTileUserWithCB(
                  fullName: listUserWilayah![index].full_name,
                  address: listUserWilayah![index].address.toString(),
                  photoPathURL:
                      '${backendURL}/public/uploads/users/${listUserWilayah![index].id}/profile_picture/',
                  photo: listUserWilayah![index].photo_profile_img.toString(),
                  initialName: StringFormat.initialName(
                      listUserWilayah![index].full_name),
                  isChecked: isChecked[index],
                  isDisabled: isDisabled[index],
                  onChanged: (val) {
                    setState(
                      () {
                        int ctr = 0;
                        for (var i = 0; i < isChecked.length; i++) {
                          if (isChecked[i] == true) {
                            ctr++;
                          }
                        }
                        if (ctr < totalSlotKosong || val == false) {
                          isChecked[index] = val!;
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: paddingScreen,
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  berikanTugas();
                },
                child: Text(
                  'BERIKAN TUGAS',
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
