import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainer/models/models.dart';
import 'package:trainer/widgets/add_floating_action_button.dart';
import 'package:trainer/widgets/delete_by_dismiss_hive_box_item.dart';
import 'package:trainer/widgets/hive_box_list_builder.dart';
import 'package:trainer/widgets/search_button.dart';
import 'package:trainer/widgets/subjects.dart';
import 'package:trainer/widgets/text_input_dialog.dart';

import 'subjects_logic.dart';

class SubjectsPage extends StatelessWidget {
  SubjectsPage({Key? key}) : super(key: key);

  final logic = Get.find<SubjectsLogic>();
  final state = Get.find<SubjectsLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chunk Collections'),
        actions: [SearchButton()],
      ),
      body: PageView(
        children: [
          Center(child: Text('HOME')),
          Center(child: Text('Search')),
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
      // body: HiveBoxListBuilder<Subject>(
      //   boxName: state.subjects.name,
      //   itemBuilder: (c, index, item) => DeleteByDismissHiveBoxItem<Subject>(
      //     itemBuilder: (context, item) => SubjectView(subject: item),
      //     item: item,
      //   ),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Image.network('https://i.pinimg.com/originals/e7/83/ee/e783ee52b161fcc921e664db12804e0a.gif'),
            Divider(indent: 30, color: Colors.black, endIndent: 30),
            Text('What do you want?'),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: AddFloatingActionButton(
        onPressed: () async {
          final result =
              (await Get.dialog(const TextInputDialog(labels: ['Name'])))
                  as List<String>?;
          if (result != null) {
            final name = result[0];
            logic.addSubject(name);
          }
        },
      ),
    );
  }
}
