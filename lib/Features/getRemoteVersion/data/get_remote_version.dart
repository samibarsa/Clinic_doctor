import 'package:supabase_flutter/supabase_flutter.dart';

class GetRemoteVersion {
  final SupabaseClient supabaseClient;

  GetRemoteVersion({required this.supabaseClient});
  Future<String> getRemoteVersion() async {
    final version = await supabaseClient.from("app_version").select();
    return version.last['version'];
  }
}
