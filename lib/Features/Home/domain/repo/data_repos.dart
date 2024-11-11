import 'package:doctor_app/Features/Auth/domain/Entities/doctor.dart';
import 'package:doctor_app/Features/Home/domain/Entites/order.dart';
import 'package:doctor_app/Features/Home/domain/Entites/patient.dart';

abstract class DataRepository {
  Future<Doctor> fetchDoctorsData();
  Future<List<Patient>> fetchAllPatients();
  Future<List<Order>> fetchAllOrders();
  Future<void> editOrder(
      {required int orderId,
      required String? selectedOutputType,
      required String selectedImageType,
      required String? selectedExaminationOption,
      required String additionalNotes});
}
