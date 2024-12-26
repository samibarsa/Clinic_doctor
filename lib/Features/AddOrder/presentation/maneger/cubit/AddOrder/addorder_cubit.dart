// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:doctor_app/Features/AddOrder/domain/usecases/add_order_usecase.dart';
import 'package:doctor_app/Features/AddOrder/presentation/maneger/cubit/GetPrice/get_price_cubit.dart';
import 'package:doctor_app/Features/Home/data/local/local_data_source.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'addorder_state.dart';

class AddOrderCubit extends Cubit<AddorderState> {
  final AddOrderUsecase addOrderUsecase;
  AddOrderCubit(this.addOrderUsecase) : super(AddorderInitial());
  Future<void> addOrder(
      GetPriceLoaded state,
      int toothNumber,
      String outPut,
      String examinationOption,
      int patientId,
      String examinationMode,
      String type,
      String notes) async {
    emit(AddorderLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final doctorId = prefs.getInt("doctorId");
      int? detailId = await LocalDataSource.getDetailId(
          examinationMode, type, examinationOption);
      var outputId = 0;
      if (outPut == 'CD') {
        outputId = 1;
      } else if (outPut == 'Film') {
        outputId = 2;
      } else if (outPut == 'CD+Film') {
        outputId = 3;
      }
      final data = {
        'tooth_number': toothNumber == 0 ? null : toothNumber,
        'doctor_id': doctorId,
        'detiles_id': detailId,
        'order_price': state.price,
        'order_output': outputId,
        'additional_notes': notes,
        'date': DateTime.now().toString(),
        'patient_id': patientId,
      };
      final respone = await addOrderUsecase.addOrder(data);
      emit(AddorderSucses());
      return respone;
    } catch (e) {
      emit(AddorderFailure(errMessage: e.toString().split(':')[1]));
    }
  }
}
