import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainer/app/routes.dart';
import 'package:trainer/models/models.dart';
import 'package:trainer/pages/subject/subject_logic.dart';
import 'package:trainer/pages/subjects/subjects_logic.dart';
import 'package:trainer/tools/chunk_filters.dart';
import 'package:trainer/widgets/add_floating_action_button.dart';
import 'package:trainer/widgets/hive_box_list_builder.dart';
import 'package:trainer/widgets/subjects.dart';
import 'package:trainer/widgets/switch_with_description.dart';
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
      ),
      body: PageView(
        children: [
          CollectionsView(),
          _SearchPage(),
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
          ],
          onTap: (page) {
            logic.toPage(page);
          },
        );
      }),
      drawer: Drawer(
        child: Image.network(
            'https://1.bp.blogspot.com/-hYRxrYJULNs/WyCTVJIMDVI/AAAAAAABN7Q/cAcXqxiE3cs9qYB0EgVc1N_bEuhHRsEhQCKgBGAs/s1600/Omake%2BGif%2BAnime%2B-%2BUma%2BMusume%2B-%2BPretty%2BDerby%2B-%2BEpisode%2B12%2B-%2BSilence%2BSuzuka%2BSends%2BEnergy%2BToo.gif'),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
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
      behavior: CupertinoScrollBehavior(),
      child: ListView(
        children: [
          ListTile(
            title: Text('All Marked'),
            leading: Icon(Icons.star, color: Colors.yellow),
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
            title: Text('Content'),
            leading: Icon(Icons.star, color: Colors.yellow),
            onTap: () {
              if (!Get.isSnackbarOpen) {
                Get.rawSnackbar(message: 'Not implemented yet.');
              }
            },
          ),
          ListTile(
            title: Text('Tag'),
            leading: Icon(Icons.star, color: Colors.yellow),
            onTap: () {
              if (!Get.isSnackbarOpen) {
                Get.rawSnackbar(message: 'Not implemented yet.');
              }
            },
          ),
        ],
      ),
    );
  }
}
