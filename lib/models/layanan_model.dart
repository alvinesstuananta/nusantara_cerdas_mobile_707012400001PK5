import 'package:flutter/foundation.dart';

@immutable
class Layanan {
  final String id;
  final String nama;
  final String deskripsi;
  final String bidang; // Perizinan, Kesehatan, Transportasi
  final String ikon;

  const Layanan({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.bidang,
    required this.ikon,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Layanan && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class ItemPengajuan {
  final Layanan layanan;
  final DateTime tanggalPengajuan;

  const ItemPengajuan({required this.layanan, required this.tanggalPengajuan});
}
