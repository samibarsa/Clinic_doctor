import 'dart:developer';

import 'package:doctor_app/Features/Auth/domain/Entities/user.dart' as u;
import 'package:doctor_app/Features/Auth/domain/repo/auth_repository.dart';
import 'package:doctor_app/Features/wellcome/presentation/views/wellcome.dart';
import 'package:doctor_app/core/utils/navigator/navigator.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseClient supabaseClient;

  AuthRepositoryImpl(this.supabaseClient);

  @override
  Future<u.User> signUp(
      String email, String password, String doctorName, String phone) async {
    try {
      final AuthResponse response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw Exception("Failed to sign up");
      }

      // حفظ بيانات المستخدم في جدول users
      await supabaseClient.from('users').upsert({
        'user_id': response.user!.id,
        'role': 'Doctor',
        'email': email // تعيين الدور كـ doctor
      });

      // حفظ بيانات الدكتور في جدول doctor
      await supabaseClient.from('doctors').upsert({
        'user_id': response.user!.id, // ربط الدكتور بالمستخدم عبر user_id
        'doctor_name': doctorName,
        'phone_number': phone,
      });

      return u.User(
        userId: response.user!.id,
        role: 'Doctor',
      );
    } catch (e) {
      throw Exception('Error during sign up: $e');
    }
  }

  @override
  Future<u.User> signIn(String email, String password) async {
    try {
      final AuthResponse response =
          await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw Exception("Failed to sign in");
      }

      // حفظ بيانات المستخدم في قاعدة البيانات إذا لم يكن موجودًا
      await supabaseClient.from('users').upsert(
          {'user_id': response.user!.id, 'role': 'Doctor', 'email': email});

      // تعبئة كائن User وإرجاعه
      return u.User(
        userId: response.user!.id,
        role: 'Doctor',
      );
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
      await supabaseClient.auth.resetPasswordForEmail(email);
    } catch (e) {
      throw Exception('Error during reset password: $e');
    }
  }

  @override
  Future<void> verifyToken(
      String email, String token, BuildContext context) async {
    try {
      final response = await supabaseClient.auth
          .verifyOTP(type: OtpType.magiclink, email: email, token: token);
      // ignore: use_build_context_synchronously
      MovingNavigation.navTo(context, page: const WellcomeScrean());
      log('Provider token: ${response.session?.providerToken}');
    } catch (error) {
      log('Error: $error');
      throw Exception(error);
    }
  }
}
