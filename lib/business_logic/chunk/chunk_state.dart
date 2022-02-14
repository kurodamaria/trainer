part of 'chunk_bloc.dart';

@immutable
abstract class StateChunk {}

class StateChunkInitial extends StateChunk {
  final Chunk chunk = Get.arguments['chunk'] as Chunk;
}

class StateChunkModified extends StateChunk { }
