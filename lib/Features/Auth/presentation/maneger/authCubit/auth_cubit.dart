import 'package:doctor_app/Features/Auth/domain/usecase/usecacses.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;
  final RessetPasswordUseCase ressetPasswordUseCase;
  final SignOutUseCase signOutUseCase;
  final VerifyTokenUseCase verifyTokenUseCase;

  AuthCubit({
    required this.verifyTokenUseCase,
    required this.signUpUseCase,
    required this.ressetPasswordUseCase,
    required this.signInUseCase,
    required this.signOutUseCase,
  }) : super(AuthInitial());

  // عملية التسجيل
  Future<void> signUp(
      String email, String password, String doctorName, String phone) async {
    emit(AuthLoading());
    try {
      await signUpUseCase.call(email, password, doctorName, phone);
      emit(AuthSuccess());
    } catch (e) {
      String errorMessage = 'حدث خطأ غير متوقع. يرجى المحاولة لاحقًا.';
      if (e.toString().contains('User already exists')) {
        errorMessage =
            'هذا البريد الإلكتروني مسجل بالفعل. يرجى استخدام بريد إلكتروني آخر.';
      } else if (e.toString().contains('weak password')) {
        errorMessage = 'كلمة المرور ضعيفة. يرجى استخدام كلمة مرور أقوى.';
      }
      emit(AuthFailure(errorMessage));
    }
  }

  // عملية تسجيل الدخول
  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      await signInUseCase.call(email, password);
      emit(AuthSuccess());
    } catch (e) {
      String errorMessage = 'حدث خطأ غير متوقع. يرجى المحاولة لاحقًا.';
      if (e.toString().contains('Invalid login credentials')) {
        errorMessage =
            'بيانات تسجيل الدخول غير صحيحة. يرجى التحقق من البريد الإلكتروني وكلمة المرور.';
      } else if (e.toString().contains('Network request failed')) {
        errorMessage = 'لا يوجد اتصال بالإنترنت';
      }
      emit(AuthFailure(errorMessage));
    }
  }

  // عملية تسجيل الخروج
  Future<void> signOut() async {
    emit(AuthLoading());
    try {
      await signOutUseCase.call();
      emit(AuthLoggedOut());
    } catch (e) {
      String errorMessage =
          'حدث خطأ غير متوقع أثناء تسجيل الخروج. يرجى المحاولة لاحقًا.';
      emit(AuthFailure(errorMessage));
    }
  }

  Future<void> ressetPassword(String email) async {
    emit(AuthLoading());
    try {
      await ressetPasswordUseCase.call(email);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString().split(":")[3]));
    }
  }
}

class VerifyCubit extends Cubit<VerifyState> {
  final VerifyTokenUseCase verifyTokenUseCase;
  VerifyCubit({required this.verifyTokenUseCase}) : super(VerifyInitial());
  Future<void> verifyToken(
      String email, String token, BuildContext context) async {
    emit(VerifyLoading());
    try {
      await verifyTokenUseCase.call(email, token, context);
      emit(VerifySuccess());
    } catch (e) {
      e.toString().split(":")[2].split(",")[0] ==
          "Token has expired or is invalid";
      emit(VerifyFailure("الرمز غير صحيح أو منتهي الصلاحية"));
    }
  }
}
