import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'lang_state.dart';

class LangCubit extends Cubit<LangState> {
  LangCubit() : super(LangInitialState());

  onChangeLanguage(String lang){
    emit(LangUpdateState(lang));
  }

}
