// lib/Features/Home/domain/usecases/fetch_orders_usecase.dart

import 'package:doctor_app/Features/Home/domain/Entites/order.dart';
import 'package:doctor_app/Features/Home/domain/repo/data_repos.dart';

class FetchOrdersUseCase {
  final DataRepository repository;

  FetchOrdersUseCase(this.repository);

  Future<List<Order>> call() async {
    return await repository.fetchAllOrders();
  }
}
