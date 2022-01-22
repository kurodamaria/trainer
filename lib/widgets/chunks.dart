import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trainer/models/models.dart';
import 'package:trainer/pages/subject/subject_logic.dart';
import 'package:trainer/services/services.dart';
import 'package:trainer/widgets/attempts.dart';
import 'package:trainer/widgets/bottom_sheet_container.dart';
import 'package:trainer/widgets/bottom_sheet_handler.dart';
import 'package:trainer/widgets/error_box.dart';
import 'package:trainer/widgets/hive_box_list_view.dart';

class ChunkView extends StatelessWidget {
  const ChunkView({Key? key, required this.chunk}) : super(key: key);

  final Chunk chunk;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        childrenPadding: EdgeInsets.symmetric(horizontal: 16),
        title: Text(chunk.name),
        children: [
          Divider(color: Colors.black),
          Text('Ref: ${chunk.ref}'),
          SizedBox(height: 8),
          _PointIllustrator(point: chunk.points, max: 2000),
          _Actions(chunk: chunk),
        ],
      ),
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions({Key? key, required this.chunk}) : super(key: key);

  final Chunk chunk;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Tooltip(
                message: 'See hints',
                child: TextButton(
                  onPressed: () {
                    Get.bottomSheet(
                      _AttemptsSheet(chunk: chunk),
                      enableDrag: true,
                      // isScrollControlled: true,
                    );
                  },
                  child: Icon(Icons.remove_red_eye),
                ),
              ),
              Tooltip(
                message: 'Edit',
                child: TextButton(
                  onPressed: () {},
                  child: Icon(Icons.edit),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Tooltip(
                message: 'Success',
                child: TextButton(
                  onPressed: () async {
                    chunk.points += 100;
                    chunk.save();

                    final attempt = Attempt.minimal(
                      memo: 'SUCCEDD',
                      success: true,
                      chunkKey: chunk.key,
                    );
                    await attempt.save();

                  },
                  child: Icon(Icons.plus_one),
                ),
              ),
              Tooltip(
                message: 'Fail',
                child: TextButton(
                  onPressed: () async {
                    chunk.points -= 100;
                    chunk.save();
                    final attempt = Attempt.minimal(
                      memo: 'FAILED',
                      success: false,
                      chunkKey: chunk.key,
                    );
                    await attempt.save();
                  },
                  child: Icon(Icons.exposure_minus_1),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PointIllustrator extends StatelessWidget {
  const _PointIllustrator({Key? key, required this.point, required this.max})
      : super(key: key);

  final int point;
  final int max;

  @override
  Widget build(BuildContext context) {
    final color = HSLColor.fromAHSL(
      1,
      point / max * 255,
      1,
      0.3,
    );
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text('Points: $point'),
        ),
        LinearProgressIndicator(
          color: color.toColor(),
          backgroundColor: color.withAlpha(0.3).toColor(),
          value: point / max,
        ),
      ],
    );
  }
}

class _AttemptsSheet extends StatelessWidget {
  const _AttemptsSheet({Key? key, required this.chunk}) : super(key: key);

  final Chunk chunk;

  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(
      child: Column(
        children: [
          BottomSheetHandler(),
          Text('${chunk.name}'),
          FutureBuilder<Box<Attempt>>(
            future: Services.persist.openAttemptBox(chunk),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  if (snapshot.data!.length == 0) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 100),
                      child: Text('Empty', style: Get.textTheme.headline3),
                    );
                  }
                  return HiveBoxListView<Attempt>(
                    itemBuilder: (context, index, item) =>
                        AttemptView(attempt: item),
                    box: snapshot.data!,
                  );
                } else {
                  return ErrorBox(
                    title: 'Error Loading Hints',
                    message: 'Really sorry',
                  );
                }
              }
              return Container();
            },
          )
        ],
      ),
    );
  }
}
