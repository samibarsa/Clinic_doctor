import 'package:bloc/bloc.dart';
import 'package:doctor_app/Features/AddOrder/domain/usecases/add_order_usecase.dart';
import 'package:equatable/equatable.dart';

part 'get_price_state.dart';

class GetPriceCubit extends Cubit<GetPriceState> {
  GetPriceCubit(this.addOrderUsecase) : super(GetPriceInitial());
  final AddOrderUsecase addOrderUsecase;
  Future<int> getPrice(int datailId, String output) async {
    emit(GetPriceLoading());
    try {
      final price = await addOrderUsecase.getPrice(datailId, output);
      emit(GetPriceLoaded(price: price));
      return price;
    } catch (e) {
      emit(GetPriceError(errMessage: e.toString()));
      rethrow;
    }
  }
}
