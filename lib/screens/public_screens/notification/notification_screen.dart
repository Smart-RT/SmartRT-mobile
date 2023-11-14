import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/notification/notification.dart' as No;
import 'package:smart_rt/providers/notification_provider.dart';
import 'package:smart_rt/screens/public_screens/administration/administration_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/arisan_page.dart';
import 'package:smart_rt/screens/public_screens/janji_temu/buat_janji_temu_page.dart';
import 'package:smart_rt/screens/public_screens/janji_temu/list_janji_temu_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/kesehatanku_page.dart';

class NotificationScreen extends StatelessWidget {
  static const String id = 'NotificationScreen';
  const NotificationScreen({super.key});

  Future<void> getData(BuildContext context) async {
    context.read<NotificationProvider>().futures[NotificationScreen.id] =
        context.read<NotificationProvider>().getNotifications(context);
    context.read<NotificationProvider>().updateListener();
    await context.read<NotificationProvider>().futures[NotificationScreen.id];
  }

  void jumpToScreen(BuildContext context, No.Notification notification) {
    String screenId = "";

    if (notification.type == 'kesehatan') {
      screenId = KesehatankuPage.id;
    } else if (notification.type == 'arisan') {
      screenId = ArisanPage.id;
    } else if (notification.type == 'administrasi') {
      screenId = AdministrationPage.id;
    } else if (notification.type == 'janji_temu') {
      screenId = ListJanjiTemuPage.id;
    }

    if (screenId.isNotEmpty) {
      Navigator.pushReplacementNamed(context, screenId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifikasi'),
        actions: [
          PopupMenuButton(
            initialValue: 0,
            onSelected: (value) async {
              context.read<NotificationProvider>().readAllNotification(context);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text(
                  'Tandai semua sudah dibaca',
                  style: smartRTTextNormal,
                ),
                value: 1,
              )
            ],
          )
        ],
      ),
      body: Container(
        child: RefreshIndicator(
          onRefresh: () => getData(context),
          child: FutureBuilder(
            future: context
                .watch<NotificationProvider>()
                .futures[NotificationScreen.id],
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Container(
                  margin: EdgeInsets.all(15),
                  child: ListView(
                    children: [
                      Text('Terjadi kesalahan, mohon refresh data...'),
                    ],
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  margin: EdgeInsets.all(15),
                  child: ListView(
                    children: [
                      Text('Sedang mengambil data, mohon tunggu...'),
                    ],
                  ),
                );
              }

              List<No.Notification> notifications =
                  context.watch<NotificationProvider>().notifications;
              return notifications.length > 0
                  ? ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () async {
                            // call read notification
                            context
                                .read<NotificationProvider>()
                                .readNotification(
                                    context, notifications[index]);
                            // call determineJumpToPage
                            jumpToScreen(context, notifications[index]);
                          },
                          title: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Text('${notifications[index].title}'),
                          ),
                          subtitle: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                            '${notifications[index].body}')),
                                  ],
                                ),
                              ),
                              SB_height15,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '${DateFormat('dd-MM-yyyy HH:mm:ss').format(notifications[index].createdAt)}',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              )
                            ],
                          ),
                          tileColor: notifications[index].isRead
                              ? null
                              : Colors.grey[200],
                        );
                      },
                      separatorBuilder: ((context, index) => Divider(
                            thickness: 1,
                          )),
                      itemCount: notifications.length)
                  : ListView(
                      children: [
                        SB_height15,
                        Center(
                          child: Text(
                            "Tidak ada Pengumuman",
                            style: smartRTTextLarge.copyWith(
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
