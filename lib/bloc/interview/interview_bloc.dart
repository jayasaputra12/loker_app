import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/update_interview_model.dart';
import '../../repositories/interview/interview_repositry.dart';

part 'interview_event.dart';
part 'interview_state.dart';

class InterviewBloc extends Bloc<InterviewEvent, InterviewState> {
  final InterviewRepository _repository;
  InterviewBloc(this._repository) : super(InterviewInitial()) {
    on<UpdateInterviewEvent>((event, emit) async {
      emit(InterviewLoading());
      try {
        UpadateInterviewModel interview = await _repository.updateInterview(
          keterangan: event.keterangan,
          id: event.id,
          idSeleksi: event.idSeleksi,
          idHrd: event.idHrd,
          jadwal: event.jadwal,
          token: event.token,
          idPelamar: event.idPelamar,
          status: event.status,
          namaLoker: event.namaLoker,
          idLoker: event.idLoker,
        );
        emit(InterviewLoaded(interview: interview.data!));
      } catch (e) {
        emit(InterviewError(message: e.toString()));
      }
    });
  }
}
