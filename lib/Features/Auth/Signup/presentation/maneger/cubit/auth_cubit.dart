// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:doctor_app/Features/Auth/Signup/domain/usecases/sign_up.dart';
import 'package:equatable/equatable.dart';


abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure(this.error);

  @override
  List<Object> get props => [error];
}

class AuthLoggedOut extends AuthState {}