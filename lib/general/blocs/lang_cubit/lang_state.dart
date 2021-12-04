part of 'lang_cubit.dart';

abstract class LangState extends Equatable {
  final String lang;
  const LangState({this.lang});
}

class LangInitialState extends LangState {
  LangInitialState():super(lang: "ar");
  @override
  List<Object> get props => [lang];
}

class LangUpdateState extends LangState {
  LangUpdateState(String lang):super(lang: lang);
  @override
  List<Object> get props => [lang];
}
