import 'package:flutter/material.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:toggle_switch/toggle_switch.dart';

class PengaturanArisanPage extends StatefulWidget {
  static const String id = 'PengaturanArisanPage';
  const PengaturanArisanPage({Key? key}) : super(key: key);

  @override
  State<PengaturanArisanPage> createState() => _PengaturanArisanPageState();
}

class _PengaturanArisanPageState extends State<PengaturanArisanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan Arisan'),
      ),
      body: Padding(
        padding: paddingScreen,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Apakah anggota yang belum melunasi tagihan arisan dapat mengikuti undian?',
                        style: smartRTTextLarge,
                      ),
                    ),
                    SB_width15,
                    ToggleSwitch(
                      minWidth: 65.0,
                      cornerRadius: 20.0,
                      activeBgColors: [
                        [Colors.green[800]!],
                        [Colors.red[800]!]
                      ],
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      initialLabelIndex: 1,
                      totalSwitches: 2,
                      labels: ['Ya', 'Tidak'],
                      radiusStyle: true,
                      onToggle: (index) {
                        print('switched to: $index');
                      },
                    ),
                  ],
                ),
                SB_height15,
                Divider(height: 30, thickness: 2),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Apakah anggota yang tidak hadir di arisan dapat mengikuti undian?',
                        style: smartRTTextLarge,
                      ),
                    ),
                    SB_width15,
                    ToggleSwitch(
                      minWidth: 65.0,
                      cornerRadius: 20.0,
                      activeBgColors: [
                        [Colors.green[800]!],
                        [Colors.red[800]!]
                      ],
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      initialLabelIndex: 1,
                      totalSwitches: 2,
                      labels: ['Ya', 'Tidak'],
                      radiusStyle: true,
                      onToggle: (index) {
                        print('switched to: $index');
                      },
                    ),
                  ],
                ),
              ],
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {},
                child: Text(
                  'SIMPAN',
                  style: smartRTTextLargeBold_Secondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
