// ignore_for_file: avoid_print

import 'package:supabase_flutter/supabase_flutter.dart';

class AddOrderRemoteDataSource {
  final Supabase supabase;

  AddOrderRemoteDataSource({required this.supabase});
  Future<void> addPatient(Map<String, dynamic> json) async {
    try {
      await supabase.client.from('patients').upsert(json);
    } catch (e) {
      if (e is PostgrestException && e.code == '23505') {
        throw Exception(
            'Patient name already exists. Please choose a different name.');
      } else {
        throw Exception('An unexpected error occurred: ${e.toString()}');
      }
    }
  }
}
