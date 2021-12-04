import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'lang_event.dart';
part 'lang_state.dart';

class LangBloc extends Bloc<LangEvent, LangState> {
  LangBloc() : super(LangInitial());

  @override
  Stream<LangState> mapEventToState(
    LangEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
