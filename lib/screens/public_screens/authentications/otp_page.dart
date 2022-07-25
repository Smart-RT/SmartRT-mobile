import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/screens/public_screens/authentications/login_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPPageArguments {
  String namaLengkap;
  String jenisKelamin;
  String tanggalLahir;
  String noTelp;
  String kataSandi;

  OTPPageArguments(
      {required this.namaLengkap,
      required this.jenisKelamin,
      required this.tanggalLahir,
      required this.noTelp,
      required this.kataSandi});
}

class OTPPage extends StatefulWidget {
  static const String id = 'OTPPage';
  OTPPageArguments args;
  OTPPage({Key? key, required this.args}) : super(key: key);

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  String fbVerificationId = '';
  int? fbResendToken;
  final _formKey = GlobalKey<FormState>();
  final _OTPController = TextEditingController();

  @override
  void initState() {
    super.initState();
    verifiedPhoneNumber();
  }

  void verifiedPhoneNumber() async {
    var auth = FirebaseAuth.instance;
    String phoneNumber = '+62${widget.args.noTelp.substring(1)}';
    auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (authCredential) async {
          // sudah berhasil verifikasi
          // kalau terima SMS langsung ke verify otomatis
          UserCredential credential =
              await FirebaseAuth.instance.signInWithCredential(authCredential);

          try {
            var verifyDIO = await NetUtil().dioClient
                .post('/verifyUID/${credential.user!.uid}');
            // Pindah ke login...
          } on DioError catch (e) {
            if (e.response != null) {
              debugPrint(e.response!.data.toString());
            }
          }

          // Kita panggil backend untuk verifikasi UID di google dan set status aktif di db
        },
        verificationFailed: (FirebaseAuthException error) {
          debugPrint('[OTPPage] verifiedPhoneNumber => ${error}');
          if (error.code == 'invalid-phone-number') {
            return SmartRTSnackbar.show(context,
                message: 'Nomor Telepon tidak valid',
                backgroundColor: smartRTErrorColor);
          } else if (error.code == 'invalid-verification-code') {
            return SmartRTSnackbar.show(context,
                message: 'Kode OTP tidak valid',
                backgroundColor: smartRTErrorColor);
          } else if (error.code == 'quota-exceeded') {
            return SmartRTSnackbar.show(context,
                message: 'Kuota SMS OTP telah mencapai batas. Coba lagi nanti!',
                backgroundColor: smartRTErrorColor);
          } else if (error.code == 'account-exists-with-different-credential') {
            return SmartRTSnackbar.show(context,
                message: 'Nomor Telepon telah terdaftar',
                backgroundColor: smartRTErrorColor);
          } else {
            return SmartRTSnackbar.show(context,
                message: 'Ada sesuatu masalah. Coba lagi nanti!',
                backgroundColor: smartRTErrorColor);
          }
        },
        codeSent: (verficationId, resendToken) {
          //  ini kalau udah berhasil mintak OTP
          setState(() {
            fbVerificationId = verficationId;
            fbResendToken = resendToken;
          });
        },
        codeAutoRetrievalTimeout: (verificationId) {
          // Ini kalau udah mintak OTP tapi gagal terima OTP.
        });
  }

  void validateOtp(String verificationID, String otp) async {
    PhoneAuthCredential phoneCredential;
    try {
      phoneCredential = PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: otp);
      UserCredential credential =
          await FirebaseAuth.instance.signInWithCredential(phoneCredential);
      try {
        var verifyDIO =
            await NetUtil().dioClient.post('/verifyUID/${credential.user!.uid}');
        // Pindah ke login...
      } on DioError catch (e) {
        if (e.response != null) {
          debugPrint(e.response!.data.toString());
        }
      }
    } on FirebaseAuthException catch (e) {
      SmartRTSnackbar.show(context,
          message: 'PESAN', backgroundColor: smartRTErrorColor);
      if (e.code == 'invalid-phone-number') {
        return SmartRTSnackbar.show(context,
            message: 'Nomor Telepon tidak valid',
            backgroundColor: smartRTErrorColor);
      } else if (e.code == 'invalid-verification-code') {
        return SmartRTSnackbar.show(context,
            message: 'Kode OTP tidak valid',
            backgroundColor: smartRTErrorColor);
      } else if (e.code == 'quota-exceeded') {
        return SmartRTSnackbar.show(context,
            message: 'Kuota SMS OTP telah mencapai batas. Coba lagi nanti!',
            backgroundColor: smartRTErrorColor);
      } else if (e.code == 'account-exists-with-different-credential') {
        return SmartRTSnackbar.show(context,
            message: 'Nomor Telepon telah terdaftar',
            backgroundColor: smartRTErrorColor);
      } else {
        return SmartRTSnackbar.show(context,
            message: 'Ada sesuatu masalah. Coba lagi nanti!',
            backgroundColor: smartRTErrorColor);
      }
    }
  }

  void gotoLogin(context) {
    Navigator.pushReplacementNamed(context, LoginPage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: paddingScreen,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Container(
              height: MediaQuery.of(context).size.height - 50,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        child: Lottie.asset('assets/lotties/auth/otp.json',
                            fit: BoxFit.fitWidth),
                      ),
                      SB_height15,
                      Text(
                        '- VERIFIKASI -',
                        style: smartRTTitleText_Primary,
                        textAlign: TextAlign.center,
                      ),
                      RichText(
                        text: TextSpan(
                            text: "Masukkan kode yang telah dikirim ke nomor ",
                            children: [
                              TextSpan(
                                  text: widget.args.noTelp,
                                  style: smartRTTextNormalBold_Primary),
                            ],
                            style: smartRTTextNormal_Primary),
                        textAlign: TextAlign.center,
                      ),
                      SB_height15,
                      PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: smartRTTextLargeBold_Primary,
                        textStyle: smartRTTextLargeBold_Primary,
                        length: 6,
                        animationType: AnimationType.fade,
                        validator: (value) {},
                        pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            activeFillColor: smartRTSecondaryColor,
                            activeColor: smartRTPrimaryColor,
                            borderWidth: 2,
                            selectedColor: smartRTPrimaryColor,
                            selectedFillColor: smartRTSecondaryColor,
                            inactiveColor: smartRTPrimaryColor,
                            inactiveFillColor: smartRTSecondaryColor),
                        cursorColor: smartRTPrimaryColor,
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        // errorAnimationController: errorController,
                        controller: _OTPController,
                        keyboardType: TextInputType.number,
                        boxShadows: [
                          BoxShadow(
                            offset: Offset(0, 1),
                            color: smartRTShadowColor,
                            blurRadius: 10,
                          )
                        ],
                        onCompleted: (v) {
                          debugPrint("Completed");
                        },
                        // onTap: () {
                        //   print("Pressed");
                        // },
                        onChanged: (value) {
                          setState(() {
                            // currentText = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          debugPrint("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              debugPrint(
                                  '[MASUK TAP] => OTPCODE ${_OTPController.text}');
                              validateOtp(
                                  fbVerificationId, _OTPController.text);
                            }
                          },
                          child: Text(
                            'MASUK',
                            style: smartRTTextLargeBold_Secondary,
                          ),
                        ),
                      ),
                      SB_height15,
                      RichText(
                        text: TextSpan(
                          style: smartRTTextSmall_Primary,
                          children: [
                            const TextSpan(text: 'Tidak menerima kode? '),
                            TextSpan(
                              text: ' Kirim Ulang',
                              style: smartRTTextSmallBold_Primary,
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
