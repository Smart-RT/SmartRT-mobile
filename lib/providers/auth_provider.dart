import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/models/sub_district.dart';
import 'package:smart_rt/models/urban_village.dart';
import 'package:smart_rt/models/user_role_request.dart';
import 'package:smart_rt/providers/application_provider.dart';
import 'package:smart_rt/models/user.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';

class AuthProvider extends ApplicationProvider {
  static User? currentUser;
  static bool isLoggedIn = false;

  User? get user => currentUser;
  set user(User? value) {
    currentUser = value;
  }

  void saveUserDataToStorage() async {
    await ApplicationProvider.storage.write(key: 'jwt', value: user!.token);
    await ApplicationProvider.storage
        .write(key: 'refreshToken', value: user!.refresh_token);
    await ApplicationProvider.storage
        .write(key: 'user', value: jsonEncode(user!.toJson()));
  }

  Future<bool> login(
      {required BuildContext context,
      required String phone,
      required String password}) async {
    try {
      Response<dynamic> resp = await NetUtil()
          .dioClient
          .post("/users/login", data: {"noTelp": phone, "kataSandi": password});
      User user = User.fromData(resp.data);
      ApplicationProvider.currentUserJWT = user.token;
      ApplicationProvider.currentUserRefreshToken = user.refresh_token;
      currentUser = user;
      saveUserDataToStorage();
      debugPrint(
          'IDnya: ${user.id}, Namanya: ${user.full_name} berjenis kelamin : ${user.gender}');
      return true;
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
        SmartRTSnackbar.show(context,
            message: e.response!.data.toString(),
            backgroundColor: smartRTErrorColor);
      }
      return false;
    }
  }

  Future<bool> updateProfile(
      {required BuildContext context,
      required String fullName,
      required String gender,
      required DateTime bornDate,
      required String address}) async {
    try {
      Response<dynamic> resp = await NetUtil()
          .dioClient
          .patch('/users/updateProfile/${currentUser!.id}', data: {
        "full_name": fullName,
        "gender": gender,
        "born_date": bornDate,
        "address": address
      });
      currentUser!.full_name = fullName;
      currentUser!.gender = gender;
      currentUser!.born_date = bornDate;
      currentUser!.address = address;
      notifyListeners();
      saveUserDataToStorage();
      return true;
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
        SmartRTSnackbar.show(context,
            message: e.response!.data.toString(),
            backgroundColor: smartRTErrorColor);
      }
      return false;
    }
  }

  Future<void> logout() async {
    AuthProvider.currentUser = null;
    AuthProvider.isLoggedIn = false;
    ApplicationProvider.currentUserJWT = '';
    ApplicationProvider.currentUserRefreshToken = '';
    await ApplicationProvider.storage.delete(key: 'jwt');
    await ApplicationProvider.storage.delete(key: 'refreshToken');
    await ApplicationProvider.storage.delete(key: 'user');
  }

  Future<bool> uploadProfilePicture({
    required BuildContext context,
    required CroppedFile file,
  }) async {
    try {
      MultipartFile multipart = await MultipartFile.fromFile(file.path,
          filename: file.path.split('/').last,
          contentType:
              MediaType('image', file.path.split('/').last.split('.').last));
      var formData = FormData.fromMap({"profilePicture": multipart});

      Response<dynamic> resp = await NetUtil().dioClient.patch(
          "/users/uploadProfilePicture/${currentUser!.id}",
          data: formData);
      currentUser!.photo_profile_img = resp.data;
      notifyListeners();
      saveUserDataToStorage();
      return true;
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
        SmartRTSnackbar.show(context,
            message: e.response!.data.toString(),
            backgroundColor: smartRTErrorColor);
      }
      return false;
    }
  }

  Future<bool> daftarReqKetuaRT({
    required BuildContext context,
    required CroppedFile ktp,
    required CroppedFile ktpSelfie,
    required FilePickerResult fileLampiran,
    required String namaLengkap,
    required String alamat,
    required String sub_district_id,
    required String urban_village_id,
    required String rt_num,
    required String rw_num,
  }) async {
    try {
      MultipartFile multipartKTP = await MultipartFile.fromFile(ktp.path,
          filename: ktp.path.split('/').last,
          contentType:
              MediaType('image', ktp.path.split('/').last.split('.').last));

      MultipartFile multipartKTPSelfie = await MultipartFile.fromFile(
          ktpSelfie.path,
          filename: ktpSelfie.path.split('/').last,
          contentType: MediaType(
              'image', ktpSelfie.path.split('/').last.split('.').last));

      MultipartFile multipartFileLampiran = await MultipartFile.fromFile(
          fileLampiran.files.first.path!,
          filename: fileLampiran.files.first.path!.split('/').last,
          contentType: MediaType('application', 'pdf'));

      var formData = FormData.fromMap({
        "ktp": multipartKTP,
        "ktpSelfie": multipartKTPSelfie,
        "fileLampiran": multipartFileLampiran,
        "namaLengkap": namaLengkap,
        "address": alamat,
        "sub_district_id": sub_district_id,
        "urban_village_id": urban_village_id,
        "rt_num": rt_num,
        "rw_num": rw_num,
        "request_role": 7,
      });

      Response<dynamic> resp =
          await NetUtil().dioClient.post('/users/reqUserRole', data: formData);

      currentUser!.user_role_requests
          .insert(0, UserRoleRequests.fromData(resp.data));
      currentUser!.full_name = namaLengkap;
      currentUser!.address = alamat;

      notifyListeners();
      saveUserDataToStorage();
      return true;
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
        SmartRTSnackbar.show(context,
            message: e.response!.data.toString(),
            backgroundColor: smartRTErrorColor);
      }
      return false;
    }
  }

  Future<bool> reqGabungWilayah({
    required BuildContext context,
    required String request_code,
  }) async {
    try {
      Response<dynamic> resp =
          await NetUtil().dioClient.post('/users/reqUserRole', data: {
        "request_role": 3,
        "request_code": request_code,
      });
      currentUser!.user_role_requests
          .insert(0, UserRoleRequests.fromData(resp.data));
      notifyListeners();
      saveUserDataToStorage();
      return true;
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
        SmartRTSnackbar.show(context,
            message: e.response!.data.toString(),
            backgroundColor: smartRTErrorColor);
      }
      return false;
    }
  }

  Future<bool> updateUserRoleRequest({
    required BuildContext context,
    required int user_role_requests_id,
    required bool isAccepted,
  }) async {
    try {
      Response<dynamic> resp = await NetUtil()
          .dioClient
          .patch('/users/updateUserRoleRequest', data: {
        "user_role_requests_id": user_role_requests_id,
        "isAccepted": isAccepted,
      });
      // resp.data['sub_district_id'] = SubDistricts.fromData(resp.data['sub_district_id']);
      // resp.data['urban_village_id'] = UrbanVillages.fromData(resp.data['urban_village_id']);
      currentUser!.user_role_requests[0] = UserRoleRequests.fromData(resp.data);
      notifyListeners();
      saveUserDataToStorage();
      return true;
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
        SmartRTSnackbar.show(context,
            message: e.response!.data.toString(),
            backgroundColor: smartRTErrorColor);
      }
      return false;
    }
  }

  Future<bool> uploadSignatureImage({
    required BuildContext context,
    required Uint8List file,
  }) async {
    try {
      MultipartFile multipart = await MultipartFile.fromBytes(file,
          filename: 'Signature.png', contentType: MediaType('image', 'png'));
      var formData = FormData.fromMap({"signatureImage": multipart});

      Response<dynamic> resp = await NetUtil().dioClient.patch(
          "/users/uploadSignatureImage/${currentUser!.id}",
          data: formData);

      currentUser!.sign_img = resp.data;
      notifyListeners();
      saveUserDataToStorage();
      return true;
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
        SmartRTSnackbar.show(context,
            message: e.response!.data.toString(),
            backgroundColor: smartRTErrorColor);
      }
      return false;
    }
  }
}
