// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:doctor_app/Features/AddOrder/domain/usecase/add_patient_usecase.dart';
import 'package:doctor_app/Features/AddOrder/presentation/maneger/cubit/cubit/add_patient_state.dart';

class AddPatientCubit extends Cubit<AddPatientState> {
  AddPatientCubit(this.addPatientUsecase) : super(AddPatientInitial());
  final AddPatientUsecase addPatientUsecase;
  Future<void> addPatient(Map<String, dynamic> json) async {
    emit(AddPatientLoading());
    try {
      await addPatientUsecase(json);
      emit(AddPatientSucsess());
    } catch (e) {
      emit(AddPatientError(errMessage: e.toString()));
    }
  }
}
