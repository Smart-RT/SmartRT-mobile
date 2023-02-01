import 'package:flutter/material.dart';
import 'package:smart_rt/widgets/circle_avatar_loader/circle_avatar_loader.dart';

class ListAnggotaArisanPage extends StatefulWidget {
  static const String id = 'ListAnggotaArisanPage';
  const ListAnggotaArisanPage({Key? key}) : super(key: key);

  @override
  State<ListAnggotaArisanPage> createState() => _ListAnggotaArisanPageState();
}

class _ListAnggotaArisanPageState extends State<ListAnggotaArisanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anggota Arisan'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Divider(height: 10, thickness: 2),
            ListTile(
              leading: CircleAvatarLoader(
                radius: 50,
                photoPathUrl: '',
                photo: '',
                initials: 'XX',
              ),
              title: Text('Nama Anggota'),
              subtitle: Text('Alamat Rumah'),
            ),
            Divider(height: 10, thickness: 2),
            ListTile(
              leading: CircleAvatarLoader(
                radius: 50,
                photoPathUrl: '',
                photo: '',
                initials: 'XX',
              ),
              title: Text('Nama Anggota'),
              subtitle: Text('Alamat Rumah'),
            ),
            Divider(height: 10, thickness: 2),
            ListTile(
              leading: CircleAvatarLoader(
                radius: 50,
                photoPathUrl: '',
                photo: '',
                initials: 'XX',
              ),
              title: Text('Nama Anggota'),
              subtitle: Text('Alamat Rumah'),
            ),
            Divider(height: 10, thickness: 2),
          ],
        ),
      ),
    );
  }
}
