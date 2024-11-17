import 'package:doctor_app/Features/AddOrder/data/repositories/add_order_repo_impl.dart';

class AddOrderUsecase {
  final AddOrderRepoImpl addOrderRepoImpl;

  AddOrderUsecase({required this.addOrderRepoImpl});
  Future<int> getPrice(int detailId, String output) async {
    return await addOrderRepoImpl.getPrice(detailId, output);
  }

  Future<void> addOrder(Map<String, dynamic> json) async {
    return await addOrderRepoImpl.addOrder(json);
  }
}
