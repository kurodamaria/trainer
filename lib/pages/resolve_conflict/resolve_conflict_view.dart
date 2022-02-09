import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainer/pages/resolve_conflict/resolve_conflict_state.dart';

import 'resolve_conflict_logic.dart';

class ResolveConflictPage extends StatelessWidget {
  ResolveConflictPage({Key? key}) : super(key: key);

  final logic = Get.find<ResolveConflictLogic>();
  final state = Get
      .find<ResolveConflictLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Solve Conflict')),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ConflictListTile(conflict: state.conflicts[index]);
        },
        itemCount: state.conflicts.length,
      ),
    );
  }
}

class ConflictListTile extends StatelessWidget {
  ConflictListTile({Key? key, required this.conflict}) : super(key: key);

  final Conflict conflict;

  final logic = Get.find<ResolveConflictLogic>();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(logic.describeShortly(conflict), style: Get.textTheme.titleLarge),
            const Divider(),
            Text(logic.describeDetails(conflict)),
          ],
        ),
      ),
    );
  }
}
