import 'package:flutter/material.dart';

import '../models/layanan_model.dart';
import '../navigation/app_routes.dart';
import '../widgets/layanan_card.dart';

class HalamanLayanan extends StatelessWidget {
  const HalamanLayanan({super.key});

  static const List<Layanan> daftarSemuaLayanan = [
    Layanan(
      id: 'L01',
      nama: 'Izin Usaha Mikro (IUMK)',
      deskripsi: 'Pengurusan izin usaha skala mikro & kecil.',
      bidang: 'Perizinan',
      ikon: '🏢',
    ),
    Layanan(
      id: 'L02',
      nama: 'IMB / PBG Bangunan',
      deskripsi: 'Persetujuan bangunan gedung hunian.',
      bidang: 'Perizinan',
      ikon: '🏠',
    ),
    Layanan(
      id: 'L03',
      nama: 'Pendaftaran Puskesmas',
      deskripsi: 'Antrean online fasilitas kesehatan.',
      bidang: 'Kesehatan',
      ikon: '🏥',
    ),
    Layanan(
      id: 'L04',
      nama: 'Donor Darah & Ambulans',
      deskripsi: 'Layanan tanggap darurat kesehatan.',
      bidang: 'Kesehatan',
      ikon: '🚑',
    ),
    Layanan(
      id: 'L05',
      nama: 'Uji Keberlaikan Kendaraan',
      deskripsi: 'Pendaftaran Uji KIR transportasi umum.',
      bidang: 'Transportasi',
      ikon: '🚌',
    ),
    Layanan(
      id: 'L06',
      nama: 'Kartu Parkir Berlangganan',
      deskripsi: 'Fasilitas parkir publik terpadu.',
      bidang: 'Transportasi',
      ikon: '🅿️',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            labelColor: theme.colorScheme.primary,
            unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
            indicatorColor: theme.colorScheme.primary,
            tabs: const [
              Tab(text: 'Perizinan'),
              Tab(text: 'Kesehatan'),
              Tab(text: 'Transportasi'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buatDaftarLayanan(context, 'Perizinan'),
                _buatDaftarLayanan(context, 'Kesehatan'),
                _buatDaftarLayanan(context, 'Transportasi'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buatDaftarLayanan(BuildContext context, String bidang) {
    final filtered = daftarSemuaLayanan
        .where((l) => l.bidang == bidang)
        .toList();

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final item = filtered[index];
        return LayananCard(
          layanan: item,
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.detailLayanan,
              arguments: item,
            );
          },
        );
      },
    );
  }
}
