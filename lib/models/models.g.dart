// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubjectAdapter extends TypeAdapter<Subject> {
  @override
  final int typeId = 1;

  @override
  Subject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Subject(
      name: fields[1] as String,
      createdAt: fields[2] as DateTime,
      chunkBoxName: fields[3] as String,
      id: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Subject obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.chunkBoxName)
      ..writeByte(4)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ChunkAdapter extends TypeAdapter<Chunk> {
  @override
  final int typeId = 2;

  @override
  Chunk read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Chunk(
      content: fields[1] as String,
      ref: fields[2] as String,
      createdAt: fields[3] as DateTime,
      subjectKey: fields[4] as String,
      id: fields[5] as String,
      chunkBoxName: fields[6] as String,
      failTimes: fields[7] as int,
      hints: fields[8] as String,
      tags: (fields[9] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Chunk obj) {
    writer
      ..writeByte(9)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.ref)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.subjectKey)
      ..writeByte(5)
      ..write(obj.id)
      ..writeByte(6)
      ..write(obj.chunkBoxName)
      ..writeByte(7)
      ..write(obj.failTimes)
      ..writeByte(8)
      ..write(obj.hints)
      ..writeByte(9)
      ..write(obj.tags);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChunkAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
