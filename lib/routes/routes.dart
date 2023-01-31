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
import 'package:smart_rt/screens/public_screens/arisan/create_periode_arisan/create_periode_arisan_page_1.dart';
import 'package:smart_rt/screens/public_screens/arisan/create_periode_arisan/create_periode_arisan_page_2.dart';
import 'package:smart_rt/screens/public_screens/arisan/create_periode_arisan/create_periode_arisan_page_0.dart';
import 'package:smart_rt/screens/public_screens/arisan/daftar_arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/detail_dan_informasi_arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/list_anggota_arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/pengaturan_arisan/pengaturan_arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/peraturan_dan_tata_cara_arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan_saya/detail_riwayat_arisan_saya_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan_saya/riwayat_arisan_saya_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan_wilayah/detail_riwayat_arisan_wilayah_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan_wilayah/lihat_semua_anggota_periode_arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan_wilayah/lihat_absensi_pertemuan_arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan_wilayah/lihat_iuran_arisan_pertemuan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan_wilayah/detail_pertemuan_arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan_wilayah/lihat_semua_pertemuan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan_wilayah/riwayat_arisan_wilayah_page.dart';
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
          return DaftarKetuaFormPage3(
            args: settings.arguments as DaftarKetuaFormPage3Arguments,
          );
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

      // ARISAN
      case ArisanPage.id:
        return MaterialPageRoute(builder: (context) {
          return const ArisanPage();
        });
      case DetailDanInformasiArisanPage.id:
        return MaterialPageRoute(builder: (context) {
          return const DetailDanInformasiArisanPage();
        });
      case DaftarArisanPage.id:
        return MaterialPageRoute(builder: (context) {
          return const DaftarArisanPage();
        });
      case PeraturanDanTataCaraArisanPage.id:
        return MaterialPageRoute(builder: (context) {
          return const PeraturanDanTataCaraArisanPage();
        });
      case ListAnggotaArisanPage.id:
        return MaterialPageRoute(builder: (context) {
          return const ListAnggotaArisanPage();
        });
      case CreatePeriodeArisanPage0.id:
        return MaterialPageRoute(builder: (context) {
          return const CreatePeriodeArisanPage0();
        });
      case CreatePeriodeArisanPage1.id:
        return MaterialPageRoute(builder: (context) {
          return const CreatePeriodeArisanPage1();
        });
      case CreatePeriodeArisanPage2.id:
        return MaterialPageRoute(builder: (context) {
          return const CreatePeriodeArisanPage2();
        });
      case RiwayatArisanSayaPage.id:
        return MaterialPageRoute(builder: (context) {
          return const RiwayatArisanSayaPage();
        });
      case DetailRiwayatArisanSayaPage.id:
        return MaterialPageRoute(builder: (context) {
          return const DetailRiwayatArisanSayaPage();
        });
      case PengaturanArisanPage.id:
        return MaterialPageRoute(builder: (context) {
          return const PengaturanArisanPage();
        });
      case RiwayatArisanWilayahPage.id:
        return MaterialPageRoute(builder: (context) {
          return const RiwayatArisanWilayahPage();
        });
      case DetailRiwayatArisanWilayah.id:
        return MaterialPageRoute(builder: (context) {
          return const DetailRiwayatArisanWilayah();
        });
      case LihatSemuaPertemuanPage.id:
        return MaterialPageRoute(builder: (context) {
          return const LihatSemuaPertemuanPage();
        });
      case LihatSemuaAnggotaArisanPage.id:
        return MaterialPageRoute(builder: (context) {
          return const LihatSemuaAnggotaArisanPage();
        });
      case DetailPertemuanArisanPage.id:
        return MaterialPageRoute(builder: (context) {
          return const DetailPertemuanArisanPage();
        });
      case LihatAbsensiPertemuanArisanPage.id:
        return MaterialPageRoute(builder: (context) {
          return const LihatAbsensiPertemuanArisanPage();
        });
      case LihatIuranArisanPertemuanPage.id:
        return MaterialPageRoute(builder: (context) {
          return const LihatIuranArisanPertemuanPage();
        });
      // ---

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
