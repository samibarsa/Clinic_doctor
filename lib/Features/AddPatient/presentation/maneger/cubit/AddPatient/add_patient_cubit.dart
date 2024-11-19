// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:doctor_app/Features/AddPatient/domain/usecase/add_patient_usecase.dart';
import 'package:doctor_app/Features/AddPatient/presentation/maneger/cubit/AddPatient/add_patient_state.dart';

class AddPatientCubit extends Cubit<AddPatientState> {
  AddPatientCubit(this.addPatientUsecase) : super(AddPatientInitial());
  final AddPatientUsecase addPatientUsecase;

  Future<int> addPatient(Map<String, dynamic> json) async {
    emit(AddPatientLoading());
    try {
      final response = await addPatientUsecase(json);
      log(response.toString());
      emit(AddPatientSucsess(patientId: response));
      return response;
    } catch (e) {
      emit(AddPatientError(errMessage: e.toString().split(':')[1]));
      return 0;
    }
  }
}
