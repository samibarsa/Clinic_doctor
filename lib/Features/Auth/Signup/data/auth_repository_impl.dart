import 'package:doctor_app/Features/Auth/Signup/domain/repos/auth_repository.dart';
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
      final AuthResponse response = await supabaseClient.auth.signInWithPassword(
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
}
