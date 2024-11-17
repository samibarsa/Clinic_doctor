part of 'addorder_cubit.dart';

abstract class AddorderState extends Equatable {
  const AddorderState();

  @override
  List<Object> get props => [];
}

class AddorderInitial extends AddorderState {}

class AddorderLoading extends AddorderState {}

class AddorderSucses extends AddorderState {}

class AddorderFailure extends AddorderState {
  final String errMessage;

  const AddorderFailure({required this.errMessage});
}
