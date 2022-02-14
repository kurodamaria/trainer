import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trainer/data/provider/chunker.dart';

part 'subject_event.dart';

part 'subject_state.dart';

class SubjectBloc extends Bloc<SubjectEvent, Subject> {
  SubjectBloc({required Subject subject}) : super(subject) {
    on<SubjectEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
