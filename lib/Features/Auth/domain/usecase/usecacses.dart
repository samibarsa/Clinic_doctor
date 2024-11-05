import 'package:doctor_app/Features/Auth/domain/repo/auth_repository.dart';
import 'package:flutter/widgets.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<void> call(String email, String password) {
    return repository.signUp(email, password);
  }
}

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<void> call(String email, String password) {
    return repository.signIn(email, password);
  }
}

class SignOutUseCase {
  final AuthRepository repository;

  SignOutUseCase(this.repository);

  Future<void> call() {
    return repository.signOut();
  }
}

class RessetPasswordUseCase {
  final AuthRepository repository;

  RessetPasswordUseCase(this.repository);

  Future<void> call(String email) {
    return repository.ressetPassword(email);
  }
}

class VerifyTokenUseCase {
  final AuthRepository repository;

  VerifyTokenUseCase(this.repository);

  Future<void> call(String email, String token, BuildContext context) {
    return repository.verifyToken(email, token, context);
  }
}
