import 'package:doctor_app/Features/Home/domain/usecase/fetch_order_usecase.dart';
import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCubit extends Cubit<OrderState> {
  final FetchOrdersUseCase fetchOrdersUseCase;

  OrderCubit(this.fetchOrdersUseCase) : super(OrderInitial());

  Future<void> fetchOrders() async {
    emit(OrderLoading());
    try {
      final orders = await fetchOrdersUseCase();
      emit(OrderLoaded(orders));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }
}
