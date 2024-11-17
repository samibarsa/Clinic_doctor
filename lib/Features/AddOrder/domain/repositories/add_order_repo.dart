abstract class AddOrderRepo {
  Future<int> getPrice(int detilId, String output);
  Future<void> addOrder(Map<String, dynamic> json);
}
