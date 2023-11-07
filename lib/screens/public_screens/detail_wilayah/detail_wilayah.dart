import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/models/area/area.dart';
import 'package:smart_rt/providers/auth_provider.dart';

class DetailWilayah extends StatelessWidget {
  static const String id = 'DetailWilayahPage';
  const DetailWilayah({super.key});

  @override
  Widget build(BuildContext context) {
    Area area = context.watch<AuthProvider>().user!.area!;

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Wilayah"),
      ),
      body: Container(
          child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            dense: true,
            title: Text("Ketua"),
            subtitle:
                Text(area.ketua_id != null ? area.ketua_id!.full_name : ""),
          ),
          ListTile(
            leading: Icon(Icons.person),
            dense: true,
            title: Text("Wakil Ketua"),
            subtitle: Text(area.wakil_ketua_id != null
                ? area.wakil_ketua_id!.full_name
                : "Belum Ada, Kode: ${area.wakil_ketua_code}"),
          ),
          ListTile(
            leading: Icon(Icons.person),
            dense: true,
            title: Text("Sekretaris"),
            subtitle: Text(area.sekretaris_id != null
                ? area.sekretaris_id!.full_name
                : "Belum Ada, Kode: ${area.sekretaris_code}"),
          ),
          ListTile(
            leading: Icon(Icons.person),
            dense: true,
            title: Text("Bendahara"),
            subtitle: Text(area.bendahara_id != null
                ? area.bendahara_id!.full_name
                : "Belum Ada, Kode: ${area.bendahara_code}"),
          ),
        ],
      )),
    );
  }
}
