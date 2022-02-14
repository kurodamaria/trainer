part of 'edit_chunk_bloc.dart';

@immutable
abstract class EditChunkState {
  const EditChunkState(this.companion);

  final ChunksCompanion companion;
}

class StateEditChunkInitial extends EditChunkState {
  const StateEditChunkInitial(ChunksCompanion companion) : super(companion);
}

class StateEditChunkModified extends EditChunkState {
  const StateEditChunkModified(ChunksCompanion companion) : super(companion);
}

class StateEditChunkSaved extends EditChunkState {
  const StateEditChunkSaved(ChunksCompanion companion) : super(companion);
}
