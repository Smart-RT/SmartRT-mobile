import 'package:flutter/material.dart';
import 'package:smart_rt/providers/application_provider.dart';

import 'package:smart_rt/screens/admin_screens/daftar_akun/buat_akun_admin_page.dart';
import 'package:smart_rt/screens/admin_screens/daftar_akun/daftar_akun_page.dart';
import 'package:smart_rt/screens/admin_screens/daftar_wilayah_surabaya/daftar_wilayah_surabaya_page.dart';
import 'package:smart_rt/screens/admin_screens/home/beranda_admin_page.dart';
import 'package:smart_rt/screens/admin_screens/request_role/list_request_role_page.dart';
import 'package:smart_rt/screens/public_screens/acara/tugas/form_tugas/form_tugas_page.dart';
import 'package:smart_rt/screens/public_screens/acara/tugas/petugas/beri_tugas_warga_page.dart';
import 'package:smart_rt/screens/public_screens/acara/tugas/petugas/konfirmasi_petugas_page.dart';
import 'package:smart_rt/screens/public_screens/acara/tugas/petugas/lihat_petugas_page_rating.dart';
import 'package:smart_rt/screens/public_screens/acara/tugas/tugas_page_detail.dart';

import 'package:smart_rt/screens/public_screens/daftar_ketua/daftar_ketua_form_page_1.dart';
import 'package:smart_rt/screens/public_screens/daftar_ketua/daftar_ketua_form_page_2.dart';
import 'package:smart_rt/screens/public_screens/daftar_ketua/daftar_ketua_form_page_3.dart';
import 'package:smart_rt/screens/public_screens/daftar_ketua/daftar_ketua_page.dart';
import 'package:smart_rt/screens/pdf_screen/pdf_screen.dart';

import 'package:smart_rt/screens/public_screens/home/public_home.dart';
import 'package:smart_rt/screens/public_screens/administration/administration_detail_page.dart';
import 'package:smart_rt/screens/public_screens/administration/create/administration_create_page_4.dart';

import 'package:smart_rt/screens/public_screens/arisan/arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/absensi_pertemuan_arisan/absensi_pertemuan_arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/create_periode_arisan/create_periode_arisan_page_1.dart';
import 'package:smart_rt/screens/public_screens/arisan/create_periode_arisan/create_periode_arisan_page_2.dart';
import 'package:smart_rt/screens/public_screens/arisan/create_pertemuan_arisan/create_pertemuan_selanjutnya_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/create_arisan/create_arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/list_iuran_pertemuan_dan_detail/list_iuran_pertemuan_detail_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/pembayaran_arisan/pembayaran_iuran_arisan_page_1.dart';
import 'package:smart_rt/screens/public_screens/arisan/pembayaran_arisan/pembayaran_iuran_arisan_page_2.dart';
import 'package:smart_rt/screens/public_screens/arisan/pengaturan_arisan/pengaturan_arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/peraturan_dan_tata_cara/peraturan_dan_tata_cara_arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan/riwayat_arisan_periode_detail_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/anggota_periode/anggota_periode_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/list_iuran_pertemuan_dan_detail/list_iuran_pertemuan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan/riwayat_arisan_pertemuan_detail_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan/riwayat_arisan_pertemuan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan/riwayat_arisan_periode_page.dart';

import 'package:smart_rt/screens/public_screens/authentications/login_page.dart';
import 'package:smart_rt/screens/public_screens/authentications/otp_page.dart';
import 'package:smart_rt/screens/public_screens/authentications/register/register_page_1.dart';
import 'package:smart_rt/screens/public_screens/authentications/register/register_page_2.dart';
import 'package:smart_rt/screens/public_screens/authentications/welcome_page.dart';

import 'package:smart_rt/screens/public_screens/gabung_wilayah/detail_konfirmasi_gabung_wilayah_page.dart';
import 'package:smart_rt/screens/public_screens/gabung_wilayah/gabung_wilayah_page.dart';
import 'package:smart_rt/screens/public_screens/gabung_wilayah/konfirmasi_gabung_wilayah_page.dart';

import 'package:smart_rt/screens/public_screens/image_view/image_view_page.dart';

import 'package:smart_rt/screens/public_screens/janji_temu/buat_janji_temu_page.dart';
import 'package:smart_rt/screens/public_screens/janji_temu/list_janji_temu_detail_page.dart';
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
import 'package:smart_rt/screens/public_screens/neighbourhood_head/lihat_semua_kandidat/lihat_semua_kandidat_page.dart';
import 'package:smart_rt/screens/public_screens/neighbourhood_head/lihat_semua_kandidat/lihat_semua_kandidat_page_detail.dart';
import 'package:smart_rt/screens/public_screens/neighbourhood_head/lihat_status_kandidat_calon_pengurus_rt_saya_page.dart';
import 'package:smart_rt/screens/public_screens/neighbourhood_head/rekomendasikan_kandidat_page.dart';

