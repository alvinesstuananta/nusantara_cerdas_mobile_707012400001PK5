import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorit_cubit.dart';
import '../models/layanan_model.dart';

class LayananCard extends StatelessWidget {
  final Layanan layanan;
  final VoidCallback onTap;

  const LayananCard({super.key, required this.layanan, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: theme.colorScheme.surfaceContainerLow,
      child: ListTile(
        leading: Text(layanan.ikon, style: const TextStyle(fontSize: 28)),
        title: Text(
          layanan.nama,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          layanan.deskripsi,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        trailing: BlocBuilder<FavoritCubit, Set<String>>(
          builder: (context, favoritSet) {
            final isFav = favoritSet.contains(layanan.nama);
            return IconButton(
              icon: Icon(
                isFav ? Icons.star : Icons.star_border,
                color: isFav ? Colors.amber : theme.colorScheme.outline,
              ),
              onPressed: () {
                context.read<FavoritCubit>().toggleFavorit(layanan.nama);
              },
            );
          },
        ),
        onTap: onTap,
      ),
    );
  }
}
