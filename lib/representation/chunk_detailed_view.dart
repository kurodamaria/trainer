import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:trainer/business_logic/chunk/chunk_bloc.dart';
import 'package:trainer/data/provider/chunker.dart';
import 'package:trainer/representation/chunk_marker.dart';
import 'package:trainer/tools/chunk_transforms.dart';
import 'package:trainer/tools/datetime.dart';
import 'package:trainer/widgets/markdown_card.dart';

class ChunkDetailedView extends StatelessWidget {
  const ChunkDetailedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: const [
          _DetailedHead(),
          _EffectivenessSlider(),
          Divider(),
          _SelectiveDetailedChunkContentRender(),
          _DetailedImageRender(),
        ],
      ),
    );
  }
}

class _DetailedHead extends StatelessWidget {
  const _DetailedHead({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: BlocBuilder<ChunkBloc, Chunk>(
        // This might never rebuild.
        buildWhen: (c1, c2) => c1.createdAt != c2.createdAt,
        builder: (context, state) {
          return Text(formatDateTime(state.createdAt));
        },
      ),
      subtitle: Row(
        children: [
          BlocBuilder<ChunkBloc, Chunk>(
            builder: (context, state) {
              return Text(state.reference);
            },
          ),
          BlocBuilder<ChunkBloc, Chunk>(
            builder: (context, state) {
              return Text(', ${daysAgo(state.createdAt)} Days Ago');
            },
          )
        ],
      ),
      trailing: const ChunkMaker(),
    );
  }
}

class _SelectiveDetailedChunkContentRender extends StatelessWidget {
  const _SelectiveDetailedChunkContentRender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChunkBloc, Chunk>(
      buildWhen: (c1, c2) => c1.content != c2.content,
      builder: (context, state) {
        if (state.content == null) {
          return const SizedBox();
        } else if (state.content!.contains(r'\(') ||
            state.content!.contains(r'$$')) {
          return MarkdownCard(state.content!);
        } else {
          return _PlainTextDetailedChunkContentRender(content: state.content!);
        }
      },
    );
  }
}

class _PlainTextDetailedChunkContentRender extends StatelessWidget {
  const _PlainTextDetailedChunkContentRender({Key? key, required this.content})
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

class _DetailedImageRender extends StatelessWidget {
  const _DetailedImageRender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChunkBloc, Chunk>(
      buildWhen: (c1, c2) => c1.image != c2.image,
      builder: (context, state) {
        if (state.image != null) {
          return InteractiveViewer(
            child: Image.memory(state.image!),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

/// Use this slider to match the perceived effectiveness
/// of the chunk today.
class _EffectivenessSlider extends StatelessWidget {
  const _EffectivenessSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final v = context.read<ChunkBloc>().state.effectiveLevel.obs;
    return Obx(() {
      return Slider(
        divisions: 10,
        value: v.value,
        onChanged: (value) {
          v.value = value;
        },
        min: 0,
        max: 1,
        label: '${v.value}',
        thumbColor: effectiveLevelColor(v.value),
        activeColor: effectiveLevelColor(v.value),
        onChangeEnd: (value) {
          context
              .read<ChunkBloc>()
              .add(EventChangeChunkEffectiveLevel(level: value));
        },
      );
    });
  }
}
