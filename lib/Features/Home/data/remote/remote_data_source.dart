// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:doctor_app/Features/Auth/domain/Entities/doctor.dart';
import 'package:doctor_app/Features/Home/domain/Entites/order.dart';
import 'package:doctor_app/Features/Home/domain/Entites/patient.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class RemoteDataSource {
  final SupabaseClient supabase;

  RemoteDataSource(this.supabase);

  Future<Doctor> fetchAllDoctors() async {
    final response = await supabase
        .from('doctors')
        .select()
        .eq('user_id', supabase.auth.currentUser!.id);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('doctorId', response[0]['doctor_id']);
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
  }

  Future<List<Order>> fetchAllOrders() async {
    final condition = await Supabase.instance.client
        .from('doctors')
        .select('doctor_id')
        .eq('user_id', Supabase.instance.client.auth.currentUser!.id)
        .single();
    // التحقق إذا كانت البيانات قد استُرجعت بنجاح
    // ignore: unnecessary_null_comparison
    if (condition == null || condition['doctor_id'] == null) {
      throw Exception('Doctor not found');
    }

    final response = await Supabase.instance.client.from('orders').select('''
  order_id,
  doctor_id,
  patient_id,
  order_price,
  date,
  additional_notes,
  output:order_output(
    id,
    output_type,
    price
  ),
  examinationdetails!inner(
    detail_id,
    mode:examinationmodes(mode_id, mode_name),
    option:examinationoptions(option_id, option_name),
    type:examinationtypes(examination_type_id, type_name)
  )
''').eq('doctor_id', condition['doctor_id']);

    // التأكد إذا كانت البيانات موجودة
    // ignore: unnecessary_null_comparison
    if (response == null || response.isEmpty) {
      throw Exception('No orders found for this doctor');
    }

    // تحويل البيانات المسترجعة إلى قائمة من كائنات Order باستخدام fromJson
    final orders = response.map((item) => Order.fromJson(item)).toList();

    log(orders.toString());
    return orders;
  }

  Future<void> updateOrderFields(
      int orderId, Map<String, dynamic> fieldsToUpdate) async {
    final supabase = Supabase.instance.client;

    try {
      final updateResult = await supabase
          .from('orders')
          .update(fieldsToUpdate)
          .eq('order_id', orderId);

      if (updateResult.error != null) {
        throw Exception(
            'Failed to update fields: ${updateResult.error!.message}');
      } else {
        print('Fields updated successfully');
      }
    } catch (error) {
      print('Error updating fields: $error');
    }
  }
}
