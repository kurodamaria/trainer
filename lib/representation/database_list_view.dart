import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:trainer/widgets/loading_indicator.dart';

enum DatabaseViewType { watch, get }

typedef IndexedWithItemWidgetBuilder<T> = Widget Function(
    BuildContext context, int index, T item);

class DatabaseListView<T> extends StatelessWidget {
  const DatabaseListView({
    Key? key,
    required this.query,
    this.viewType = DatabaseViewType.watch,
    required this.itemBuilder,
    this.separatorBuilder,
    this.shrinkWrap = true,
    this.onEmpty,
  }) : super(key: key);

  final MultiSelectable<T> query;

  final DatabaseViewType viewType;

  final IndexedWithItemWidgetBuilder<T> itemBuilder;

  final IndexedWithItemWidgetBuilder? separatorBuilder;

  final WidgetBuilder? onEmpty;

  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    switch (viewType) {
      case DatabaseViewType.watch:
        return _viewTypeWatch(context);
      case DatabaseViewType.get:
        return _viewTypeGet(context);
    }
  }

  Widget _viewTypeWatch(BuildContext context) {
    return StreamBuilder<List<T>>(
      stream: query.watch(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _listView(context, snapshot.data!);
        } else if (snapshot.hasError) {
          return _error(snapshot.error);
        } else {
          return _loadingIndicator();
        }
      },
    );
  }

  Widget _viewTypeGet(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: query.get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return _listView(context, snapshot.data!);
          } else if (snapshot.hasError) {
            return _error(snapshot.error);
          }
        }
        return _loadingIndicator();
      },
    );
  }

  Widget _listView(BuildContext context, List<T> items) {
    if (separatorBuilder != null) {
      return Scrollbar(
        child: ListView.separated(
          itemBuilder: (context, index) =>
              itemBuilder(context, index, items[index]),
          separatorBuilder: (context, index) =>
              separatorBuilder!.call(context, index, items[index]),
          itemCount: items.length,
          shrinkWrap: shrinkWrap,
        ),
      );
    } else {
      return Scrollbar(
        child: ListView.builder(
          itemBuilder: (context, index) =>
              itemBuilder(context, index, items[index]),
          itemCount: items.length,
          shrinkWrap: shrinkWrap,
        ),
      );
    }
  }

  Widget _loadingIndicator() {
    return const Center(child: LoadingIndicator());
  }

  Widget _error(Object? error) {
    return Center(child: Text('$error'));
  }
}
