import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorit_cubit.dart';
import '../cubit/pengajuan_cubit.dart';
import '../cubit/theme_cubit.dart';
import '../models/layanan_model.dart';

class HalamanWarga extends StatelessWidget {
  const HalamanWarga({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeMode = context.watch<ThemeCubit>().state;
    final isDark = themeMode == ThemeMode.dark;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: SwitchListTile(
            title: const Text(
              'Mode Gelap (Dark Theme)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(isDark ? 'Tema Gelap Aktif' : 'Tema Terang Aktif'),
            secondary: Icon(
              isDark ? Icons.dark_mode : Icons.light_mode,
              color: theme.colorScheme.primary,
            ),
            value: isDark,
            onChanged: (_) => context.read<ThemeCubit>().toggle(),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Layanan Favorit Saya',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
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
                      onPressed: () =>
                          context.read<FavoritCubit>().batalTandai(nama),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
        const SizedBox(height: 16),
        Text(
          'Keranjang Pengajuan Aktif',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
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
                        onPressed: () => context
                            .read<PengajuanCubit>()
                            .hapusPengajuan(index),
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
