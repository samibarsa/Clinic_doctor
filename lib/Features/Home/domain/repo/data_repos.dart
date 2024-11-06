import 'package:doctor_app/Features/Auth/domain/Entities/doctor.dart';
import 'package:doctor_app/Features/Home/domain/Entites/examination.dart';
import 'package:doctor_app/Features/Home/domain/Entites/note.dart';
import 'package:doctor_app/Features/Home/domain/Entites/order.dart';
import 'package:doctor_app/Features/Home/domain/Entites/patient.dart';

abstract class DataRepository {
  Future<Doctor> fetchDoctorsData();
  Future<List<Patient>> fetchAllPatients();
  Future<List<Order>> fetchAllOrders();
  Future<List<Examination>> fetchAllExaminations();
  Future<List<Note>> fetchAllNotes();
}
