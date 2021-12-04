part of 'setting_cubit.dart';

abstract class SettingState extends Equatable {
  final bool changed;
  final SettingModel setting;
  const SettingState({this.changed, this.setting});
}

class SettingInitial extends SettingState {
  SettingInitial({bool changed, SettingModel setting})
      : super(changed: false, setting: null);
  @override
  List<Object> get props => [];
}

class SettingUpdateState extends SettingState {
  SettingUpdateState(bool changed, SettingModel setting)
      : super(changed: changed, setting: setting);
  @override
  List<Object> get props => [changed, setting];
}
