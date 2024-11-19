// ignore_for_file: file_names

import 'package:supabase_flutter/supabase_flutter.dart';

class AddPatientRemoteDataSource {
  final SupabaseClient supabase;

  AddPatientRemoteDataSource({required this.supabase});

  Future<int> addPatient(Map<String, dynamic> json) async {
    try {
      final response = await supabase
          .from('patients')
          .insert(json)
          .select('*') // تحديد الـ patient_id لاسترجاعه بعد الإدراج
          .single();
      return response['patient_id'] as int; // استرجاع سجل واحد فقط
      // إرجاع الـ patient_id بعد الإدراج
    } catch (e) {
      if (e is PostgrestException && e.code == '23505') {
        throw Exception('اسم المريض موجود بالفعل. يرجى اختيار اسم آخر.');
      } else {
        throw Exception('حدث خطأ غير متوقع: ${e.toString()}');
      }
    }
  }
}
