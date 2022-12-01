import 'package:flutter/material.dart';
import 'package:smart_rt/providers/application_provider.dart';
import 'package:smart_rt/screens/admin_screens/daftar_akun/buat_akun_admin_page.dart';
import 'package:smart_rt/screens/admin_screens/daftar_akun/daftar_akun_page.dart';
import 'package:smart_rt/screens/admin_screens/daftar_wilayah_surabaya/daftar_wilayah_surabaya_page.dart';
import 'package:smart_rt/screens/admin_screens/home/beranda_admin_page.dart';
import 'package:smart_rt/screens/admin_screens/request_role/list_request_role_page.dart';
import 'package:smart_rt/screens/guest_screens/daftar_ketua/daftar_ketua_form_page_1.dart';
import 'package:smart_rt/screens/guest_screens/daftar_ketua/daftar_ketua_form_page_2.dart';
import 'package:smart_rt/screens/guest_screens/daftar_ketua/daftar_ketua_form_page_3.dart';
import 'package:smart_rt/screens/guest_screens/daftar_ketua/daftar_ketua_page.dart';
import 'package:smart_rt/screens/guest_screens/daftar_ketua/pdf_screen.dart';
import 'package:smart_rt/screens/guest_screens/home/guest_home.dart';
import 'package:smart_rt/screens/public_screens/arisan/arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/detail_dan_informasi_arisan_page.dart';
import 'package:smart_rt/screens/public_screens/authentications/login_page.dart';
import 'package:smart_rt/screens/public_screens/authentications/otp_page.dart';
import 'package:smart_rt/screens/public_screens/authentications/register/register_page_1.dart';
import 'package:smart_rt/screens/public_screens/authentications/register/register_page_2.dart';
import 'package:smart_rt/screens/public_screens/authentications/welcome_page.dart';
import 'package:smart_rt/screens/public_screens/gabung_wilayah/gabung_wilayah_page.dart';
import 'package:smart_rt/screens/public_screens/janji_temu/buat_janji_temu_page.dart';
import 'package:smart_rt/screens/public_screens/janji_temu/list_janji_temu_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/detail_riwayat_bantuan_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/form_lapor_kesehatan_page_1.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/form_lapor_kesehatan_page_2.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/form_minta_bantuan_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/kesehatanku_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/riwayat_bantuan_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/riwayat_kesehatanku_page.dart';
import 'package:smart_rt/screens/public_screens/tanda_tangan_saya/tanda_tangan_saya_canvas_page.dart';
import 'package:smart_rt/screens/public_screens/tanda_tangan_saya/tanda_tangan_saya_page.dart';
import 'package:smart_rt/screens/public_screens/test_screen.dart';
import 'package:smart_rt/screens/public_screens/test_screen2.dart';
import 'package:smart_rt/screens/public_screens/ubah_profil/ubah_profil_page.dart';
import 'package:smart_rt/screens/public_screens/update_role/req_update_role_page.dart';

