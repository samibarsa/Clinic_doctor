import 'package:doctor_app/Features/Home/domain/usecase/fetch_doctor_data.dart';
import 'package:doctor_app/Features/Home/domain/usecase/fetch_order_usecase.dart';
import 'package:doctor_app/Features/Home/domain/usecase/fetch_patient_usecase.dart';
import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCubit extends Cubit<OrderState> {
  final FetchOrdersUseCase fetchOrdersUseCase;
  final FetchDoctorDataUseCase fetchDoctorDataUseCase;
  final FetchPatientUsecase patientUsecase;
  OrderCubit(
      this.fetchOrdersUseCase, this.fetchDoctorDataUseCase, this.patientUsecase)
      : super(OrderInitial());

  Future<void> fetchOrders() async {
    emit(OrderLoading());
    try {
      final orders = await fetchOrdersUseCase.repository.fetchAllOrders();
      final doctor = await fetchDoctorDataUseCase();
      final patient = await patientUsecase.call();

      emit(OrderLoaded(orders, doctor, patient));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }
}
