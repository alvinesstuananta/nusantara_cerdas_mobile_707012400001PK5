import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritCubit extends Cubit<Set<String>> {
  FavoritCubit() : super({});

  void toggleFavorit(String namaLayanan) {
    final stateBaru = Set<String>.from(state);
    if (stateBaru.contains(namaLayanan)) {
      stateBaru.remove(namaLayanan);
    } else {
      stateBaru.add(namaLayanan);
    }
    emit(stateBaru);
  }

  void tandai(String namaLayanan) {
    final stateBaru = Set<String>.from(state)..add(namaLayanan);
    emit(stateBaru);
  }

  void batalTandai(String namaLayanan) {
    final stateBaru = Set<String>.from(state)..remove(namaLayanan);
    emit(stateBaru);
  }
}
