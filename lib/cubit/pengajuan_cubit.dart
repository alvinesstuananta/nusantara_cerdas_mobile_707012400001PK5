import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/layanan_model.dart';

class PengajuanCubit extends Cubit<List<ItemPengajuan>> {
  PengajuanCubit() : super([]);

  void tambahPengajuan(Layanan layanan) {
    final daftarBaru = List<ItemPengajuan>.from(state);
    daftarBaru.add(
      ItemPengajuan(layanan: layanan, tanggalPengajuan: DateTime.now()),
    );
    emit(daftarBaru);
  }

  void hapusPengajuan(int index) {
    final daftarBaru = List<ItemPengajuan>.from(state)..removeAt(index);
    emit(daftarBaru);
  }

  void kosongkanPengajuan() {
    emit([]);
  }

  int get totalPengajuan => state.length;
}
