import 'package:base_structure/general/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  onUpdateUserData(UserModel model){
    emit(UserUpdateState(model: model,changed: !state.changed));
  }

}
