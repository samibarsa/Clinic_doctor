part of 'add_patient_cubit_cubit.dart';

sealed class AddPatientState {
  const AddPatientState();

  @override
  List<Object> get props => [];
}

final class AddPatientInitial extends AddPatientState {}

final class AddPatientLoading extends AddPatientState {}

final class AddPatientError extends AddPatientState {
  final String errMessage;

  const AddPatientError({required this.errMessage});
}

final class AddPatientSucsess extends AddPatientState {}
