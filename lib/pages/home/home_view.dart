import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainer/app/routes.dart';
import 'package:trainer/models/models.dart';
import 'package:trainer/tools/chunk_filters.dart';
import 'package:trainer/widgets/add_floating_action_button.dart';
import 'package:trainer/widgets/export_import_dialog.dart';
import 'package:trainer/widgets/hive_box_list_builder.dart';
import 'package:trainer/widgets/number_input_dialog.dart';
import 'package:trainer/widgets/subjects.dart';
import 'package:trainer/widgets/text_input_dialog.dart';

import 'home_logic.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final logic = Get.find<HomeLogic>();
  final state = Get.find<HomeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return Text(state.currentPageTitle.value);
        }),
        actions: const [_ExportAsJson(), _SortByAction()],
      ),
      body: PageView(
        children: [
          CollectionsView(),
          const _SearchPage(),
          const _StatisticsPage(),
        ],
        physics: const NeverScrollableScrollPhysics(),
        controller: state.pageController,
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: state.currentIndex.value,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.graphic_eq), label: 'Statistics')
          ],
          onTap: (page) {
            logic.toPage(page);
          },
        );
      }),
      drawer: HomeViewDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: AddFloatingActionButton(
        onPressed: _createANewCollection,
        toolTip: 'Create a new collection',
      ),
    );
  }

  Future<void> _createANewCollection() async {
    final result = await Get.dialog(const TextInputDialog(labels: ['Name']));
    if (result != null) {
      await logic.addNewCollection(name: result[0]);
    }
  }
}

class HomeViewDrawer extends StatelessWidget {
  const HomeViewDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(child: Container(color: Colors.blue)),
          ListTile(
            title: Text('Settings'),
            onTap: () {
              Get.toNamed(Routes.settingsPage.name);
            },
          ),
        ],
      ),
    );
  }
}

class CollectionsView extends StatelessWidget {
  CollectionsView({Key? key}) : super(key: key);

  final logic = Get.find<HomeLogic>();
  final state = Get.find<HomeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return HiveBoxListBuilder<Subject>(
      itemBuilder: (context, index, item) => Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: SubjectView(subject: item),
      ),
      boxName: state.subjectBox.name,
    );
  }
}

class _SearchPage extends StatelessWidget {
  const _SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const CupertinoScrollBehavior(),
      child: ListView(
        children: [
          ListTile(
            title: const Text('All Marked'),
            leading: const Icon(Icons.search, color: Colors.lightBlueAccent),
            onTap: () {
              final logic = Get.find<HomeLogic>();
              Get.toNamed(
                Routes.searchPage.name,
                arguments: {
                  'chunkBoxes': logic.state.subjectBox.values
                      .map((e) => e.chunkBoxName)
                      .toList(),
                  'matcher': ChunkFilters.onlyMarkedFilter,
                },
              );
            },
          ),
          ListTile(
            title: const Text('Has Math'),
            leading: const Icon(Icons.search, color: Colors.lightBlueAccent),
            onTap: () {
              final logic = Get.find<HomeLogic>();
              Get.toNamed(
                Routes.searchPage.name,
                arguments: {
                  'chunkBoxes': logic.state.subjectBox.values
                      .map((e) => e.chunkBoxName)
                      .toList(),
                  'matcher': ChunkFilters.hasMathjax,
                },
              );
            },
          ),
          ListTile(
            title: const Text('Has Content...'),
            leading: const Icon(Icons.search, color: Colors.lightBlueAccent),
            onTap: () {
              if (!Get.isSnackbarOpen) {
                Get.rawSnackbar(message: 'Not implemented yet.');
              }
            },
          ),
          ListTile(
            title: const Text('Days Ago...'),
            leading: const Icon(Icons.search, color: Colors.lightBlueAccent),
            onTap: () async {
              final number = await Get.dialog(
                NumberInputDialog(min: 0, max: double.infinity),
              ) as int;

              if (!number.isNaN) {
                final logic = Get.find<HomeLogic>();
                Get.toNamed(
                  Routes.searchPage.name,
                  arguments: {
                    'chunkBoxes': logic.state.subjectBox.values
                        .map((e) => e.chunkBoxName)
                        .toList(),
                    'matcher': (chunk) {
                      return ChunkFilters.nDaysAgo(chunk, number);
                    },
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class _StatisticsPage extends StatelessWidget {
  const _StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Statistics'),
    );
  }
}

class _ExportAsJson extends StatelessWidget {
  const _ExportAsJson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.dialog(const ExportImportDialog());
      },
      icon: const Icon(Icons.import_export),
      tooltip: 'Export as/Import from json',
    );
  }
}

class _SortByAction extends StatelessWidget {
  const _SortByAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(Icons.sort),
    );
  }
}
