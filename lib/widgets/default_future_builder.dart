import 'package:flutter/material.dart';
import 'package:trainer/widgets/error_box.dart';

class DefaultFutureBuilder<T> extends StatelessWidget {
  const DefaultFutureBuilder({Key? key, required this.builder, required this.future}) : super(key: key);

  final Widget Function(BuildContext, T) builder;
  final Future<T> future;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return builder(context, snapshot.data!);
          } else {
            return const ErrorBox(title: 'Error', message: 'Sorry');
          }
        }
        return const SizedBox();
      },
    );
  }
}
