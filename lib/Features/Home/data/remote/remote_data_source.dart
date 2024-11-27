import 'dart:io';

import 'package:doctor_app/Features/Auth/domain/Entities/doctor.dart';
import 'package:doctor_app/Features/Home/domain/Entites/order.dart';
import 'package:doctor_app/Features/Home/domain/Entites/patient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RemoteDataSource {
  final SupabaseClient supabase;

  RemoteDataSource(this.supabase);

  Future<Doctor> fetchAllDoctors() async {
    try {
      final response = await supabase
          .from('doctors')
          .select()
          .eq('user_id', supabase.auth.currentUser!.id);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('doctorId', response[0]['doctor_id']);
      return Doctor.fromJson(response[0]);
    } on SocketException catch (_) {
      throw Exception('لا يوجد اتصال بالإنترنت');
    } catch (e) {
      throw Exception('فشل في تحميل بيانات الأطباء: ${e.toString()}');
    }
  }

  Future<List<Patient>> fetchAllPatients() async {
    try {
      final response = await supabase.from('patients').select();
      final List<dynamic> data = response;
      return data.map((item) => Patient.fromJson(item)).toList();
    } on SocketException catch (_) {
      throw Exception('لا يوجد اتصال بالإنترنت');
    } catch (e) {
      throw Exception('فشل في تحميل بيانات المرضى: ${e.toString()}');
    }
  }

  Future<List<Order>> fetchAllOrders() async {
    try {
      final condition = await Supabase.instance.client
          .from('doctors')
          .select('doctor_id')
          .eq('user_id', Supabase.instance.client.auth.currentUser!.id)
          .single();
      // ignore: unnecessary_null_comparison
      if (condition == null || condition['doctor_id'] == null) {
        throw Exception('لم يتم العثور على الطبيب.');
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

      // ignore: unnecessary_null_comparison
      if (response == null || response.isEmpty) {
        throw Exception('لم يتم العثور على طلبات لهذا الطبيب.');
      }

      final orders = response.map((item) => Order.fromJson(item)).toList();
      return orders;
    } on SocketException catch (_) {
      throw Exception('لا يوجد اتصال بالإنترنت');
    } catch (e) {
      throw Exception('فشل في تحميل الطلبات: ${e.toString()}');
    }
  }
}
