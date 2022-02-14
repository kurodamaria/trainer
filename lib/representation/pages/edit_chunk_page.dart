// import 'package:drift/drift.dart' hide Column;
// import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:drift/drift.dart' hide Column;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' hide Value;
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trainer/business_logic/edit_chunk/edit_chunk_bloc.dart';
import 'package:trainer/data/provider/chunker.dart';
import 'package:trainer/tools/io.dart';
import 'package:trainer/widgets/confirm_dialog.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart' hide Value;
// import 'package:trainer/business_logic/chunk/chunk_bloc.dart';
// import 'package:trainer/data/provider/chunker.dart';
// import 'package:trainer/data/repository/chunk_repository.dart';
// import 'package:trainer/tools/io.dart';
// import 'package:trainer/widgets/confirm_dialog.dart';

class EditChunkPage extends StatelessWidget {
  const EditChunkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditChunkBloc(Get.arguments['chunk']),
      child: const _Body(),
    );
  }

  static Future<ChunksCompanion?>? ofChunk(ChunksCompanion chunk) {
    return Get.to(
      () => const EditChunkPage(),
      arguments: {'chunk': chunk},
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final bloc = context.read<EditChunkBloc>();
        if (bloc.state is StateEditChunkModified) {
          return await Get.dialog(const ConfirmDialog(
            msg: 'All unsaved changes will be lost.',
            action: 'Back & Lose',
          ));
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add new chunk'),
          actions: const [_SaveAction()],
        ),
        body: ListView(
          children: const [
            _ContentEditor(),
            _ReferenceEditor(),
            _ChunkMonitor(),
            _ImageEditor()
          ],
        ),
      ),
    );
  }
}

class _ChunkMonitor extends StatelessWidget {
  const _ChunkMonitor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditChunkBloc, EditChunkState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [],
        );
      },
    );
  }
}

class _SaveAction extends StatelessWidget {
  const _SaveAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // context.read<EditChunkBloc>().add(EventEditChunkSave());
        final cm = context.read<EditChunkBloc>().state.companion;
        if (cm.reference.present && cm.reference.value.isNotEmpty) {
          Get.back(result: cm);
        } else {
          Get.snackbar('Cannot Save', 'You must fill the reference field.');
        }
      },
      icon: const Icon(Icons.save),
    );
  }
}

class _ContentEditor extends StatelessWidget {
  const _ContentEditor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.read<EditChunkBloc>().state;
    final controller =
        TextEditingController(text: state.companion.content.value);
    return TextField(
      decoration: const InputDecoration(labelText: 'Content'),
      controller: controller,
      minLines: 6,
      maxLines: 6,
      onChanged: (value) {
        debugPrint('Changed content: $value');
        final state = context.read<EditChunkBloc>().state;
        context.read<EditChunkBloc>().add(EventEditChunkModify(
            state.companion.copyWith(content: Value(value))));
      },
    );
  }
}

class _ReferenceEditor extends StatelessWidget {
  const _ReferenceEditor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.read<EditChunkBloc>().state;
    final controller = TextEditingController(
        text: state.companion.reference.present
            ? state.companion.reference.value
            : '');
    return TextField(
      decoration: const InputDecoration(labelText: 'Reference'),
      controller: controller,
      minLines: 1,
      maxLines: 1,
      onChanged: (value) {
        final state = context.read<EditChunkBloc>().state;
        context.read<EditChunkBloc>().add(EventEditChunkModify(
              state.companion.copyWith(reference: Value(value)),
            ));
      },
    );
  }
}

class _ImageEditor extends StatelessWidget {
  const _ImageEditor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditChunkBloc, EditChunkState>(
      builder: (context, state) {
        if (state.companion.image.value == null) {
          return Center(
            child: TextButton(
              onPressed: () {
                Get.bottomSheet(BlocProvider.value(
                  value: context.read<EditChunkBloc>(),
                  child: const _BottomSheetContainer(child: _AddImageActions()),
                ));
              },
              child: const Text('Add Image...'),
            ),
          );
        } else {
          return const _ImageReplacer();
        }
      },
    );
  }
}

