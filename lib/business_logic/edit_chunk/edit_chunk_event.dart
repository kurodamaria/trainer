part of 'edit_chunk_bloc.dart';

@immutable
abstract class EditChunkEvent {}

///  Modify current state to new state.
class EventEditChunkModify extends EditChunkEvent {
  EventEditChunkModify(this.companion);

  final ChunksCompanion companion;
}

/// Save current state to database.
class EventEditChunkSave extends EditChunkEvent {}
