import 'package:doctor_app/Features/Home/domain/repo/data_repos.dart';

class EditOrderUsecase {
  final DataRepository dataRepository;

  EditOrderUsecase({required this.dataRepository});
  Future<void> editOrder(
      {required String? selectedOutputType,
      required String selectedImageType,
      required String? selectedExaminationOption,
      String? additionalNotesController}) async {
    dataRepository.editOrder(
        selectedOutputType: selectedOutputType,
        selectedImageType: selectedImageType,
        selectedExaminationOption: selectedExaminationOption);
  }
}
