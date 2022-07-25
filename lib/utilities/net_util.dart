import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/providers/application_provider.dart';

class NetUtil {
  // buat Base Options untuk Dio Client dan Dio Refresh Token
  // Base Options itu buat set Default URL
  // Buat set default header buat kirim x-www-url-encoded
  // Buat set receive dan connect timeout
  // - Receive TO: kalau berhasil kirim tapi ga dapat balasan dr server
  // - Connect TO: Ga bisa kirim data ke server
  static BaseOptions dioBaseOptions = BaseOptions(
    baseUrl: apiURL,
    contentType: Headers.formUrlEncodedContentType,
    connectTimeout: 10000,
    receiveTimeout: 7000,
  );

  //  Buat variabel static
  Dio dioClient = Dio(dioBaseOptions);
  Dio dioRefreshToken = Dio(dioBaseOptions);

  // Buat Singleton
  NetUtil._instance() {
    QueuedInterceptorsWrapper clientInterceptorWrapper =
        QueuedInterceptorsWrapper(onRequest: (options, handler) {
      // Check JWT disimpan atau ga
      // Kalau ada jwt tambahin ke headernya
      // Kalau ga ada jwt yaudah
      if (ApplicationProvider.currentUserJWT.isNotEmpty) {
        options.headers['Authorization'] =
            'Bearer ${ApplicationProvider.currentUserJWT}';
      }

      if (isDebugging) {
        // Kalau lagi debug munculin hasil respon ke console
        debugPrint('''[dioClient Interceptor Request Debug] => {
        header: ${options.headers}
        data  : ${options.data} 
        }''');
      }

      handler.next(options);
    }, onResponse: (response, handler) {
      // Ini saat data diterima
      if (isDebugging) {
        // Kalau lagi debug munculin hasil respon ke console
        debugPrint('''[dioClient Interceptor Response Debug] => {
        header: ${response.headers}
        data  : ${response.data} 
        }''');
      }
      handler.next(response);
    }, onError: (error, handler) async {
      // Kalau terima error, cek dulu errornya apa
      // Kalau errornya JWT expire
      // - Refresh Tokennya
      // - Kalau berhasil refresh coba request ulang
      // - Kalau ga berhasil refresh Logout
      if (error.type == DioErrorType.response &&
          error.response!.statusCode == 400) {
        // Kalau dapat error 400 akan masuk sini... ini tergantung nanti backend
        // Kirim response apa kalau JWT Error
        String? errorMessage = error.response!.data;
        if (errorMessage ==
            'Context creation failed: TokenExpiredError: jwt expired') {
          //Kalau JWT Expired Masuk sini

          // Ambil Refresh token baru
          // Response<dynamic> response = await dioRefreshToken.post('/refreshToken');
          // Setelah itu kalau dapat tokennya coba request ulang
          // Request Ulang
          return handler.resolve(await dioClient.request(
            error.requestOptions.path,
            data: error.requestOptions.data,
            queryParameters: error.requestOptions.queryParameters,
            cancelToken: error.requestOptions.cancelToken,
            options: Options(
                contentType: error.requestOptions.contentType,
                extra: error.requestOptions.extra,
                followRedirects: error.requestOptions.followRedirects,
                headers: error.requestOptions.headers,
                listFormat: error.requestOptions.listFormat,
                maxRedirects: error.requestOptions.maxRedirects,
                method: error.requestOptions.method,
                receiveDataWhenStatusError:
                    error.requestOptions.receiveDataWhenStatusError,
                receiveTimeout: error.requestOptions.receiveTimeout,
                requestEncoder: error.requestOptions.requestEncoder,
                responseDecoder: error.requestOptions.responseDecoder,
                responseType: error.requestOptions.responseType,
                sendTimeout: error.requestOptions.sendTimeout,
                validateStatus: error.requestOptions.validateStatus),
          ));
        }
      }
      handler.next(error);
    });
    dioClient.interceptors.add(clientInterceptorWrapper);
  }

  static final NetUtil _singleton = NetUtil._instance();
  factory NetUtil() => _singleton;
}
