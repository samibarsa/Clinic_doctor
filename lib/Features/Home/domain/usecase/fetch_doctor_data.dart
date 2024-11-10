import 'package:doctor_app/Features/Auth/domain/Entities/doctor.dart';
import 'package:doctor_app/Features/Home/domain/repo/data_repos.dart';

class FetchDoctorDataUseCase {
  final DataRepository repository;

  FetchDoctorDataUseCase(this.repository);

  Future<Doctor> call() async {
    return await repository.fetchDoctorsData();
  }
}
