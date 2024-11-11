import 'package:doctor_app/Features/Auth/domain/Entities/doctor.dart';
import 'package:doctor_app/Features/Home/data/remote/remote_data_source.dart';
import 'package:doctor_app/Features/Home/domain/Entites/order.dart';
import 'package:doctor_app/Features/Home/domain/Entites/patient.dart';
import 'package:doctor_app/Features/Home/domain/repo/data_repos.dart';

class DataRepositoryImpl implements DataRepository {
  final RemoteDataSource remoteDataSource;

  DataRepositoryImpl(this.remoteDataSource);

  @override
  Future<Doctor> fetchDoctorsData() async {
    return await remoteDataSource.fetchAllDoctors();
  }

  @override
  Future<List<Order>> fetchAllOrders() async {
    return await remoteDataSource.fetchAllOrders();
  }

  @override
  Future<List<Patient>> fetchAllPatients() async {
    return await remoteDataSource.fetchAllPatients();
  }

  @override
  Future<void> editOrder(
      {required int orderId,
      required String? selectedOutputType,
      required String selectedImageType,
      required String? selectedExaminationOption,
      required String additionalNotes}) async {
    await remoteDataSource.editOrder(
        orderId: orderId,
        selectedOutputType: selectedOutputType,
        selectedImageType: selectedImageType,
        selectedExaminationOption: selectedExaminationOption,
        additionalNotes: additionalNotes);
  }
}
