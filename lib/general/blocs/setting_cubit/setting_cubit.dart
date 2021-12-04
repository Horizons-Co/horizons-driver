import 'package:base_structure/general/models/setting_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial(setting: null, changed: false));

  void onUpdateState(SettingModel settingModel) {
    emit(SettingUpdateState(!state.changed, settingModel));
  }
}