import 'package:smart_rt/screens/public_screens/pengumuman/create_pengumuman/create_pengumuman_page_1.dart';
import 'package:smart_rt/screens/public_screens/pengumuman/create_pengumuman/create_pengumuman_page_2.dart';
import 'package:smart_rt/screens/public_screens/pengumuman/pengumuman_detail_page.dart';

import 'package:smart_rt/screens/public_screens/tanda_tangan_saya/tanda_tangan_saya_canvas_page.dart';
import 'package:smart_rt/screens/public_screens/tanda_tangan_saya/tanda_tangan_saya_page.dart';
import 'package:smart_rt/screens/public_screens/test_screen.dart';
import 'package:smart_rt/screens/public_screens/test_screen2.dart';
import 'package:smart_rt/screens/public_screens/ubah_profil/ubah_profil_page.dart';
import 'package:smart_rt/screens/public_screens/update_role/req_update_role_page.dart';

import 'package:smart_rt/screens/public_screens/administration/administration_page.dart';
import 'package:smart_rt/screens/public_screens/administration/create/administration_create_page_1.dart';
import 'package:smart_rt/screens/public_screens/administration/create/administration_create_page_2.dart';
import 'package:smart_rt/screens/public_screens/administration/create/administration_create_page_3.dart';
import 'package:smart_rt/screens/public_screens/administration/create/administration_create_page_5.dart';
import 'package:smart_rt/screens/public_screens/administration/create/administration_create_page_2_sk_kelahiran.dart';
import 'package:smart_rt/screens/public_screens/administration/create/administration_create_page_3_sk_kelahiran.dart';
import 'package:smart_rt/screens/public_screens/administration/create/administration_create_page_4_sk_kelahiran.dart';

import 'package:smart_rt/screens/public_screens/acara/acara_page.dart';
import 'package:smart_rt/screens/public_screens/acara/acara_page_detail.dart';
import 'package:smart_rt/screens/public_screens/acara/form_acara/form_acara_page.dart';
import 'package:smart_rt/screens/public_screens/acara/tugas/petugas/lihat_petugas_page.dart';

import 'package:smart_rt/screens/public_screens/committe/lihat_status_kepanitiaan_saya_page.dart';
import 'package:smart_rt/screens/public_screens/committe/rekomendasikan_panitia_page.dart';
import 'package:smart_rt/screens/public_screens/committe/lihat_panitia/lihat_panitia_page.dart';
import 'package:smart_rt/screens/public_screens/committe/lihat_panitia/lihat_panitia_page_detail.dart';

