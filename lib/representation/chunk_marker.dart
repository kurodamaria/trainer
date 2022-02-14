import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:trainer/business_logic/chunk/chunk_bloc.dart';
import 'package:trainer/data/provider/chunker.dart';

class ChunkMaker extends StatelessWidget {
  const ChunkMaker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChunkBloc, Chunk>(
      buildWhen: (c1, c2) => c1.isMarked != c2.isMarked,
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            context
                .read<ChunkBloc>()
                .add(EventMarkChunk(isMarked: !state.isMarked));
          },
          icon: Icon(
            Icons.star,
            color: state.isMarked ? Colors.yellowAccent : Colors.grey,
          ),
        );
      },
    );
  }
}
