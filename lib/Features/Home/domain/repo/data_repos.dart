import 'package:doctor_app/Features/Home/domain/Entites/doctor.dart';
import 'package:doctor_app/Features/Home/domain/Entites/examination.dart';
import 'package:doctor_app/Features/Home/domain/Entites/note.dart';
import 'package:doctor_app/Features/Home/domain/Entites/order.dart';
import 'package:doctor_app/Features/Home/domain/Entites/patient.dart';

abstract class DataRepository {
  Future<List<Doctor>> fetchAllDoctors();
  Future<List<Patient>> fetchAllPatients();
  Future<List<Order>> fetchAllOrders();
  Future<List<Examination>> fetchAllExaminations();
  Future<List<Note>> fetchAllNotes();
}
