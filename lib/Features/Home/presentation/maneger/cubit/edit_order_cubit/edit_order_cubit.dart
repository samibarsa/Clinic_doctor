// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:doctor_app/Features/Home/domain/usecase/edit_order_usecase.dart';
import 'package:equatable/equatable.dart';

part 'edit_order_state.dart';

class EditOrderCubit extends Cubit<EditOrderState> {
  EditOrderCubit(this.editOrderUsecase) : super(EditOrderInitial());
  final EditOrderUsecase editOrderUsecase;
  Future<void> editOrder(
      {required int orderId,
      required String? selectedOutputType,
      required String selectedImageType,
      required String? selectedExaminationOption,
      required String additionalNotes}) async {
    try {
      emit(EditOrderLoading());
      await editOrderUsecase.editOrder(
          orderId: orderId,
          selectedOutputType: selectedOutputType,
          selectedImageType: selectedImageType,
          selectedExaminationOption: selectedExaminationOption,
          additionalNotes: additionalNotes);
      emit(EditOrderLoaded());
    } catch (e) {
      emit(EditOrderError(errMessage: e.toString()));
    }
  }
}
