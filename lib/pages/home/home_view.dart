import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainer/models/models.dart';
import 'package:trainer/widgets/add_floating_action_button.dart';
import 'package:trainer/widgets/hive_box_list_builder.dart';
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
      ),
      body: PageView(
        children: [
          CollectionsView(),
          Container(
              color: Colors.lightGreen,
              child: const Center(child: const Text('Search'))),
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
        child: Column(
          children: [
            Image.network(
                'https://i.pinimg.com/originals/e7/83/ee/e783ee52b161fcc921e664db12804e0a.gif'),
            const Divider(indent: 30, color: Colors.black, endIndent: 30),
            const Text('What do you want?'),
          ],
        ),
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
      itemBuilder: (context, index, item) => SubjectView(subject: item),
      boxName: state.subjectBox.name,
    );
  }
}
