import 'dart:convert';

import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:get/get.dart';
import 'package:trainer/business_logic/chunk/chunk_bloc.dart';
import 'package:trainer/business_logic/database_list/database_list_bloc.dart';
import 'package:trainer/data/provider/chunker.dart';
import 'package:trainer/data/repository/chunk_repository.dart';
import 'package:trainer/representation/chunk_marker.dart';
import 'package:trainer/representation/database_list_view.dart';
import 'package:trainer/representation/pages/chunk_detail_page.dart';
import 'package:trainer/tools/chunk_transforms.dart';
import 'package:trainer/tools/datetime.dart';
import 'package:trainer/tools/io.dart';
import 'package:trainer/tools/mathjax_in_plaintext.dart';
import 'package:trainer/widgets/confirm_dialog.dart';
import 'package:trainer/widgets/error_box.dart';
import 'package:trainer/widgets/loading_indicator.dart';

// Except the query. We need a ... Bloc here.
class ChunkListView extends StatelessWidget {
  const ChunkListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repo = context.read<ChunkRepository>();
    return BlocBuilder<DatabaseListBloc<Chunk>, DatabaseListState<Chunk>>(
      builder: (context, state) {
        return DatabaseListView<Chunk>(
          viewType: DatabaseViewType.get,
          query: state.query,
          itemBuilder: (_, i, c) => BlocProvider(
            create: (context) => ChunkBloc(repository: repo, chunk: c),
            child: const _ChunkItem(),
          ),
        );
      },
    );
  }
}

class _ChunkItem extends StatelessWidget {
  const _ChunkItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChunkBloc, Chunk>(
      builder: (context, c) {
        return ListTile(
          style: ListTileStyle.drawer,
          // make effective level less or equal than 0.3 stand out
          tileColor: c.effectiveLevel <= 0.3
              ? Colors.deepPurpleAccent
              : Colors.black12,
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 4),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: _SelectiveChunkRender(chunk: c)),
              Column(
                children: [
                  _EffectiveLevelRender(chunk: c),
                  ChunkMaker(),
                ],
              ),
            ],
          ),
          subtitle: Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              Text(formatDateTime(c.createdAt)),
              Text(c.reference),
            ],
          ),
          onTap: () {
            ChunkDetailPage.ofChunk(c, context.read<ChunkBloc>());
          },
          onLongPress: () async {
            final result = await Get.dialog(const ConfirmDialog(
                msg: 'You cannot undo this.', action: 'Delete'));
            if (result == true) {
              context
                  .read<DatabaseListBloc<Chunk>>()
                  .add(EventDatabaseListDeleteChunk(itemToDelete: c));
            }
          },
        );
      },
    );
  }
}


class _SelectiveChunkRender extends StatelessWidget {
  const _SelectiveChunkRender({Key? key, required this.chunk})
      : super(key: key);

  final Chunk chunk;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (chunk.content != null)
          if (chunk.content!.contains(r'$'))
            _NativeTexMathChunkContentRender(content: chunk.content!)
          else
            _PlainTextChunkContentRender(content: chunk.content!),
        if (chunk.image != null) _ImageRender(image: chunk.image!)
      ],
    );
  }
}

class _ImageRender extends StatelessWidget {
  const _ImageRender({Key? key, required this.image}) : super(key: key);

  final Uint8List image;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: compressImageForPreview(image),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const ErrorBox(
              title: 'Shit happens',
              message: 'Cannot compress image for preview',
            );
          }
          if (snapshot.hasData) {
            return Image.memory(snapshot.data!);
          }
        }
        return const Center(child: LoadingIndicator());
      },
    );
  }
}

class _PlainTextChunkContentRender extends StatelessWidget {
  const _PlainTextChunkContentRender({Key? key, required this.content})
      : super(key: key);

  final String content;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: Get.size.width,
          child: Text(
            content,
            style: Get.textTheme.bodyLarge!.copyWith(
              color: Get.theme.primaryColor,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}

class _NativeTexMathChunkContentRender extends StatelessWidget {
  const _NativeTexMathChunkContentRender({Key? key, required this.content})
      : super(key: key);

  final String content;

  @override
  Widget build(BuildContext context) {
    final Widget rendered = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: const LineSplitter()
          .convert(mathjaxInPlainText(content))
          .map((e) => Math.tex(
                e,
                textStyle: Get.textTheme.bodyMedium!
                    .copyWith(color: Get.theme.primaryColor),
                onErrorFallback: (_) => Text(e),
              ))
          .toList(),
    );

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: rendered,
      ),
    );
  }
}

class _EffectiveLevelRender extends StatelessWidget {
  const _EffectiveLevelRender({Key? key, required this.chunk})
      : super(key: key);

  final Chunk chunk;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircularProgressIndicator(
          value: chunk.effectiveLevel,
          backgroundColor: Colors.white24,
          color: effectiveLevelColor(chunk.effectiveLevel),
        ),
        Positioned.fill(
          child: Center(child: Text('${chunk.effectiveLevel}')),
        ),
      ],
    );
  }
}
