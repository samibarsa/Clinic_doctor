import 'package:doctor_app/Features/AddOrder/data/repos/add_patient_repo_impl.dart';

class AddPatientUsecase {
  final AddPatientRepoImpl addPatientRepoImpl;

  AddPatientUsecase({required this.addPatientRepoImpl});
  Future<void> addPatient(Map<String, dynamic> json) async {
    addPatientRepoImpl.addPatient(json);
  }
}
