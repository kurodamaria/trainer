import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' hide Value;
import 'package:path/path.dart';
import 'package:trainer/business_logic/database_list/database_list_bloc.dart';
import 'package:trainer/data/provider/chunker.dart';
import 'package:trainer/data/repository/chunk_repository.dart';
import 'package:trainer/representation/chunk_list_view.dart';
import 'package:trainer/representation/pages/edit_chunk_page.dart';
import 'package:trainer/tools/io.dart';
import 'package:trainer/widgets/loading_dialog.dart';

class ChunksPage extends StatelessWidget {
  const ChunksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DatabaseListBloc<Chunk>(
        repository: context.read<ChunkRepository>(),
        query: Get.arguments['query'] as MultiSelectable<Chunk>,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Get.arguments['title'] != null
              ? Text(Get.arguments['title'])
              : null,
          actions: [
            if (Get.arguments['subject'] is Subject)
              const _BatchCreateChunksFromImages(),
            if (Get.arguments['subject'] is Subject) const _AddNewChunkAction()
          ],
        ),
        body: const ChunkListView(),
      ),
    );
  }

  /// Navigate to the ChunksPage of a subject
  static Future<dynamic>? ofSubject(Subject subject) {
    return Get.to(
      () => const ChunksPage(),
      arguments: {
        'query':
            Get.context!.read<ChunkRepository>().allChunksOfSubject(subject),
        'title': subject.name,
        'subject': subject,
      },
    );
  }

  static Future<dynamic>? ofQuery(
    MultiSelectable<Chunk> query, {
    String? title,
  }) {
    return Get.to(
      () => const ChunksPage(),
      arguments: {
        'query': query,
        'title': title,
      },
    );
  }
}

class _BatchCreateChunksFromImages extends StatelessWidget {
  const _BatchCreateChunksFromImages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showLoadingDialog(
            future: _importFromImages(
                context, Get.arguments['subject'] as Subject));
      },
      icon: const Icon(Icons.image),
      tooltip: 'Batch import from images. Reference is the file name.',
    );
  }

  Future<void> _importFromImages(BuildContext context, Subject s) async {
    final result = await pickMultipleFile();
    if (result != null) {
      final bloc = context.read<DatabaseListBloc<Chunk>>();
      for (File f in result) {
        final compressed = await compressImageForStore(f);
        if (compressed != null) {
          final c = ChunksCompanion.insert(
            reference: basename(f.path),
            subject: s.id,
            image: Value(await f.readAsBytes()),
          );
          bloc.add(EventDatabaseListAddChunk(itemToAdd: c));
        } else {
          Get.snackbar('Error', 'Compressing image failed for some reason :(.');
        }
      }
    }
  }
}

class _AddNewChunkAction extends StatelessWidget {
  const _AddNewChunkAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('${Get.arguments['subject']}');
    return IconButton(
      onPressed: () async {
        final result = await EditChunkPage.ofChunk(ChunksCompanion(
          subject: Value((Get.arguments['subject'] as Subject).id),
        ));
        if (result != null) {
          context
              .read<DatabaseListBloc<Chunk>>()
              .add(EventDatabaseListAddChunk(itemToAdd: result));
        }
      },
      icon: const Icon(Icons.add),
    );
  }
}
