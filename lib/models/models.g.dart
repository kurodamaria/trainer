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
      name: fields[1] as String,
      ref: fields[2] as String,
      createdAt: fields[3] as DateTime,
      subjectKey: fields[4] as String,
      id: fields[5] as String,
      attemptBoxName: fields[6] as String,
      chunkBoxName: fields[7] as String,
      points: fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Chunk obj) {
    writer
      ..writeByte(8)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.ref)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.subjectKey)
      ..writeByte(5)
      ..write(obj.id)
      ..writeByte(6)
      ..write(obj.attemptBoxName)
      ..writeByte(7)
      ..write(obj.chunkBoxName)
      ..writeByte(8)
      ..write(obj.points);
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

class AttemptAdapter extends TypeAdapter<Attempt> {
  @override
  final int typeId = 3;

  @override
  Attempt read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Attempt(
      createdAt: fields[1] as DateTime,
      success: fields[2] as bool,
      memo: fields[3] as String,
      chunkKey: fields[4] as String,
      chunkBoxName: fields[5] as String,
      attemptBoxName: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Attempt obj) {
    writer
      ..writeByte(6)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.success)
      ..writeByte(3)
      ..write(obj.memo)
      ..writeByte(4)
      ..write(obj.chunkKey)
      ..writeByte(5)
      ..write(obj.chunkBoxName)
      ..writeByte(6)
      ..write(obj.attemptBoxName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttemptAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
