import 'dart:developer';

import 'package:doctor_app/Features/Home/domain/Entites/doctor.dart';
import 'package:doctor_app/Features/Home/domain/Entites/examination.dart';
import 'package:doctor_app/Features/Home/domain/Entites/note.dart';
import 'package:doctor_app/Features/Home/domain/Entites/order.dart';
import 'package:doctor_app/Features/Home/domain/Entites/patient.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RemoteDataSource {
  final SupabaseClient supabase;

  RemoteDataSource(this.supabase);

  Future<Doctor> fetchAllDoctors() async {
    final response = await supabase.from('doctors').select().eq(
        'user_id',
        supabase.auth.currentUser!
            .id); // استعلام عن doctors حيث user_id متساوي مع userId
// استخدم execute() للحصول على بيانات Supabase

    // Cast the data to a List of dynamic

    // Convert the data to List<Doctor>
    return Doctor.fromJson(response[0]);
  }

  Future<List<Patient>> fetchAllPatients() async {
    try {
      final response = await supabase.from('patients').select();
      final List<dynamic> data = response;
      return data.map((item) => Patient.fromJson(item)).toList();
    } catch (e) {
      throw Exception('Failed to load patients: ${e.toString()}');
    }
    // استخدم execute() للحصول على بيانات Supabase

    // Handle the response to check for errors

    // Cast the data to a List of dynamic

    // Convert the data to List<Patient>
  }

  Future<List<Note>> fetchAllNotes() async {
    try {
      final response = await supabase.from('notes').select();

      // تأكد من أن البيانات ليست null واحتوائها على قائمة
      final List<dynamic> data = response as List<dynamic>;

      // تحويل البيانات إلى List<Note>
      return data.map((item) => Note.fromJson(item)).toList();
    } catch (e) {
      throw Exception('Failed to load notes: ${e.toString()}');
    }
  }

  Future<List<Order>> fetchAllOrders() async {
    try {
      final condition = await supabase
          .from('doctors')
          .select('doctor_id') // تم تصحيح الاسم هنا
          .eq('user_id', supabase.auth.currentUser!.id)
          .single();

      final response = await supabase
          .from('orders')
          .select('*, patients(patient_name), doctors(doctor_id)')
          .eq('doctor_id', condition['doctor_id']);

      log(response.toString());

      // تأكد من أن البيانات ليست null واحتوائها على قائمة
      final List<dynamic> data = response as List<dynamic>;

      // تحويل البيانات إلى List<Order>
      return data.map((item) => Order.fromJson(item)).toList();
    } catch (e) {
      throw Exception('Failed to load orders: ${e.toString()}');
    }
  }

  Future<List<Examination>> fetchAllExaminations() async {
    try {
      final response = await supabase.from('examinations').select();

      // تأكد من أن البيانات ليست null واحتوائها على قائمة
      final List<dynamic> data = response as List<dynamic>;

      // تحويل البيانات إلى List<Examination>
      return data.map((item) => Examination.fromJson(item)).toList();
    } catch (e) {
      throw Exception('Failed to load examinations: ${e.toString()}');
    }
  }
}
