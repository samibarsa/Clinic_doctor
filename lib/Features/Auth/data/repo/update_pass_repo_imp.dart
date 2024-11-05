import 'package:doctor_app/Features/Auth/domain/repo/update_pass_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UpdatePasswordRepoImp implements UpdatePasswordRepo {
  final SupabaseClient supabaseClient;

  UpdatePasswordRepoImp({required this.supabaseClient});
  @override
  Future<void> updatePassword(String password) async {
    try {
      await supabaseClient.auth.updateUser(UserAttributes(
        password: password,
      ));
    } catch (e) {
      throw Exception(e);
    }
  }
}
