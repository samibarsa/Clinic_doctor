import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddOrderRemoteDataSource {
  final SupabaseClient supabaseClient;

  AddOrderRemoteDataSource({required this.supabaseClient});

  Future<int> getPrice(int detailId, String output) async {
    int priceId = calculatePriceId(detailId, output);

    try {
      final detailPrice = await supabaseClient
          .from('prices')
          .select('price')
          .eq('price_id', priceId)
          .single();

      return (detailPrice['price'] as int);
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

int calculatePriceId(int detailId, String output) {
  int priceId = 0;
  if (detailId == 4 || detailId == 5) {
    switch (output) {
      case 'لا شيء':
        priceId = 7;
        break;
      case 'CD':
        priceId = 8;
        break;
      case 'Film':
        priceId = 9;
        break;
      case 'CD+Film':
        priceId = 10;
        break;
    }
  } else if (detailId == 1 || detailId == 2 || detailId == 3) {
    switch (output) {
      case 'لا شيء':
        priceId = 11;
        break;
      case 'CD':
        priceId = 12;
        break;
      case 'Film':
        priceId = 13;
        break;
      case 'CD+Film':
        priceId = 14;
        break;
    }
  } else {
    switch (detailId) {
      case 6:
      case 7:
      case 11:
      case 12:
        priceId = 2;
        break;
      case 8:
      case 10:
        priceId = 1;
        break;
      case 9:
      case 13:
        priceId = 3;
        break;
      case 14:
        priceId = 4;
        break;
      case 15:
        priceId = 5;
        break;
      case 16:
        priceId = 6;
        break;
      default:
        break;
    }
  }
  return priceId;
}
