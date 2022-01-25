import 'package:flutter/material.dart';
import 'package:trainer/widgets/markdown.dart';

class MarkdownCard extends StatelessWidget {
  const MarkdownCard(this.markdown, {Key? key}) : super(key: key);

  final String markdown;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Markdown(markdown),
      ),
    );
  }
}
