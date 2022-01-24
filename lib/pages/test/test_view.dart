import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:get/get.dart';

import 'test_logic.dart';

class Chunk {
  final String front;
  final String refs;
  final List<String> hints;

  Chunk({
    required this.front,
    required this.refs,
    required this.hints,
  });
}

class TestPage extends StatelessWidget {
  TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chunk = Chunk(
      front: r'求$$\frac{dy}{dx}+y\sin x=0$$的通解',
      refs: '364 9.1.3',
      hints: [r'$$g(y)dy=f(x)dx$$', r'$$\frac{1}{y}dy=-\sin xdx$$'],
    );

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          _ChunkSimpleView(chunk: chunk),
          _ChunkSimpleView(chunk: chunk),
          _ChunkSimpleView(chunk: chunk),
          _ChunkSimpleView(chunk: chunk),
          _ChunkSimpleView(chunk: chunk),
          _ChunkSimpleView(chunk: chunk),
          _ChunkSimpleView(chunk: chunk),
          _ChunkSimpleView(chunk: chunk),
          _ChunkSimpleView(chunk: chunk),
        ],
      ),
    );
  }
}

class _ChunkSimpleView extends StatelessWidget {
  const _ChunkSimpleView({Key? key, required this.chunk}) : super(key: key);

  final Chunk chunk;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: TeXView(
          child: TeXViewMarkdown(chunk.front),
          style: TeXViewStyle(),
        ),
        onTap: () {
          Get.to(() => _ChunkVie(chunk: chunk));
        },
      ),
    );
  }
}

class _ChunkVie extends StatelessWidget {
  const _ChunkVie({Key? key, required this.chunk}) : super(key: key);

  final Chunk chunk;

  @override
  Widget build(BuildContext context) {
    final showHints = false.obs;
    return Scaffold(
      appBar: AppBar(title: Text('Chunk View')),
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString('assets/raw/test.md'),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final data = snapshot.data!;
              final lineSplitter = LineSplitter();
              final split = lineSplitter.convert(data);
              final chunkList = <List<String>>[];
              for (final s in split) {
                if (s.startsWith('-')) {
                  chunkList.add([]);
                }
                chunkList.last.add(s);
              }
              return ListView.separated(
                itemBuilder: (c, i) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Card(
                      child: TeXView(
                        child: TeXViewMarkdown(
                          chunkList[i][0],
                        ),
                      ),
                    ),
                    if (chunkList[i].length > 1)
                      Card(
                        child: TeXView(
                          child: TeXViewMarkdown(chunkList[i].sublist(1).reduce(
                              (value, element) => '$value\n\n$element')),
                        ),
                      )
                  ],
                ),
                itemCount: chunkList.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(height: 30);
                },
              );
            }
          }
          return Text('${snapshot.data}');
        },
      ),
      // body: Column(
      //   children: [
      //     TeXView(
      //       child: TeXViewMarkdown(chunk.front),
      //       style: TeXViewStyle(padding: TeXViewPadding.all(16)),
      //     ),
      //     Text('Ref: ${chunk.refs}'),
      //     TextButton(
      //       onPressed: () {
      //         showHints.value = !showHints.value;
      //       },
      //       child: Text('Toggle hints'),
      //     ),
      //     Obx(() {
      //       return showHints.value ? _HintsView(chunk: chunk) : SizedBox();
      //     })
      //   ],
      // ),
    );
  }
}

class _HintsView extends StatelessWidget {
  const _HintsView({Key? key, required this.chunk}) : super(key: key);

  final Chunk chunk;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return TeXView(
          child: TeXViewMarkdown(chunk.hints[index]),
        );
      },
      itemCount: chunk.hints.length,
      separatorBuilder: (BuildContext context, int index) =>
          Divider(color: Colors.black),
    );
  }
}
