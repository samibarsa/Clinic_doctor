import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddOrderRemoteDataSource {
  final SupabaseClient supabaseClient;

  AddOrderRemoteDataSource({required this.supabaseClient});

  Future<int> getPrice(int detailId, String output) async {
    try {
      final detailPrice = await supabaseClient
          .from('examinationdetails')
          .select('price')
          .eq('detail_id', detailId)
          .single();
      final outputPrice = await supabaseClient
          .from('output')
          .select('price')
          .eq('output_type', output)
          .single();
      return (detailPrice['price'] as int) + (outputPrice['price'] as int);
    } on SocketException catch (_) {
      throw Exception('لا يوجد اتصال بالإنترنت');
    } catch (e) {
      throw Exception('حدث خطأ غير متوقع: ${e.toString()}');
    }
  }

  Future<void> addOrder(Map<String, dynamic> json) async {
    try {
      await supabaseClient.from('orders').insert(json);
    } on SocketException catch (_) {
      throw Exception('لا يوجد اتصال بالإنترنت');
    } catch (e) {
      throw Exception('حدث خطأ غير متوقع: ${e.toString()}');
    }
  }
}
