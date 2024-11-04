import 'package:doctor_app/Features/Home/data/remote/repos/remote_data_source.dart';
import 'package:doctor_app/Features/Home/domain/Entites/doctor.dart';
import 'package:doctor_app/Features/Home/domain/Entites/examination.dart';
import 'package:doctor_app/Features/Home/domain/Entites/note.dart';
import 'package:doctor_app/Features/Home/domain/Entites/order.dart';
import 'package:doctor_app/Features/Home/domain/Entites/patient.dart';
import 'package:doctor_app/Features/Home/domain/repo/data_repos.dart';

class DoctorRepositoryImpl implements DataRepository {
  final RemoteDataSource remoteDataSource;

  DoctorRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Doctor>> fetchAllDoctors() async {
    return await remoteDataSource.fetchAllDoctors();
  }

  @override
  Future<List<Examination>> fetchAllExaminations() async {
    return await remoteDataSource
        .fetchAllExaminations(); // تأكد من أن لديك دالة fetchAllExaminations في RemoteDataSource
  }

  @override
  Future<List<Note>> fetchAllNotes() async {
    return await remoteDataSource
        .fetchAllNotes(); // تأكد من أن لديك دالة fetchAllNotes في RemoteDataSource
  }

  @override
  Future<List<Order>> fetchAllOrders() async {
    return await remoteDataSource
        .fetchAllOrders(); // تأكد من أن لديك دالة fetchAllOrders في RemoteDataSource
  }

  @override
  Future<List<Patient>> fetchAllPatients() async {
    return await remoteDataSource.fetchAllPatients();
  }
}
