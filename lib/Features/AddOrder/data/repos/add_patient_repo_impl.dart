import 'package:doctor_app/Features/AddOrder/data/DataSource/add_order_remote_data_source.dart';
import 'package:doctor_app/Features/AddOrder/domain/repos/add_patient_repo.dart';

class AddPatientRepoImpl implements AddPatientRepo {
  final AddOrderRemoteDataSource addOrderRemoteDataSource;

  AddPatientRepoImpl({required this.addOrderRemoteDataSource});
  @override
  Future<int> addPatient(Map<String, dynamic> json) async {
    return await addOrderRemoteDataSource.addPatient(json);
  }
}
