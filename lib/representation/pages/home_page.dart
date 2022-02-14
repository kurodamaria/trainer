import 'dart:async';
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
import 'package:trainer/representation/pages/chunks_page.dart';
import 'package:trainer/representation/subject_list_view.dart';
import 'package:trainer/tools/datetime.dart';
import 'package:trainer/tools/io.dart';
import 'package:trainer/widgets/loading_dialog.dart';
import 'package:trainer/widgets/text_input_dialog.dart';
import 'package:trainer/tools/keys.dart' as keys;
import 'package:trainer/widgets/tick_builder.dart';
import 'dart:math' as math;

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
            _SearchAction(),
          ],
        ),
        body: const SubjectListView(),
        drawer: const _Drawer(),
        bottomNavigationBar: _BBar(),
      ),
    );
  }
}

class _BBar extends StatefulWidget {
  const _BBar({Key? key}) : super(key: key);

  @override
  State<_BBar> createState() => _BBarState();
}

class _BBarState extends State<_BBar> {
  Timer? _t;
  final opacity = .0.obs;

  @override
  void initState() {
    super.initState();
    _t = Timer.periodic(
      const Duration(milliseconds: 800),
      (t) {
        _t = t;
        opacity.value = opacity.value == 1 ? 0 : 1;
      },
    );
  }

  @override
  void dispose() {
    _t?.cancel();
    _t = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color c = isNowDay() ? Colors.yellowAccent : Colors.lightBlueAccent;
    return Obx(() {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 1000),
        decoration: BoxDecoration(
          border: Border.fromBorderSide(BorderSide(
            color: c.withOpacity(opacity.value),
          )),
          color: Colors.black.withOpacity(0.1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            _CreateTodayAction(),
            _ReviewTodayAction(),
          ],
        ),
      );
    });
  }
}

class _CreateTodayAction extends StatelessWidget {
  const _CreateTodayAction({Key? key}) : super(key: key);

  final _duration = const Duration(milliseconds: 600);

  Widget _button(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final bloc = context.read<DatabaseListBloc<Subject>>();
        if (bloc.hasTodayBox()) {
          final s = (await bloc.todaySubject)!;
          Get.to(
            () => const ChunksPage(),
            arguments: {
              'query': bloc.todayQuery,
              'subject': s,
              'title': s.name,
            },
          );
        } else {
          bloc.add(EventCreateTodayBox());
          Get.snackbar('TODAY!', 'Created');
        }
      },
      icon: const Icon(
        Icons.wb_sunny_outlined,
        color: Colors.yellowAccent,
      ),
      tooltip: 'Create Today\'s Box',
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isNowDay()) {
      double r = 0;
      return TickBuilder(
        duration: _duration,
        builder: (context) {
          return AnimatedContainer(
            duration: _duration,
            transformAlignment: Alignment.center,
            transform: Matrix4.rotationZ(r),
            child: _button(context),
          );
        },
        onDurationPassed: () {
          r = r == 0 ? math.pi : 0;
        },
      );
    } else {
      return _button(context);
    }
  }
}

class _ReviewTodayAction extends StatelessWidget {
  const _ReviewTodayAction({Key? key}) : super(key: key);

  final _d = const Duration(milliseconds: 800);

  Widget _button(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final bloc = context.read<DatabaseListBloc<Subject>>();
        if (bloc.hasTodayBox()) {
          final s = (await bloc.todaySubject)!;
          Get.to(
            () => const ChunksPage(),
            arguments: {
              'query': bloc.todayQuery,
              'subject': s,
              'title': s.name,
            },
          );
        } else {
          Get.snackbar(
            'No asdjfo',
            'You need to create today\'s box first',
          );
        }
      },
      icon: const Icon(
        Icons.shield_moon,
        color: Colors.lightBlueAccent,
      ),
      tooltip: 'Create Today\'s Box',
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isNowNight()) {
      double opacity = 0;
      return TickBuilder(
        duration: _d,
        builder: (context) {
          return AnimatedOpacity(
            opacity: opacity,
            duration: const Duration(milliseconds: 1000),
            child: _button(context),
          );
        },
        onDurationPassed: () {
          opacity = opacity == 0 ? 1 : 0;
        },
      );
    } else {
      return _button(context);
    }
  }
}

class _Drawer extends StatelessWidget {
  const _Drawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Image.asset('assets/images/not_found.gif'),
          ),
          const Text('Special Day Filters'),
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.heart_broken, color: Colors.purpleAccent),
            title: const Text('You'),
            style: ListTileStyle.drawer,
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.star, color: Colors.purpleAccent),
            title: const Text('Deer'),
            style: ListTileStyle.drawer,
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.star, color: Colors.purpleAccent),
            title: const Text('Rabbit'),
            style: ListTileStyle.drawer,
            onTap: () {},
          ),
          const SizedBox(height: 8),
          const Text('Special Level Filters'),
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.star, color: Colors.purpleAccent),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [Text('Shitty'), Text('0 ~ 0.3')],
            ),
            style: ListTileStyle.drawer,
            onTap: () {
              Get.to(() => const ChunksPage(), arguments: {
                'query': Get.find<ChunkRepository>().shitty,
                'title': 'Shitty [0, 0.3]'
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.star, color: Colors.purpleAccent),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [Text('BAD'), Text('0.3 ~ 0.5')],
            ),
            style: ListTileStyle.drawer,
            onTap: () {
              Get.to(() => const ChunksPage(), arguments: {
                'query': Get.find<ChunkRepository>().bad,
                'title': 'Bad (0.3, 0.5]'
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.star, color: Colors.purpleAccent),
            // title: const Text('0.5 (MILD)'),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [Text('MILD'), Text('0.5')],
            ),
            style: ListTileStyle.drawer,
            onTap: () {
              Get.to(() => const ChunksPage(), arguments: {
                'query': Get.find<ChunkRepository>().mild,
                'title': 'MILD 0.5'
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.star, color: Colors.purpleAccent),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [Text('NORMAL'), Text('0.5 ~ 0.8')],
            ),
            style: ListTileStyle.drawer,
            onTap: () {
              Get.to(() => const ChunksPage(), arguments: {
                'query': Get.find<ChunkRepository>().normal,
                'title': 'Normal (0.5, 0.8]'
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.star, color: Colors.purpleAccent),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [Text('EXCELLENT'), Text('0.8 ~ 1.0')],
            ),
            style: ListTileStyle.drawer,
            onTap: () {
              Get.to(() => const ChunksPage(), arguments: {
                'query': Get.find<ChunkRepository>().excellent,
                'title': 'Excellent (0.8, 1.0]'
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.star, color: Colors.lightBlueAccent),
            tileColor: Colors.indigo,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [Text('GOD'), Text('1.0')],
            ),
            style: ListTileStyle.drawer,
            onTap: () {
              Get.to(() => const ChunksPage(), arguments: {
                'query': Get.find<ChunkRepository>().god,
                'title': '!!!GOD 1.0!!!'
              });
            },
          ),
        ],
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
