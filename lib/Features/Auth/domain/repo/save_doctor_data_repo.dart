import 'package:doctor_app/Features/Auth/domain/Entities/doctor.dart';

abstract class SaveDoctorDataRepo {
  Future<Doctor> saveData(
      int id, String userId, String name, String phoneNumber);
}
