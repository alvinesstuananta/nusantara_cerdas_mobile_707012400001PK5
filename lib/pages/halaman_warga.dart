import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorit_cubit.dart';
import '../cubit/pengajuan_cubit.dart';
import '../models/layanan_model.dart';

class HalamanWarga extends StatelessWidget {
  const HalamanWarga({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Layanan Favorit Saya',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        BlocBuilder<FavoritCubit, Set<String>>(
          builder: (context, favoritSet) {
            if (favoritSet.isEmpty) {
              return const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Belum ada layanan favorit yang ditandai.'),
                ),
              );
            }
            return Column(
              children: favoritSet.map((nama) {
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.star, color: Colors.amber),
                    title: Text(nama),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () {
                        context.read<FavoritCubit>().batalTandai(nama);
                      },
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
        const SizedBox(height: 24),
        const Text(
          'Keranjang Pengajuan Aktif',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        BlocBuilder<PengajuanCubit, List<ItemPengajuan>>(
          builder: (context, daftarPengajuan) {
            if (daftarPengajuan.isEmpty) {
              return const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Belum ada permohonan layanan di keranjang.'),
                ),
              );
            }
            return Column(
              children: [
                ...List.generate(daftarPengajuan.length, (index) {
                  final item = daftarPengajuan[index];
                  return Card(
                    child: ListTile(
                      leading: Text(
                        item.layanan.ikon,
                        style: const TextStyle(fontSize: 24),
                      ),
                      title: Text(item.layanan.nama),
                      subtitle: Text(
                        'Diajukan: ${item.tanggalPengajuan.hour}:${item.tanggalPengajuan.minute} WIB',
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.remove_circle_outline,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          context.read<PengajuanCubit>().hapusPengajuan(index);
                        },
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: () =>
                      context.read<PengajuanCubit>().kosongkanPengajuan(),
                  icon: const Icon(Icons.delete_sweep),
                  label: const Text('Kosongkan Keranjang Pengajuan'),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
