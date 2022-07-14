import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:provider/provider.dart';

class NetUtil {
  //  Buat variabel static
  static Dio dioClient = Dio(BaseOptions(
      baseUrl: apiURL, contentType: Headers.formUrlEncodedContentType));
  static Dio dioRefreshToken = Dio();

  // Buat Singleton
  NetUtil._instance() {
    dioClient.options.connectTimeout = 10000;
    dioClient.options.receiveTimeout = 7000;

  }

  static final NetUtil _singleton = NetUtil._instance();
  factory NetUtil() => _singleton;
}