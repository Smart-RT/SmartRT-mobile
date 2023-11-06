import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_rt/models/news/news.dart';
import 'package:smart_rt/utilities/net_util.dart';

class NewsProvider extends ChangeNotifier {
  List<News> dataListNews = [];
  List<News> get news => dataListNews;
  set news(List<News> value) {
    dataListNews = value;
  }

  void updateListener() => notifyListeners();

  Future<void> getDataListNews() async {
    try {
      List<News> listNews = <News>[];
      Response<dynamic> resp = await NetUtil().dioClient.get('/news/get/all');
      listNews.addAll((resp.data).map<News>((request) {
        return News.fromData(request);
      }));
      dataListNews = listNews;
      notifyListeners();
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  Future<bool> createNews({
    required String title,
    required String detail,
    required String isWithLampiran,
    MultipartFile? multiPartImageLampiran,
  }) async {
    try {
      if (isWithLampiran == 'true') {
        var formData = FormData.fromMap({
          "title": title,
          "detail": detail,
          "is_with_lampiran": 'true',
          "file_img": multiPartImageLampiran!
        });
        await NetUtil().dioClient.post('/news/add', data: formData);
      } else {
        await NetUtil().dioClient.post('/news/add', data: {
          "title": title,
          "detail": detail,
          "is_with_lampiran": 'false',
        });
      }

      getDataListNews();
      return true;
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
      return false;
    }
  }
}
