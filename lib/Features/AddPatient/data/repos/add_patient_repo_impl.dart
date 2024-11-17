import 'package:doctor_app/Features/AddPatient/data/DataSource/add_Patient_remote_data_source.dart';
import 'package:doctor_app/Features/AddPatient/domain/repos/add_patient_repo.dart';

class AddPatientRepoImpl implements AddPatientRepo {
  final AddPatientRemoteDataSource addOrderRemoteDataSource;

  AddPatientRepoImpl({required this.addOrderRemoteDataSource});
  @override
  Future<int> addPatient(Map<String, dynamic> json) async {
    return await addOrderRemoteDataSource.addPatient(json);
  }
}
