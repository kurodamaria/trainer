import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:get/get.dart';
import 'package:trainer/widgets/loading_indicator.dart';

class Markdown extends StatelessWidget {
  const Markdown(this.markdown, {Key? key}) : super(key: key);

  final String markdown;

  @override
  Widget build(BuildContext context) {
    return TeXView(
      child: TeXViewDocument( markdown),
      renderingEngine: const TeXViewRenderingEngine.mathjax(),
      loadingWidgetBuilder: (_) => const Center(child: LoadingIndicator()),
      style: TeXViewStyle(
        contentColor: Get.theme.primaryColor,
        backgroundColor: Get.theme.backgroundColor,
      ),
    );
  }
}
