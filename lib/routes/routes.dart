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
import 'package:smart_rt/screens/public_screens/arisan/absen_anggota_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/create_periode_arisan/create_periode_arisan_page_1.dart';
import 'package:smart_rt/screens/public_screens/arisan/create_periode_arisan/create_periode_arisan_page_2.dart';
import 'package:smart_rt/screens/public_screens/arisan/create_periode_arisan/create_periode_arisan_page_0.dart';
import 'package:smart_rt/screens/public_screens/arisan/create_pertemuan_arisan/create_pertemuan_selanjutnya_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/daftar_arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/detail_dan_informasi_arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/detail_iuran_arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/list_anggota_arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/pembayaran_iuran_arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/pembayaran_iuran_arisan_page_2.dart';
import 'package:smart_rt/screens/public_screens/arisan/pengaturan_arisan/pengaturan_arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/peraturan_dan_tata_cara_arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan_saya/detail_pertemuan_sebelumnya_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan_saya/detail_pertemuan_selanjutnya_page.dart';
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
import 'package:smart_rt/screens/public_screens/kesehatan/detail_riwayat_kesehatan_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/form_lapor_kesehatan_choose_user_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/form_lapor_kesehatan_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/form_minta_bantuan_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/kesehatanku_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/laporan_warga_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/riwayat_bantuan_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/riwayat_kesehatan_page.dart';
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

      // === KESEHATAN
      case FormLaporKesehatanPage.id:
        return MaterialPageRoute(builder: (context) {
          return FormLaporKesehatanPage(
              args: settings.arguments as FormLaporKesehatanPageArguments);
        });
      case FormLaporKesehatanChooseUserPage.id:
        return MaterialPageRoute(builder: (context) {
          return const FormLaporKesehatanChooseUserPage();
        });
      case KesehatankuPage.id:
        return MaterialPageRoute(builder: (context) {
          return const KesehatankuPage();
        });
      case RiwayatKesehatanPage.id:
        return MaterialPageRoute(builder: (context) {
          return RiwayatKesehatanPage(
              args: settings.arguments as RiwayatKesehatanArguments);
        });
      case RiwayatBantuanPage.id:
        return MaterialPageRoute(builder: (context) {
          return RiwayatBantuanPage(
            args: settings.arguments as RiwayatBantuanArguments,
          );
        });
      case DetailRiwayatBantuanPage.id:
        return MaterialPageRoute(builder: (context) {
          return DetailRiwayatBantuanPage(
              args: settings.arguments as DetailRiwayatBantuanPageArguments);
        });
      case FormMintaBantuanPage.id:
        return MaterialPageRoute(builder: (context) {
          return const FormMintaBantuanPage();
        });
      case DetailRiwayatKesehatanPage.id:
        return MaterialPageRoute(builder: (context) {
          return DetailRiwayatKesehatanPage(
            args: settings.arguments as DetailRiwayatKesehatanArguments,
          );
        });
      case LaporanWargaPage.id:
        return MaterialPageRoute(builder: (context) {
          return const LaporanWargaPage();
        });

      // === ARISAN
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
          return CreatePeriodeArisanPage2(
            args: settings.arguments as CreatePeriodeArisanPage2Arguments,
          );
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
          return DetailRiwayatArisanWilayah(
            args: settings.arguments as DetailRiwayatArisanWilayahArguments,
          );
        });
      case LihatSemuaPertemuanPage.id:
        return MaterialPageRoute(builder: (context) {
          return LihatSemuaPertemuanPage(
            args: settings.arguments as LihatSemuaPertemuanPageArguments,
          );
        });
      case LihatSemuaAnggotaArisanPage.id:
        return MaterialPageRoute(builder: (context) {
          return LihatSemuaAnggotaArisanPage(
            args: settings.arguments as LihatSemuaAnggotaArisanPageArguments,
          );
        });
      case DetailPertemuanArisanPage.id:
        return MaterialPageRoute(builder: (context) {
          return DetailPertemuanArisanPage(
            args: settings.arguments as DetailPertemuanArisanPageArguments,
          );
        });
      case LihatAbsensiPertemuanArisanPage.id:
        return MaterialPageRoute(builder: (context) {
          return const LihatAbsensiPertemuanArisanPage();
        });
      case LihatIuranArisanPertemuanPage.id:
        return MaterialPageRoute(builder: (context) {
          return LihatIuranArisanPertemuanPage(
            args: settings.arguments as LihatIuranArisanPageArguments,
          );
        });
      case PembayaranIuranArisan.id:
        return MaterialPageRoute(builder: (context) {
          return PembayaranIuranArisan(
              args: settings.arguments as PembayaranIuranArisanArguments);
        });
      case DetailPertemuanSelanjutnyaPage.id:
        return MaterialPageRoute(builder: (context) {
          return const DetailPertemuanSelanjutnyaPage();
        });
      case DetailPertemuanSebelumnyaPage.id:
        return MaterialPageRoute(builder: (context) {
          return const DetailPertemuanSebelumnyaPage();
        });
      case CreatePertemuanSelanjutnyaPage.id:
        return MaterialPageRoute(builder: (context) {
          return const CreatePertemuanSelanjutnyaPage();
        });
      case AbsenAnggotaPage.id:
        return MaterialPageRoute(builder: (context) {
          return AbsenAnggotaPage(
            args: settings.arguments as AbsenAnggotaPageArguments,
          );
        });
      case PembayaranIuranArisanPage2.id:
        return MaterialPageRoute(builder: (context) {
          return PembayaranIuranArisanPage2(
              args: settings.arguments as PembayaranIuranArisanPage2Arguments);
        });
      case DetailIuranArisanPage.id:
        return MaterialPageRoute(builder: (context) {
          return DetailIuranArisanPage(
              args: settings.arguments as DetailIuranArisanArguments);
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
