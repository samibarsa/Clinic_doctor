// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {
  final bool isFromSignUp;

  AuthSuccess({required this.isFromSignUp});
}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure(this.error);

  @override
  List<Object> get props => [error];
}

class AuthLoggedOut extends AuthState {}

class VerifyState extends Equatable {
  @override
  List<Object> get props => [];
}

class VerifyInitial extends VerifyState {}

class VerifyLoading extends VerifyState {}

class VerifyFailure extends VerifyState {final String error;

  VerifyFailure(this.error);

  @override
  List<Object> get props => [error];}

class VerifySuccess extends VerifyState {}
