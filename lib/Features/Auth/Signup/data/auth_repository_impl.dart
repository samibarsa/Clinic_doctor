import 'dart:developer';

import 'package:doctor_app/Features/Auth/Signup/domain/repos/auth_repository.dart';
import 'package:doctor_app/Features/wellcome/presentation/views/wellcome.dart';
import 'package:doctor_app/core/utils/navigator/navigator.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseClient supabaseClient;

  AuthRepositoryImpl(this.supabaseClient);

  @override
  Future<void> signUp(String email, String password) async {
    try {
      final AuthResponse response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw Exception("Failed to sign up");
      }
    } catch (e) {
      throw Exception('Error during sign up: $e');
    }
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      final AuthResponse response =
          await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw Exception("Failed to sign in");
      }
    } catch (e) {
      throw Exception('Error during sign in: $e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await supabaseClient.auth.signOut();
    } catch (e) {
      throw Exception('Error during sign out: $e');
    }
  }

  @override
  Future<void> ressetPassword(String email) async {
    try {
      final sentToken = await supabaseClient.auth.resetPasswordForEmail(email);
    } catch (e) {
      throw Exception('Error during resset password: $e');
    }
  }

  @override
  Future<void> verifyToken(
      String email, String token, BuildContext content) async {
    try {
      final response = await supabaseClient.auth
          .verifyOTP(type: OtpType.magiclink, email: email, token: token);
      // ignore: use_build_context_synchronously
      MovingNavigation.navTo(content, page: const WellcomeScrean());
      log('Provider token: ${response.session?.providerToken}');
    } catch (error) {
      
      log('Error: $error');
      throw Exception(error);
    }
  }
}
