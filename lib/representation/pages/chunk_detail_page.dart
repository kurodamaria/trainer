import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:trainer/business_logic/chunk/chunk_bloc.dart';
import 'package:trainer/data/provider/chunker.dart';
import 'package:trainer/data/repository/chunk_repository.dart';
import 'package:trainer/representation/chunk_detailed_view.dart';
import 'package:trainer/representation/pages/edit_chunk_page.dart';
import 'package:trainer/tools/io.dart';

/// Provider a chunk as argument.
class ChunkDetailPage extends StatelessWidget {
  const ChunkDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: Get.arguments['bloc'] as ChunkBloc,
      // create: (context) => ChunkBloc(
      //   chunk: Get.arguments['chunk'],
      //   repository: context.read<ChunkRepository>(),
      // ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detail'),
          actions: const [_EditAction()],
        ),
        body: const ChunkDetailedView(),
      ),
    );
  }

  static Future<dynamic>? ofChunk(Chunk chunk, ChunkBloc bloc) {
    return Get.to(
      () => const ChunkDetailPage(),
      arguments: {'chunk': chunk, 'bloc': bloc},
    );
  }
}


class _EditAction extends StatelessWidget {
  const _EditAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final result = await EditChunkPage.ofChunk(
            context.read<ChunkBloc>().state.toCompanion(false));
        if (result != null) {
          context.read<ChunkBloc>().add(EventUpdateChunk(result));
        }
      },
      icon: const Icon(Icons.edit),
    );
  }
}
