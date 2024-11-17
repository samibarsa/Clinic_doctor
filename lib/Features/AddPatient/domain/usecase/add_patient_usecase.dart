import 'package:doctor_app/Features/AddPatient/data/repos/add_patient_repo_impl.dart';

class AddPatientUsecase {
  final AddPatientRepoImpl addPatientRepoImpl;

  AddPatientUsecase({required this.addPatientRepoImpl});
  Future<int> call(Map<String, dynamic> json) async {
    return await addPatientRepoImpl.addPatient(json);
  }
}
