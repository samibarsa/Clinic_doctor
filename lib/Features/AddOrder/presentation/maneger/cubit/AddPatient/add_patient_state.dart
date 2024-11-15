part of 'add_patient_cubit.dart';

sealed class AddPatientState extends Equatable {
  const AddPatientState();

  @override
  List<Object> get props => [];
}

final class AddPatientInitial extends AddPatientState {}

final class AddPatientSucsess extends AddPatientState {}

final class AddPatientError extends AddPatientState {
  final String errMessage;

  const AddPatientError({required this.errMessage});
}

final class AddPatientLoading extends AddPatientState {}
