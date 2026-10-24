import 'package:flutter/material.dart';

import '../models/layanan_model.dart';
import '../pages/halaman_detail_layanan.dart';
import 'kerangka_navigasi.dart';

class AppRoutes {
  static const String beranda = '/';
  static const String detailLayanan = '/detail-layanan';

  static Map<String, WidgetBuilder> daftarRoute() {
    return {beranda: (context) => const KerangkaNavigasi()};
  }

  static Route<dynamic>? bentukRoute(RouteSettings settings) {
    if (settings.name == detailLayanan) {
      final layanan = settings.arguments as Layanan;
      return MaterialPageRoute(
        builder: (context) => HalamanDetailLayanan(layanan: layanan),
      );
    }
    return null;
  }
}
