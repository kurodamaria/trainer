import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestPage extends StatelessWidget {
  TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.find<TestController>();
        },
      ),
    );
  }
}

class TestController extends GetxController {
  String text = '0123456789';

  void shuffleNumbers() {
    final list = text.split('');
    list.shuffle();
    text = list.join('');
    update();
  }
}
