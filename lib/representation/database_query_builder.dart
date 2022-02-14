import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

class DatabaseMultiQueryFutureBuilder<T> extends StatelessWidget {
  const DatabaseMultiQueryFutureBuilder(
      {Key? key, required this.query, required this.builder})
      : super(key: key);

  final MultiSelectable<T> query;

  final AsyncWidgetBuilder<List<T>> builder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      builder: builder,
      future: query.get(),
    );
  }
}

class DatabaseSingleQueryFutureBuilder<T> extends StatelessWidget {
  const DatabaseSingleQueryFutureBuilder(
      {Key? key, required this.query, required this.builder})
      : super(key: key);

  final SingleSelectable<T> query;

  final AsyncWidgetBuilder<T> builder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      builder: builder,
      future: query.getSingle(),
    );
  }
}
