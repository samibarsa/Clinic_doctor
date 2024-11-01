
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:doctor_app/Features/Auth/Login/domain/usecase/update_pass_usecase.dart';
import 'package:equatable/equatable.dart';

part 'update_password_state.dart';

class UpdatePasswordCubit extends Cubit<UpdatePasswordState> {
  UpdatePasswordCubit({required this.updatePassUsecase})
      : super(UpdatePasswordInitial());
  final UpdatePassUsecase updatePassUsecase;
  Future<void> updatePassword(String password) async {
    try {
      await updatePassUsecase.updatePassUsecase(password);
      emit(UpdatePasswordSucsess());
    } catch (e) {
      emit(UpdatePasswordFailure(errorMessage: e.toString()));
    }
  }
}
