part of 'chunk_bloc.dart';

@immutable
abstract class ChunkEvent {}

class EventMarkChunk extends ChunkEvent {
  EventMarkChunk({required this.isMarked});

  final bool isMarked;
}

class EventChangeChunkEffectiveLevel extends ChunkEvent {
  EventChangeChunkEffectiveLevel({required this.level});

  final double level;
}

/// Write updated companion to the database.
class EventUpdateChunk extends ChunkEvent {
  EventUpdateChunk(this.companion);

  final ChunksCompanion companion;
}
