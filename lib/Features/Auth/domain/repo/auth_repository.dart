import 'package:flutter/widgets.dart';

abstract class AuthRepository {
  Future<void> signUp(
      String email, String password, String doctorName, String phone);
  Future<void> signIn(String email, String password);
  Future<void> ressetPassword(String email);
  Future<void> verifyToken(String email, String token, BuildContext content);
  Future<void> signOut();
}
