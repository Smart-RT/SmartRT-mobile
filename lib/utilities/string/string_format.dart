import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/utilities/int/int_format.dart';

class StringFormat {
  static String convertMax2Words(String name) {
    if (name == '') {
      return '';
    } else if (name.contains(' ')) {
      List<String> tempName = name.toUpperCase().split(' ');
      if (tempName.length > 2) {
        return '${tempName[0]} ${tempName[1]} ${tempName[2][0]}.';
      } else {
        return name;
      }
    } else {
      return name;
    }
  }

  static String convert1Line1Word(String word) {
    if (word == '') {
      return '';
    } else if (word.contains(' ')) {
      List<String> listWord = word.split(' ');
      String tempWord = '';
      for (var i = 0; i < listWord.length; i++) {
        if (i == 0) {
          tempWord += '${listWord[i]}';
        } else {
          tempWord += '\n${listWord[i]}';
        }
      }
      return tempWord;
    } else {
      return word;
    }
  }

  static String initialName(String name) {
    if (name == '') {
      return '';
    } else if (name.contains(' ')) {
      List<String> nama = name.toUpperCase().split(' ');
      return '${nama[0][0]}${nama[1][0]}';
    } else if (name.length < 2) {
      return name.toUpperCase();
    } else {
      return '${name[0]}${name[1]}'.toUpperCase();
    }
  }

  static bool isKTPKKFormat(String name) {
    if (name.length != 16) {
      return false;
    }
    return true;
  }

  static String numFormatRTRW(String name) {
    if (name.length != 3) {
      String tempName = '';
      for (var i = 0; i < (3 - name.length); i++) {
        tempName += '0';
      }
      tempName += name;
      return tempName;
    }
    return name;
  }

  static String formatRTRW(
      {required String rtNum, required String rwNum, bool isNumOnly = true}) {
    String result =
        '${StringFormat.numFormatRTRW(rtNum)}/${StringFormat.numFormatRTRW(rwNum)}';
    if (!isNumOnly) {
      result = 'RT/RW $result';
    }
    return result;
  }

  static String formatDate(
      {required DateTime dateTime, bool isWithTime = true}) {
    String format = isWithTime ? 'd MMMM y HH:mm' : 'd MMMM y';
    String result = DateFormat(format, 'id_ID').format(dateTime);
    return result;
  }

  static String getRandString(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  static String ageNow({required DateTime bornDate}) {
    int umur = IntFormat.ageNow(bornDate: bornDate);
    return '$umur tahun';
  }

  static String kecamatanFormat({required String kecamatan}) {
    String result = '';
    if (kecamatan.toLowerCase().contains('kecamatan')) {
      result = 'Kec. ${kecamatan.substring(10)}';
    } else {
      result = 'Kec. $kecamatan';
    }
    return result;
  }

  static String kelurahanFormat({required String kelurahan}) {
    String result = '';
    if (kelurahan.toLowerCase().contains('kelurahan')) {
      result = 'Kel. ${kelurahan.substring(10)}';
    } else {
      result = 'Kel. $kelurahan';
    }
    return result;
  }
}