import 'package:smart_rt/screens/public_screens/voting/voting_page_1.dart';

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
      case PublicHome.id:
        return MaterialPageRoute(builder: (context) {
          ApplicationProvider.context = context;
          return const PublicHome();
        });
      case GabungWilayahPage.id:
        return MaterialPageRoute(builder: (context) {
          return const GabungWilayahPage();
        });
      case ReqUpdateRolePage.id:
        return MaterialPageRoute(builder: (context) {
          return const ReqUpdateRolePage();
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

      // === ADMINISTRASI
      case AdministrationPage.id:
        return MaterialPageRoute(builder: (context) {
          return const AdministrationPage();
        });
      case AdministrationCreatePage1.id:
        return MaterialPageRoute(builder: (context) {
          return const AdministrationCreatePage1();
        });
      case AdministrationCreatePage2.id:
        return MaterialPageRoute(builder: (context) {
          return AdministrationCreatePage2(
            args: settings.arguments as AdministrationCreatePage2Argument,
          );
        });
      case AdministrationCreatePage2SKKelahiran.id:
        return MaterialPageRoute(builder: (context) {
          return AdministrationCreatePage2SKKelahiran(
            args: settings.arguments
                as AdministrationCreatePage2SKKelahiranArgument,
          );
        });
      case AdministrationCreatePage3SKKelahiran.id:
        return MaterialPageRoute(builder: (context) {
          return AdministrationCreatePage3SKKelahiran(
            args: settings.arguments
                as AdministrationCreatePage3SKKelahiranArgument,
          );
        });
      case AdministrationCreatePage4SKKelahiran.id:
        return MaterialPageRoute(builder: (context) {
          return AdministrationCreatePage4SKKelahiran(
            args: settings.arguments
                as AdministrationCreatePage4SKKelahiranArgument,
          );
        });
      case AdministrationCreatePage3.id:
        return MaterialPageRoute(builder: (context) {
          return AdministrationCreatePage3(
            args: settings.arguments as AdministrationCreatePage3Argument,
          );
        });
      case AdministrationCreatePage4.id:
        return MaterialPageRoute(builder: (context) {
          return AdministrationCreatePage4(
            args: settings.arguments as AdministrationCreatePage4Argument,
          );
        });
      case AdministrationCreatePage5.id:
        return MaterialPageRoute(builder: (context) {
          return AdministrationCreatePage5(
            args: settings.arguments as AdministrationCreatePage5Argument,
          );
        });
      case AdministrationDetailPage.id:
        return MaterialPageRoute(builder: (context) {
          return AdministrationDetailPage(
            args: settings.arguments as AdministrationDetailPageArgument,
          );
        });
      // === END

      // === JANJI TEMU
      case ListJanjiTemuPage.id:
        return MaterialPageRoute(builder: (context) {
          return const ListJanjiTemuPage();
        });
      case BuatJanjiTemuPage.id:
        return MaterialPageRoute(builder: (context) {
          return const BuatJanjiTemuPage();
        });
      case ListJanjiTemuDetailPage.id:
        return MaterialPageRoute(builder: (context) {
          return ListJanjiTemuDetailPage(
            args: settings.arguments as ListJanjiTemuDetailPageArgument,
          );
        });
      // === END

      // === PENGUMUMAN
      case CreatePengumumanPage1.id:
        return MaterialPageRoute(builder: (context) {
          return const CreatePengumumanPage1();
        });
      case CreatePengumumanPage2.id:
        return MaterialPageRoute(builder: (context) {
          return CreatePengumumanPage2(
            args: settings.arguments as CreatePengumumanPage2Argument,
          );
        });
      case PengumumanDetailPage.id:
        return MaterialPageRoute(builder: (context) {
          return PengumumanDetailPage(
            args: settings.arguments as PengumumanDetailPageArgument,
          );
        });
      // === END

      // === IMAGE VIEW
      case ImageViewPage.id:
        return MaterialPageRoute(builder: (context) {
          return ImageViewPage(
            args: settings.arguments as ImageViewPageArgument,
          );
        });
      // === END

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

      // === USER ROLE REQ
      case KonfirmasiGabungWilayahPage.id:
        return MaterialPageRoute(builder: (context) {
          return const KonfirmasiGabungWilayahPage();
        });
      case DetailKonfirmasiGabungWilayahPage.id:
        return MaterialPageRoute(builder: (context) {
          return DetailKonfirmasiGabungWilayahPage(
            args: settings.arguments as DetailKonfirmasiGabungWilayahArguments,
          );
        });
      // === END

      // === ARISAN
      case ArisanPage.id:
        return MaterialPageRoute(builder: (context) {
          return const ArisanPage();
        });
      case CreateArisanPage.id:
        return MaterialPageRoute(builder: (context) {
          return const CreateArisanPage();
        });
      case PeraturanDanTataCaraArisanPage.id:
        return MaterialPageRoute(builder: (context) {
          return const PeraturanDanTataCaraArisanPage();
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
      case PengaturanArisanPage.id:
        return MaterialPageRoute(builder: (context) {
          return const PengaturanArisanPage();
        });
      case RiwayatArisanPeriodePage.id:
        return MaterialPageRoute(builder: (context) {
          return RiwayatArisanPeriodePage(
            args: settings.arguments as RiwayatArisanPeriodeArguments,
          );
        });
      case RiwayatArisanPeriodeDetailPage.id:
        return MaterialPageRoute(builder: (context) {
          return RiwayatArisanPeriodeDetailPage(
            args: settings.arguments as RiwayatArisanPeriodeDetailArguments,
          );
        });
      case RiwayatArisanPertemuanPage.id:
        return MaterialPageRoute(builder: (context) {
          return RiwayatArisanPertemuanPage(
            args: settings.arguments as RiwayatArisanPertemuanArguments,
          );
        });
      case AnggotaPeriodePage.id:
        return MaterialPageRoute(builder: (context) {
          return AnggotaPeriodePage(
            args: settings.arguments as AnggotaPeriodeArgument,
          );
        });
      case RiwayatArisanPertemuanDetailPage.id:
        return MaterialPageRoute(builder: (context) {
          return RiwayatArisanPertemuanDetailPage(
            args: settings.arguments as RiwayatArisanPertemuanDetailArguments,
          );
        });
      case ListIuranPertemuanPage.id:
        return MaterialPageRoute(builder: (context) {
          return ListIuranPertemuanPage(
            args: settings.arguments as ListIuranPertemuanArgument,
          );
        });
      case PembayaranIuranArisanPage1.id:
        return MaterialPageRoute(builder: (context) {
          return PembayaranIuranArisanPage1(
              args: settings.arguments as PembayaranIuranArisanPage1Arguments);
        });
      case CreatePertemuanSelanjutnyaPage.id:
        return MaterialPageRoute(builder: (context) {
          return const CreatePertemuanSelanjutnyaPage();
        });
      case AbsensiPertemuanArisanPage.id:
        return MaterialPageRoute(builder: (context) {
          return AbsensiPertemuanArisanPage(
            args: settings.arguments as AbsensiPertemuanArisanArgument,
          );
        });
      case PembayaranIuranArisanPage2.id:
        return MaterialPageRoute(builder: (context) {
          return PembayaranIuranArisanPage2(
              args: settings.arguments as PembayaranIuranArisanPage2Arguments);
        });
      case ListIuranPertemuanDetailPage.id:
        return MaterialPageRoute(builder: (context) {
          return ListIuranPertemuanDetailPage(
              args: settings.arguments as ListIuranPertemuanDetailArgument);
        });

      // === END

      // === ACARA
      case AcaraPage.id:
        return MaterialPageRoute(builder: (context) {
          return const AcaraPage();
        });
      case FormAcaraPage.id:
        return MaterialPageRoute(builder: (context) {
          return FormAcaraPage(
            args: settings.arguments as FormAcaraPageArgument,
          );
        });
      case AcaraPageDetail.id:
        return MaterialPageRoute(builder: (context) {
          return AcaraPageDetail(
            args: settings.arguments as AcaraPageDetailArgument,
          );
        });
      case FormTugasPage.id:
        return MaterialPageRoute(builder: (context) {
          return FormTugasPage(
            args: settings.arguments as FormTugasPageArgument,
          );
        });
      case TugasPageDetail.id:
        return MaterialPageRoute(builder: (context) {
          return TugasPageDetail(
            args: settings.arguments as TugasPageDetailArgument,
          );
        });
      case LihatPetugasPage.id:
        return MaterialPageRoute(builder: (context) {
          return LihatPetugasPage(
            args: settings.arguments as LihatPetugasPageArgument,
          );
        });
      case BeriTugasWargaPage.id:
        return MaterialPageRoute(builder: (context) {
          return BeriTugasWargaPage(
            args: settings.arguments as BeriTugasWargaPageArgument,
          );
        });
      case LihatPetugasPageRating.id:
        return MaterialPageRoute(builder: (context) {
          return LihatPetugasPageRating(
            args: settings.arguments as LihatPetugasPageRatingArgument,
          );
        });
      case KonfirmasiPetugasPage.id:
        return MaterialPageRoute(builder: (context) {
          return KonfirmasiPetugasPage(
            args: settings.arguments as KonfirmasiPetugasPageArgument,
          );
        });
      // === END

      // === PANITIA
      case LihatStatusKepanitiaanSayaPage.id:
        return MaterialPageRoute(builder: (context) {
          return const LihatStatusKepanitiaanSayaPage();
        });
      case RekomendasikanPanitiaPage.id:
        return MaterialPageRoute(builder: (context) {
          return const RekomendasikanPanitiaPage();
        });
      case LihatPanitiaPage.id:
        return MaterialPageRoute(builder: (context) {
          return const LihatPanitiaPage();
        });
      case LihatPanitiaPageDetail.id:
        return MaterialPageRoute(builder: (context) {
          return LihatPanitiaPageDetail(
            args: settings.arguments as LihatPanitiaPageDetailArgument,
          );
        });
      // === END

      // === NEIGHBOURHOODHEAD
      case LihatStatusKandidatCalonPengurusRTSayaPage.id:
        return MaterialPageRoute(builder: (context) {
          return const LihatStatusKandidatCalonPengurusRTSayaPage();
        });
      case LihatSemuaKandidatPage.id:
        return MaterialPageRoute(builder: (context) {
          return const LihatSemuaKandidatPage();
        });
      case LihatSemuaKandidatPageDetail.id:
        return MaterialPageRoute(builder: (context) {
          return LihatSemuaKandidatPageDetail(
            args: settings.arguments as LihatSemuaKandidatPageDetailArgument,
          );
        });
      case RekomendasikanKandidatPage.id:
        return MaterialPageRoute(builder: (context) {
          return const RekomendasikanKandidatPage();
        });
      // === END

      // === VOTE
      case VotingPage1.id:
        return MaterialPageRoute(builder: (context) {
          return const VotingPage1();
        });
      // === END
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
