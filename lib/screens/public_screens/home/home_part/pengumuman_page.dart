import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/news/news.dart';
import 'package:smart_rt/screens/public_screens/pengumuman/create_pengumuman/create_pengumuman_page_1.dart';
import 'package:smart_rt/screens/public_screens/pengumuman/pengumuman_detail_page.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_data_3.dart';

class PengumumanPage extends StatelessWidget {
  List<News> listPengumuman = [];
  PengumumanPage({super.key, required this.listPengumuman});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        listPengumuman.isNotEmpty
            ? ListView.separated(
                separatorBuilder: (context, int) {
                  return Divider(
                    color: smartRTPrimaryColor,
                    thickness: 1,
                    height: 5,
                  );
                },
                itemCount: listPengumuman.length,
                itemBuilder: (context, index) {
                  return ListTileData3(
                    title: listPengumuman[index].title,
                    detail: listPengumuman[index].detail,
                    createdAt: DateFormat('d MMMM y', 'id_ID')
                        .format(listPengumuman[index].created_at),
                    imgNetworkDirect: listPengumuman[index].file_img == null ||
                            listPengumuman[index].file_img == ''
                        ? ''
                        : '${backendURL}/public/uploads/pengumuman/file_lampiran/${listPengumuman[index].id}/${listPengumuman[index].file_img}',
                    onTap: () async {
                      PengumumanDetailPageArgument args =
                          PengumumanDetailPageArgument(
                              dataPengumuman: listPengumuman[index]);
                      Navigator.pushNamed(context, PengumumanDetailPage.id,
                          arguments: args);
                    },
                  );
                },
              )
            : Center(
                child: Text(
                  "Tidak ada Pengumuman",
                  style: smartRTTextLarge.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
        Positioned(
          bottom: 25,
          right: 25,
          child: SizedBox(
              height: 75,
              width: 75,
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.pushNamed(context, CreatePengumumanPage1.id);
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                )),
                child: const Icon(Icons.add),
              )),
        ),
      ],
    );
  }
}
