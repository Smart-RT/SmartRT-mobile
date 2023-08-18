import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_user_1.dart';
import 'package:smart_rt/widgets/parts/explain_part.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/utilities/string/string_format.dart';

class LihatWargaPageArguments {
  int areaID;
  String title;
  LihatWargaPageArguments({required this.areaID, required this.title});
}

class LihatWargaPage extends StatefulWidget {
  static const String id = 'LihatWargaPage';
  LihatWargaPageArguments args;
  LihatWargaPage({Key? key, required this.args}) : super(key: key);

  @override
  State<LihatWargaPage> createState() => LihatWargaPageState();
}

class LihatWargaPageState extends State<LihatWargaPage> {
  User user = AuthProvider.currentUser!;
  List<User> listUserWilayah = [];

  void getData() async {
    listUserWilayah = await context
        .read<AuthProvider>()
        .getListUserWilayahByAreaID(
            context: context, areaID: widget.args.areaID);

    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
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
                title: 'LIHAT POPULASI'.toUpperCase(),
                notes: widget.args.title),
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
              itemCount: listUserWilayah.length,
              itemBuilder: (context, index) {
                return ListTileUser1(
                  fullName: listUserWilayah[index].full_name,
                  address: listUserWilayah[index].address.toString(),
                  photoPathURL:
                      '${backendURL}/public/uploads/users/${listUserWilayah[index].id}/profile_picture/',
                  photo: listUserWilayah[index].photo_profile_img.toString(),
                  initialName: StringFormat.initialName(
                      listUserWilayah[index].full_name),
                  role: listUserWilayah[index].user_role.name,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
