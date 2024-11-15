// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:doctor_app/Features/AddOrder/domain/usecase/add_patient_usecase.dart';
import 'package:equatable/equatable.dart';

part 'add_patient_state.dart';

class AddPatientCubit extends Cubit<AddPatientState> {
  final AddPatientUsecase addPatientUsecase;

  AddPatientCubit(this.addPatientUsecase) : super(AddPatientInitial());

  Future<void> addPatient(Map<String, dynamic> json) async {
    emit(AddPatientLoading());
    try {
      await addPatientUsecase.addPatient(json);
      emit(AddPatientSucsess());
    } catch (e) {
      emit(AddPatientError(errMessage: e.toString()));
    }
  }
}
