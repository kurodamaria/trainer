import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:trainer/data/provider/chunker.dart';
import 'package:trainer/data/repository/chunk_repository.dart';

part 'chunk_event.dart';

part 'chunk_state.dart';

class ChunkBloc extends Bloc<ChunkEvent, Chunk> {
  ChunkBloc({required this.repository, required Chunk chunk}) : super(chunk) {
    on<EventMarkChunk>((event, emit) async {
      if (event.isMarked != state.isMarked) {
        final copy = state.copyWith(isMarked: event.isMarked);
        await repository.updateChunk(copy);
        emit(copy);
      }
    });
    on<EventChangeChunkEffectiveLevel>((event, emit) async {
      if (event.level != state.effectiveLevel) {
        final copy = state.copyWith(effectiveLevel: event.level);
        await repository.updateChunk(copy);
        emit(copy);
      }
    });
    on<EventUpdateChunk>((event, emit) async {
      final rowId = await Get.find<ChunkRepository>()
          .updateOrInsertChunk(event.companion);
      emit(await Get.find<ChunkRepository>().chunkOfId(rowId));
    });
  }

  final ChunkRepository repository;
}
