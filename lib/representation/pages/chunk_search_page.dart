import 'package:flutter/material.dart';

class ChunkSearchPage extends StatelessWidget {
  const ChunkSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'SQL Query',
          ),
          minLines: 3,
          maxLines: 3,
        ),
        Expanded(
          child: ListView(
            children: [],
          ),
        ),
      ],
    );
  }
}
