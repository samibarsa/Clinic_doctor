import 'package:doctor_app/Features/Home/domain/Entites/order.dart';
import 'package:doctor_app/Features/Home/domain/repo/data_repos.dart';

class FetchOrdersUseCase {
  final DataRepository repository;

  FetchOrdersUseCase(this.repository);

  Future<List<Order>> call(
      {required DateTime startDate, required DateTime endDate}) async {
    return await repository.fetchAllOrders(
        startDate: startDate, endDate: endDate);
  }
}
