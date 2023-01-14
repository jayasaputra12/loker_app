import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/hrd_list_notifikasi_model.dart';
import '../../model/update_seleksi_model.dart';
import '../../repositories/seleksi/seleksi_repository.dart';

part 'seleksi_event.dart';
part 'seleksi_state.dart';

class SeleksiBloc extends Bloc<SeleksiEvent, SeleksiState> {
  final SeleksiRepository _repository;
  SeleksiBloc(this._repository) : super(SeleksiInitial()) {
    on<UpadateSeleksiEvent>((event, emit)async {
      emit(SeleksiLoading());
      try {
        DataSeleksi seleksi = await _repository.updateSeleksi(
          idPelamar: event.idPelamar,
          idLoker: event.idLoker,
          suratLamaran: event.suratLamaran,
          status: event.status,
          keterangan: event.keterangan,
        id: event.id,
        );
        emit(SeleksiLoaded(updateSeleksi: seleksi));
      } catch (e) {
        emit(SeleksiError(message: e.toString()));
      }
    });
  }
}