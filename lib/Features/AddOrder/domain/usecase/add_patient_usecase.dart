import 'package:doctor_app/Features/AddOrder/data/repos/add_patient_repo_impl.dart';

class AddPatientUsecase {
  final AddPatientRepoImpl addPatientRepoImpl;

  AddPatientUsecase({required this.addPatientRepoImpl});
  Future<void> call(Map<String, dynamic> json) async {
    return await addPatientRepoImpl.addPatient(json);
  }
}
