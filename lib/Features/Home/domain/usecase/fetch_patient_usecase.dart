import 'package:doctor_app/Features/Home/data/repos/data_repo_impl.dart';
import 'package:doctor_app/Features/Home/domain/Entites/patient.dart';

class FetchPatientUsecase {
  final DataRepositoryImpl dataRepositoryImpl;

  FetchPatientUsecase({required this.dataRepositoryImpl});
  Future<List<Patient>> call() async {
    final patient = dataRepositoryImpl.fetchAllPatients();
    return patient;
  }
}
