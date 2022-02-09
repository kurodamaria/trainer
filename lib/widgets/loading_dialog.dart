import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainer/widgets/loading_indicator.dart';

class LoadingDialog extends StatefulWidget {
  LoadingDialog({Key? key, required this.future}) : super(key: key);

  final Future future;
  final Completer _completer = Completer();

  @override
  State<LoadingDialog> createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return widget._completer.isCompleted;
      },
      child: const Dialog(
        child: LoadingIndicator(color: Colors.greenAccent),
        backgroundColor: Colors.transparent,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.future.whenComplete(() {
      widget._completer.complete();
    });
    widget._completer.future.whenComplete(() {
      Get.back();
    });
  }
}

/// Display an loading overlay until the future finishes.
void showLoadingDialog({required Future future}) {
  Get.dialog(
    LoadingDialog(future: future),
    barrierDismissible: false,
  );
}
