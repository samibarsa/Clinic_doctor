// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:doctor_app/Features/Auth/domain/Entities/doctor.dart';
import 'package:doctor_app/Features/Home/data/local/local_data_source.dart';
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

    // استرجاع الطلبات باستخدام doctor_id واسترجاع التفاصيل المطلوبة
    final response = await Supabase.instance.client.from('orders').select('''
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

  Future<void> editOrder(
      {required String? selectedOutputType,
      required String selectedImageType,
      required String? selectedExaminationOption,
      required int orderId,
      required String additionalNotes}) async {
    try {
      final detilId = await LocalDataSource.getDetailId(
          selectedOutputType ?? "لا يوجد",
          selectedImageType,
          selectedExaminationOption!);
      Map<String, dynamic> newData = {
        'additional_notes': additionalNotes,
        'detiles_id': detilId
      };
      await updateOrderFields(orderId, newData);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
