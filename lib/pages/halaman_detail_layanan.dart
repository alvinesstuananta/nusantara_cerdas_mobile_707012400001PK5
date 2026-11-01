import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/pengajuan_cubit.dart';
import '../models/layanan_model.dart';
import '../widgets/primary_button.dart';

class HalamanDetailLayanan extends StatefulWidget {
  final Layanan layanan;

  const HalamanDetailLayanan({super.key, required this.layanan});

  @override
  State<HalamanDetailLayanan> createState() => _HalamanDetailLayananState();
}

class _HalamanDetailLayananState extends State<HalamanDetailLayanan> {
  bool _isSending = false;

  Future<void> _prosesPengajuan() async {
    setState(() => _isSending = true);

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    context.read<PengajuanCubit>().tambahPengajuan(widget.layanan);

    setState(() => _isSending = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Layanan "${widget.layanan.nama}" berhasil diajukan!'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.layanan.nama)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                widget.layanan.ikon,
                style: const TextStyle(fontSize: 64),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Bidang: ${widget.layanan.bidang}',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.layanan.deskripsi,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            const Spacer(),
            PrimaryButton(
              label: 'Ajukan Permohonan',
              icon: Icons.send,
              isLoading: _isSending,
              onPressed: _prosesPengajuan,
            ),
          ],
        ),
      ),
    );
  }
}
