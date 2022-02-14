import 'dart:io';

import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' hide Value;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trainer/business_logic/database_list/database_list_bloc.dart';
import 'package:trainer/data/provider/chunker.dart';
import 'package:trainer/data/repository/chunk_repository.dart';
import 'package:trainer/representation/pages/chunk_search_page.dart';
import 'package:trainer/representation/subject_list_view.dart';
import 'package:trainer/tools/io.dart';
import 'package:trainer/widgets/loading_dialog.dart';
import 'package:trainer/widgets/text_input_dialog.dart';
import 'package:trainer/tools/keys.dart' as keys;

class _PickADataFolder extends StatelessWidget {
  const _PickADataFolder({Key? key, required this.onFolderPicked})
      : super(key: key);

  final ValueChanged<Directory> onFolderPicked;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('No Data Folder Provided',
                style: Get.textTheme.headlineMedium),
            const Text('The database will be named chunker.sqlite.'),
            const Text('Be aware of conflict.'),
            TextButton(
              child: const Text('Select...'),
              onPressed: () async {
                final d = await pickADirectory();
                if (d != null) {
                  onFolderPicked(d);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    if (Get.find<SharedPreferences>().getString(keys.keyDataFolder) == null) {
      return _PickADataFolder(
        onFolderPicked: (Directory value) {
          Get.find<SharedPreferences>()
              .setString(keys.keyDataFolder, value.path);
          setState(() {});
        },
      );
    }
    return BlocProvider(
      create: (context) => DatabaseListBloc<Subject>(
        query: Get.find<ChunkRepository>().allSubjects,
        repository: Get.find<ChunkRepository>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: const [
            _CreateNewSubjectAction(),
            _ExportFromHiveAction(),
            _ExportDatabaseAction(),
            _SearchAction()
          ],
        ),
        body: const SubjectListView(),
      ),
    );
  }
}

class _ExportDatabaseAction extends StatelessWidget {
  const _ExportDatabaseAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final d = await pickADirectory();
        if (d != null) {
          showLoadingDialog(
              future: Get.find<ChunkRepository>().exportDatabaseFile(d));
        }
      },
      icon: const Icon(Icons.import_export_sharp),
      color: Colors.blue,
    );
  }
}

class _CreateNewSubjectAction extends StatelessWidget {
  const _CreateNewSubjectAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final result =
            await Get.dialog(const TextInputDialog(labels: ['Title']));
        if (result != null) {
          context.read<DatabaseListBloc<Subject>>().add(
              EventDatabaseListAddSubject(
                  SubjectsCompanion(name: Value(result[0]))));
        }
      },
      icon: const Icon(Icons.add_circle),
      tooltip: 'Add a new subject',
    );
  }
}

class _SearchAction extends StatelessWidget {
  const _SearchAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.to(() => const ChunkSearchPage());
      },
      icon: const Icon(Icons.search),
    );
  }
}

class _ExportFromHiveAction extends StatelessWidget {
  const _ExportFromHiveAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.import_export),
      color: Colors.yellow,
      onPressed: () async {
        final file = await pickAFile();
        if (file != null) {
          showLoadingDialog(
              future: Get.find<ChunkRepository>().importFromHiveData(file));
        }
      },
      tooltip: 'Import From Hive',
    );
  }
}
