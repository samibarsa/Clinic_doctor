part of 'update_password_cubit.dart';

sealed class UpdatePasswordState extends Equatable {
  const UpdatePasswordState();

  @override
  List<Object> get props => [];
}

final class UpdatePasswordInitial extends UpdatePasswordState {}
final class UpdatePasswordLoading extends UpdatePasswordState {}
final class UpdatePasswordSucsess extends UpdatePasswordState {}
final class UpdatePasswordFailure extends UpdatePasswordState {
  final String errorMessage;

  const UpdatePasswordFailure({required this.errorMessage});
}
