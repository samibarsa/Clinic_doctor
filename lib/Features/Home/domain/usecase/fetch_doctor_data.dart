// lib/Features/Home/domain/usecases/fetch_orders_usecase.dart

import 'package:doctor_app/Features/Home/domain/Entites/doctor.dart';
import 'package:doctor_app/Features/Home/domain/Entites/order.dart';
import 'package:doctor_app/Features/Home/domain/repo/data_repos.dart';

class FetchDoctorDataUseCase {
  final DataRepository repository;

  FetchDoctorDataUseCase(this.repository);

  Future<Doctor> call() async {
    return await repository.fetchDoctorsData();
  }
}