class Routes {
  static Route<dynamic> Function(RouteSettings) generateRoute =
      (RouteSettings settings) {
    switch (settings.name) {
      case WelcomePage.id:
        return MaterialPageRoute(builder: (context) {
          ApplicationProvider.context = context;
          return const WelcomePage();
        });
      case LoginPage.id:
        return MaterialPageRoute(builder: (context) {
          return const LoginPage();
        });
      case RegisterPage1.id:
        return MaterialPageRoute(builder: (context) {
          return const RegisterPage1();
        });
      case RegisterPage2.id:
        return MaterialPageRoute(builder: (context) {
          return RegisterPage2(
            args: settings.arguments as RegisterPage2Arguments,
          );
        });
      case OTPPage.id:
        return MaterialPageRoute(builder: (context) {
          return OTPPage(
            args: settings.arguments as OTPPageArguments,
          );
        });
      case GuestHome.id:
        return MaterialPageRoute(builder: (context) {
          ApplicationProvider.context = context;
          return const GuestHome();
        });
      case GabungWilayahPage.id:
        return MaterialPageRoute(builder: (context) {
          return const GabungWilayahPage();
        });
      case ReqUpdateRolePage.id:
        return MaterialPageRoute(builder: (context) {
          return const ReqUpdateRolePage();
        });
      case ListJanjiTemuPage.id:
        return MaterialPageRoute(builder: (context) {
          return const ListJanjiTemuPage();
        });
      case BuatJanjiTemuPage.id:
        return MaterialPageRoute(builder: (context) {
          return const BuatJanjiTemuPage();
        });
      case UbahProfilPage.id:
        return MaterialPageRoute(builder: (context) {
          return const UbahProfilPage();
        });
      case TandaTanganSayaCanvasPage.id:
        return MaterialPageRoute(builder: (context) {
          return const TandaTanganSayaCanvasPage();
        });
      case TandaTanganSayaPage.id:
        return MaterialPageRoute(builder: (context) {
          return const TandaTanganSayaPage();
        });
      case DaftarKetuaPage.id:
        return MaterialPageRoute(builder: (context) {
          return const DaftarKetuaPage();
        });
      case DaftarKetuaFormPage1.id:
        return MaterialPageRoute(builder: (context) {
          return const DaftarKetuaFormPage1();
        });
      case DaftarKetuaFormPage2.id:
        return MaterialPageRoute(builder: (context) {
          return DaftarKetuaFormPage2(
            args: settings.arguments as DaftarKetuaFormPage2Arguments,
          );
        });
      case DaftarKetuaFormPage3.id:
        return MaterialPageRoute(builder: (context) {
          return const DaftarKetuaFormPage3();
        });
      case KesehatankuPage.id:
        return MaterialPageRoute(builder: (context) {
          return const KesehatankuPage();
        });
      case RiwayatKesehatankuPage.id:
        return MaterialPageRoute(builder: (context) {
          return const RiwayatKesehatankuPage();
        });
      case RiwayatBantuanPage.id:
        return MaterialPageRoute(builder: (context) {
          return const RiwayatBantuanPage();
        });
      case DetailRiwayatBantuanPage.id:
        return MaterialPageRoute(builder: (context) {
          return const DetailRiwayatBantuanPage();
        });
      case FormLaporKesehatanPage1.id:
        return MaterialPageRoute(builder: (context) {
          return const FormLaporKesehatanPage1();
        });
      case FormLaporKesehatanPage2.id:
        return MaterialPageRoute(builder: (context) {
          return const FormLaporKesehatanPage2();
        });
      case FormMintaBantuanPage.id:
        return MaterialPageRoute(builder: (context) {
          return const FormMintaBantuanPage();
        });
      case ArisanPage.id:
        return MaterialPageRoute(builder: (context) {
          return const ArisanPage();
        });
      case DetailDanInformasiArisanPage.id:
        return MaterialPageRoute(builder: (context) {
          return const DetailDanInformasiArisanPage();
        });
      case BerandaAdminPage.id:
        return MaterialPageRoute(builder: (context) {
          ApplicationProvider.context = context;
          return const BerandaAdminPage();
        });
      case ListRequestRolePage.id:
        return MaterialPageRoute(builder: (context) {
          return const ListRequestRolePage();
        });
      case DaftarWilayahSurabayaPage.id:
        return MaterialPageRoute(builder: (context) {
          return const DaftarWilayahSurabayaPage();
        });
      case DaftarAkunPage.id:
        return MaterialPageRoute(builder: (context) {
          return const DaftarAkunPage();
        });
      case BuatAkunAdminPage.id:
        return MaterialPageRoute(builder: (context) {
          return const BuatAkunAdminPage();
        });
      case PDFScreen.id:
        return MaterialPageRoute(builder: (context) {
          return const PDFScreen();
        });
      case TestScreen.id:
        return MaterialPageRoute(builder: (context) {
          return const TestScreen();
        });
      case TestScreen2.id:
        return MaterialPageRoute(builder: (context) {
          return const TestScreen2();
        });
      default:
        assert(false, 'ROUTE NAME NOT FOUND');
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const Scaffold(
              body: Text('ROUTE NAME NOT FOUND'),
            );
          },
        );
    }
  };
}
