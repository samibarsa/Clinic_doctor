import 'package:equatable/equatable.dart';

sealed class AddPatientState extends Equatable {
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

final class AddPatientSucsess extends AddPatientState {
  final int patientId;

  const AddPatientSucsess({required this.patientId});
}
