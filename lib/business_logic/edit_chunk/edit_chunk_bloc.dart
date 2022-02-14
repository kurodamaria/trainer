import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:trainer/data/provider/chunker.dart';
import 'package:trainer/data/repository/chunk_repository.dart';

part 'edit_chunk_event.dart';

part 'edit_chunk_state.dart';

class EditChunkBloc extends Bloc<EditChunkEvent, EditChunkState> {
  EditChunkBloc(ChunksCompanion companion)
      : super(StateEditChunkInitial(companion)) {
    on<EventEditChunkModify>((event, emit) {
      emit(StateEditChunkModified(event.companion));
    });

    on<EventEditChunkSave>((event, emit) async {
      if (state is StateEditChunkModified) {
        // await Get.find<ChunkRepository>().updateOrInsertChunk(state.companion);
        emit(StateEditChunkSaved(state.companion));
      }
    });
  }
}
