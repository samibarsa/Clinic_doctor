import 'dart:developer';

import 'package:doctor_app/Features/Auth/domain/Entities/doctor.dart';
import 'package:doctor_app/Features/Home/domain/Entites/examination.dart';
import 'package:doctor_app/Features/Home/domain/Entites/order.dart';
import 'package:doctor_app/Features/Home/domain/Entites/patient.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RemoteDataSource {
  final SupabaseClient supabase;

  RemoteDataSource(this.supabase);

  Future<Doctor> fetchAllDoctors() async {
    final response = await supabase
        .from('doctors')
        .select()
        .eq('user_id', supabase.auth.currentUser!.id);

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
    try {} catch (e) {} // التحقق من الـ doctor_id باستخدام user_id
    final condition = await Supabase.instance.client
        .from('doctors')
        .select('doctor_id')
        .eq('user_id', Supabase.instance.client.auth.currentUser!.id)
        .single();

    // التحقق إذا كانت البيانات قد استُرجعت بنجاح
    if (condition == null || condition['doctor_id'] == null) {
      throw Exception('Doctor not found');
    }

    // استرجاع الطلبات باستخدام doctor_id واسترجاع التفاصيل المطلوبة
    final response = await Supabase.instance.client.from('orders').select('''
        order_id,
        doctor_id,
        patient_id,
        date,
        patient_age,
        additional_notes,
        patients(patient_name),
        examinationdetails!inner(
          detail_id,
          mode:examinationmodes(mode_id, mode_name),
          option:examinationoptions(option_id, option_name),
          type:examinationtypes(examination_type_id, type_name)
        )
      ''').eq('doctor_id', condition['doctor_id']);

    // التأكد إذا كانت البيانات موجودة
    if (response == null || response.isEmpty) {
      throw Exception('No orders found for this doctor');
    }

    // تحويل البيانات المسترجعة إلى قائمة من كائنات Order باستخدام fromJson
    final orders = response.map((item) => Order.fromJson(item)).toList();

    log(orders.toString());
    return orders;
  }

  Future<Order> getOrderDetails(int orderId) async {
    try {
      final response = await supabase.from('orders').select('''
      order_id,
      doctor_id,
      patient_id,
      date,
      patient_age,
      additional_notes,
      examinationdetails!inner(
        detail_id,
        mode:examinationmodes(mode_id, mode_name),
        option:examinationoptions(option_id, option_name),
        type:examinationtypes(examination_type_id, type_name)
      )
    ''').eq('order_id', orderId).single();

      return Order.fromJson(response);
    } catch (e) {
      throw Exception(e);
    }
  }
}
