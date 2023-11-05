import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/screens/admin_screens/home/beranda_admin_page.dart';
import 'package:smart_rt/screens/public_screens/home/public_home.dart';
import 'package:smart_rt/screens/public_screens/authentications/register/register_page_1.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/widgets/dialogs/loading_dialog.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'LoginPage';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _noTelpController = TextEditingController();
  TextEditingController _kataSandiController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  void doLogin(BuildContext context) async {
    LoadingDialog.show(context);
    bool loginSuccess = await context.read<AuthProvider>().login(
        context: context,
        phone: _noTelpController.text,
        password: _kataSandiController.text);
    LoadingDialog.hide(context);

    if (loginSuccess) {
      User currentUser = AuthProvider.currentUser!;
      if (currentUser.user_role != Role.Admin) {
        // Navigator.pop(context);
        Navigator.pushReplacementNamed(context, PublicHome.id);
      } else if (currentUser.user_role == Role.Admin) {
        // Navigator.pop(context);
        Navigator.pushReplacementNamed(context, BerandaAdminPage.id);
      }
    }
  }

  void gotoRegister() {
    Navigator.pushNamed(context, RegisterPage1.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: smartRTPrimaryColor,
      body: Padding(
        padding: paddingScreen,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.asset('assets/img/logo/logo-white.png',
                    fit: BoxFit.fitWidth),
              ),
              SB_height15,
              TextFormField(
                controller: _noTelpController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor Telepon tidak boleh kosong';
                  }
                },
                style: smartRTTextLarge.copyWith(color: smartRTSecondaryColor),
                decoration: InputDecoration(
                  labelText: 'Nomor Telepon',
                  floatingLabelStyle:
                      smartRTTextLarge.copyWith(color: smartRTSecondaryColor),
                  labelStyle: smartRTTextLarge_Secondary,
                  enabledBorder: Theme.of(context)
                      .inputDecorationTheme
                      .enabledBorder!
                      .copyWith(
                        borderSide:
                            const BorderSide(color: smartRTSecondaryColor),
                      ),
                  focusedBorder: Theme.of(context)
                      .inputDecorationTheme
                      .focusedBorder!
                      .copyWith(
                        borderSide:
                            const BorderSide(color: smartRTSecondaryColor),
                      ),
                ),
              ),
              SB_height15,
              TextFormField(
                controller: _kataSandiController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kata Sandi tidak boleh kosong';
                  }
                },
                style: smartRTTextLarge.copyWith(color: smartRTSecondaryColor),
                obscureText: _isObscure,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: 'Kata Sandi',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                      color: smartRTSecondaryColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                  floatingLabelStyle:
                      smartRTTextLarge.copyWith(color: smartRTSecondaryColor),
                  labelStyle:
                      smartRTTextLarge.copyWith(color: smartRTSecondaryColor),
                  enabledBorder: Theme.of(context)
                      .inputDecorationTheme
                      .enabledBorder!
                      .copyWith(
                        borderSide:
                            const BorderSide(color: smartRTSecondaryColor),
                      ),
                  focusedBorder: Theme.of(context)
                      .inputDecorationTheme
                      .focusedBorder!
                      .copyWith(
                        borderSide: const BorderSide(
                          color: smartRTSecondaryColor,
                        ),
                      ),
                ),
              ),
              SB_height15,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      doLogin(context);
                    }
                  },
                  child: Text(
                    'MASUK',
                    style:
                        smartRTTextLarge.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SB_height15,
              RichText(
                text: TextSpan(
                  style:
                      smartRTTextSmall.copyWith(color: smartRTSecondaryColor),
                  children: [
                    const TextSpan(text: 'Tidak mempunyai akun? '),
                    TextSpan(
                      text: ' Daftar Sekarang',
                      style: smartRTTextSmall.copyWith(
                          color: smartRTActiveColor2,
                          fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          gotoRegister();
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/services.dart';
// import 'package:lottie/lottie.dart';
// import 'package:smart_rt/constants/colors.dart';
// import 'package:smart_rt/constants/config.dart';
// import 'package:smart_rt/constants/size.dart';
// import 'package:smart_rt/constants/style.dart';
// import 'package:smart_rt/models/user/user.dart';
// import 'package:smart_rt/providers/application_provider.dart';
// import 'package:smart_rt/providers/auth_provider.dart';
// import 'package:smart_rt/screens/admin_screens/home/beranda_admin_page.dart';
// import 'package:smart_rt/screens/public_screens/home/public_home.dart';
// import 'package:smart_rt/screens/public_screens/authentications/register/register_page_1.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:dio/dio.dart';
// import 'package:smart_rt/utilities/net_util.dart';
// import 'package:provider/provider.dart';
// import 'package:smart_rt/widgets/dialogs/loading_dialog.dart';

// class LoginPage extends StatefulWidget {
//   static const String id = 'LoginPage';
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   TextEditingController _noTelpController = TextEditingController();
//   TextEditingController _kataSandiController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _isObscure = true;

//   void doLogin(BuildContext context) async {
//     LoadingDialog.show(context);
//     bool loginSuccess = await context.read<AuthProvider>().login(
//         context: context,
//         phone: _noTelpController.text,
//         password: _kataSandiController.text);
//     LoadingDialog.hide(context);

//     if (loginSuccess) {
//       User currentUser = AuthProvider.currentUser!;
//       if (currentUser.user_role != Role.Admin) {
//         Navigator.pop(context);
//         Navigator.pushReplacementNamed(context, PublicHome.id);
//       } else if (currentUser.user_role == Role.Admin) {
//         Navigator.pop(context);
//         Navigator.pushReplacementNamed(context, BerandaAdminPage.id);
//       }
//     }
//   }

//   void gotoRegister() {
//     Navigator.pushReplacementNamed(context, RegisterPage1.id);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: smartRTPrimaryColor,
//       body: Container(
//         height: double.infinity,
//         padding: paddingScreen,
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Form(
//             key: _formKey,
//             child: Container(
//               height: MediaQuery.of(context).size.height - 50,
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Column(
//                     children: [
//                       Container(
//                         width: double.infinity,
//                         child: Lottie.asset(
//                             'assets/lotties/welcome/welcome-smile.json',
//                             fit: BoxFit.fitWidth),
//                       ),
//                       Text(
//                         '- SMART RT -',
//                         textAlign: TextAlign.center,
//                         style: smartRTTextTitle_Secondary,
//                       ),
//                     ],
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       SB_height15,
//                       TextFormField(
//                         controller: _noTelpController,
//                         keyboardType: TextInputType.number,
//                         inputFormatters: [
//                           FilteringTextInputFormatter.digitsOnly
//                         ],
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Nomor Telepon tidak boleh kosong';
//                           }
//                         },
//                         style: smartRTTextLarge_Secondary,
//                         decoration: InputDecoration(
//                           labelText: 'Nomor Telepon',
//                           floatingLabelStyle: Theme.of(context)
//                               .inputDecorationTheme
//                               .floatingLabelStyle!
//                               .copyWith(
//                                 color: smartRTSecondaryColor,
//                               ),
//                           labelStyle: smartRTTextLarge_Secondary,
//                           enabledBorder: Theme.of(context)
//                               .inputDecorationTheme
//                               .enabledBorder!
//                               .copyWith(
//                                 borderSide:
//                                     BorderSide(color: smartRTSecondaryColor),
//                               ),
//                           focusedBorder: Theme.of(context)
//                               .inputDecorationTheme
//                               .focusedBorder!
//                               .copyWith(
//                                 borderSide:
//                                     BorderSide(color: smartRTSecondaryColor),
//                               ),
//                         ),
//                       ),
//                       SB_height15,
//                       TextFormField(
//                         controller: _kataSandiController,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Kata Sandi tidak boleh kosong';
//                           }
//                         },
//                         style: smartRTTextLarge_Secondary,
//                         obscureText: _isObscure,
//                         enableSuggestions: false,
//                         autocorrect: false,
//                         decoration: InputDecoration(
//                           labelText: 'Kata Sandi',
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               _isObscure
//                                   ? Icons.visibility
//                                   : Icons.visibility_off,
//                               color: smartRTSecondaryColor,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 _isObscure = !_isObscure;
//                               });
//                             },
//                           ),
//                           floatingLabelStyle: Theme.of(context)
//                               .inputDecorationTheme
//                               .floatingLabelStyle!
//                               .copyWith(
//                                 color: smartRTSecondaryColor,
//                               ),
//                           labelStyle: smartRTTextLarge_Secondary,
//                           enabledBorder: Theme.of(context)
//                               .inputDecorationTheme
//                               .enabledBorder!
//                               .copyWith(
//                                 borderSide:
//                                     BorderSide(color: smartRTSecondaryColor),
//                               ),
//                           focusedBorder: Theme.of(context)
//                               .inputDecorationTheme
//                               .focusedBorder!
//                               .copyWith(
//                                 borderSide: BorderSide(
//                                   color: smartRTSecondaryColor,
//                                 ),
//                               ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Container(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           style: Theme.of(context)
//                               .elevatedButtonTheme
//                               .style!
//                               .copyWith(
//                                   backgroundColor: MaterialStateProperty.all(
//                                       smartRTSecondaryColor)),
//                           onPressed: () async {
//                             if (_formKey.currentState!.validate()) {
//                               doLogin(context);
//                             }
//                             // Dio dio = Dio(BaseOptions(baseUrl: backendURL));
//                             // Response<dynamic> response = await dio.get("/users");
//                             // debugPrint(response.toString());
//                             // Kalau Get, parameternya kan ada 2 tipe
//                             // 1. parameter
//                             // 2. Query Parameter
//                             // Parameter itu yang di /:nama_variabel, contoh users/1
//                             // Query parameter itu yang ? sama & contoh limit=1&ganteng=true
//                             // Query Parameter pake ini di dio queryParameters: {"limit": 1, "ganteng": true}
//                             // Kalau Post, put, dan Patch kan punya body
//                             // Cara lempar body pake attribut data di dio
//                             // await dio.post("/users",
//                             //     data: {
//                             //       "nama": "jose",
//                             //       "password": "gantengsekali9988"
//                             //     },
//                             //     options: Options(
//                             //         contentType:
//                             //             Headers.formUrlEncodedContentType));
//                           },
//                           child: Text(
//                             'MASUK',
//                             style: smartRTTextLargeBold_Primary,
//                           ),
//                         ),
//                       ),
//                       SB_height15,
//                       RichText(
//                         text: TextSpan(
//                           style: smartRTTextSmall_Secondary,
//                           children: [
//                             const TextSpan(text: 'Tidak mempunyai akun? '),
//                             TextSpan(
//                               text: ' Daftar Sekarang',
//                               style: smartRTTextSmallBold_Secondary,
//                               recognizer: TapGestureRecognizer()
//                                 ..onTap = () {
//                                   gotoRegister();
//                                 },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
