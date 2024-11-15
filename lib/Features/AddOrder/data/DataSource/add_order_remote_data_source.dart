// ignore_for_file: avoid_print

import 'package:supabase_flutter/supabase_flutter.dart';

class AddOrderRemoteDataSource {
  final SupabaseClient supabase;

  AddOrderRemoteDataSource({required this.supabase});

  Future<void> addPatient(Map<String, dynamic> json) async {
    try {
      await supabase.from('patients').upsert(json);
    } catch (e) {
      if (e is PostgrestException && e.code == '23505') {
        throw Exception('اسم المريض موجود بالفعل. يرجى اختيار اسم آخر.');
      } else {
        throw Exception('حدث خطأ غير متوقع: ${e.toString()}');
      }
    }
  }
}
