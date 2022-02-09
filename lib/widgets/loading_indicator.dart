import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key, this.color}) : super(key: key);

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator(
      color: color ?? Get.theme.primaryColor,
    );
  }
}
