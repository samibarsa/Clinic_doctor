import 'package:doctor_app/Features/AddOrder/data/datasources/add_order_data_source.dart';
import 'package:doctor_app/Features/AddOrder/domain/repositories/add_order_repo.dart';

class AddOrderRepoImpl implements AddOrderRepo {
  final AddOrderRemoteDataSource addOrderRemoteDataSource;

  AddOrderRepoImpl({required this.addOrderRemoteDataSource});
  @override
  Future<int> getPrice(int detailId, String output) async {
    return await addOrderRemoteDataSource.getPrice(detailId, output);
  }

  @override
  Future<void> addOrder(Map<String, dynamic> json) async {
    return await addOrderRemoteDataSource.addOrder(json);
  }
}
