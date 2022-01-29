import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotFound extends StatelessWidget {
  const NotFound({Key? key, this.msg}) : super(key: key);

  final String? msg;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/not_found.gif'),
          Text(msg ?? 'Not Found', style: Get.textTheme.headline5),
        ],
      ),
    );
  }
}
