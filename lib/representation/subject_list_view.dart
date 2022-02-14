import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:trainer/business_logic/database_list/database_list_bloc.dart';
import 'package:trainer/data/provider/chunker.dart';
import 'package:trainer/data/repository/chunk_repository.dart';
import 'package:trainer/representation/database_list_view.dart';
import 'package:trainer/representation/database_query_builder.dart';
import 'package:trainer/representation/pages/chunks_page.dart';
import 'package:trainer/tools/datetime.dart';
import 'package:trainer/widgets/confirm_dialog.dart';
import 'package:trainer/widgets/loading_indicator.dart';

import '../business_logic/subject/subject_bloc.dart';

class SubjectListView extends StatelessWidget {
  const SubjectListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DatabaseListView<Subject>(
      query: context.read<DatabaseListBloc<Subject>>().state.query,
      itemBuilder: (_, i, s) {
        return BlocProvider(
          create: (context) => SubjectBloc(subject: s),
          child: ListTile(
            title: Row(
              children: [Text(s.name), const _ChunkCounter()],
            ),
            subtitle: Text(formatDateTime(s.createdAt)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                _EffectiveRatio(),
              ],
            ),
            onTap: () {
              ChunksPage.ofSubject(s);
            },
            onLongPress: () async {
              final result = await Get.dialog(const ConfirmDialog(
                  msg: 'You cannot undo this.', action: 'Delete'));
              if (result == true) {
                context
                    .read<DatabaseListBloc<Subject>>()
                    .add(EventDatabaseListDeleteSubject(itemToDelete: s));
              }
            },
          ),
        );
      },
    );
  }
}

class _EffectiveRatio extends StatelessWidget {
  const _EffectiveRatio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubjectBloc, Subject>(
      builder: (context, state) {
        return DatabaseMultiQueryFutureBuilder<Chunk>(
          query: context.read<ChunkRepository>().allChunksOfSubject(state),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text('-1');
              } else if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return const Text('Eff: No Chunk');
                }

                final ratio = (snapshot.data!
                        .map((e) => e.effectiveLevel)
                        .reduce((value, element) => value + element)) /
                    (snapshot.data!.length) *
                    100;
                return Text('Eff: ${ratio.toPrecision(2)}%');
              }
            }
            return const LoadingIndicator();
          },
        );
      },
    );
  }
}

class _ChunkCounter extends StatelessWidget {
  const _ChunkCounter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubjectBloc, Subject>(
      builder: (context, state) {
        return DatabaseMultiQueryFutureBuilder(
          query: context.read<ChunkRepository>().allChunksOfSubject(state),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text('-1');
              } else if (snapshot.hasData) {
                return Text('(${snapshot.data!.length})');
              }
            }
            return const LoadingIndicator();
          },
        );
      },
    );
  }
}
