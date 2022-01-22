import 'package:flutter/material.dart';
import 'package:trainer/models/models.dart';

class AttemptView extends StatelessWidget {
  const AttemptView({Key? key, required this.attempt}) : super(key: key);

  final Attempt attempt;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(attempt.memo),
    );
  }
}