class _AddImageActions extends StatelessWidget {
  const _AddImageActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        _AddImageFromCameraAction(),
        _AddImageFromFileAction(),
      ],
    );
  }
}

class _ImageReplacer extends StatelessWidget {
  const _ImageReplacer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Image.asset('assets/images/image_example_extreme.png'),
        BlocBuilder<EditChunkBloc, EditChunkState>(
          buildWhen: (c1, c2) => c1.companion.image != c2.companion.image,
          builder: (context, state) {
            return Image.memory(
                context.read<EditChunkBloc>().state.companion.image.value!);
          },
        ),
        IconButton(
          icon: const Icon(Icons.more_vert),
          iconSize: 25,
          color: Colors.black,
          onPressed: () {
            Get.bottomSheet(BlocProvider.value(
              value: context.read<EditChunkBloc>(),
              child: const _BottomSheetContainer(
                child: _ImageReplacerActions(),
              ),
            ));
          },
          tooltip: 'Actions',
        ),
      ],
    );
  }
}

class _ImageReplacerActions extends StatelessWidget {
  const _ImageReplacerActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        _AddImageFromCameraAction(),
        Divider(),
        _AddImageFromFileAction(),
        Divider(),
        _DeleteImageAction(),
      ],
    );
  }
}

class _AddImageFromCameraAction extends StatelessWidget {
  const _AddImageFromCameraAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Camera...'),
      onTap: () async {
        // Capture a photo
        final XFile? photo =
            await Get.find<ImagePicker>().pickImage(source: ImageSource.camera);
        if (photo != null) {
          final compressed = await compressImage(File(photo.path));
          final bloc = context.read<EditChunkBloc>();
          if (compressed != null) {
            bloc.add(EventEditChunkModify(
                bloc.state.companion.copyWith(image: Value(compressed))));
            Get.back();
          } else {
            Get.snackbar('Pick Image Failed', 'Cannot Compress the image???');
          }

          // Get.to(() => _CropImagePage(file: File(photo.path)));
          // final bytes = await photo.readAsBytes();
          // final bloc = context.read<EditChunkBloc>();
          // bloc.add(EventEditChunkModify(
          //     bloc.state.companion.copyWith(image: Value(bytes))));
          // Get.back();
        }
        // final f = await pickAFile(type: FileType.image);
        // if (f != null) {
        //   final bytes = await f.readAsBytes();
        //   final bloc = context.read<EditChunkBloc>();
        //   bloc.add(EventEditChunkModify(
        //       bloc.state.companion.copyWith(image: Value(bytes))));
        //   Get.back();
        // }
      },
    );
  }
}

class _CropImagePage extends StatelessWidget {
  const _CropImagePage({Key? key, required this.file}) : super(key: key);

  final File file;

  @override
  Widget build(BuildContext context) {
    final cropKey = GlobalKey<CropState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop'),
      ),
      body: Crop(
        key: cropKey,
        image: FileImage(file),
        // aspectRatio: 4.0 / 3.0,
      ),
    );
  }
}

class _AddImageFromFileAction extends StatelessWidget {
  const _AddImageFromFileAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('File...'),
      onTap: () async {
        final file = await pickAFile(type: FileType.any);
        if (file != null) {
          final bytes = await file.readAsBytes();
          final bloc = context.read<EditChunkBloc>();
          bloc.add(EventEditChunkModify(
              bloc.state.companion.copyWith(image: Value(bytes))));
          Get.back();
        }
      },
    );
  }
}

class _DeleteImageAction extends StatelessWidget {
  const _DeleteImageAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Delete'),
      textColor: Colors.red,
      onTap: () {},
    );
  }
}

class _BottomSheetContainer extends StatelessWidget {
  const _BottomSheetContainer({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        // color: Colors.white
      ),
      padding: const EdgeInsets.all(8),
      child: child,
    );
  }
}
