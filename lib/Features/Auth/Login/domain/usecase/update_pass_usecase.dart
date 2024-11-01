
import 'package:doctor_app/Features/Auth/Login/data/repo/update_pass_repo_imp.dart';

class UpdatePassUsecase {
  final UpdatePasswordRepoImp updatePasswordRepoImp;

  UpdatePassUsecase({required this.updatePasswordRepoImp});
  Future<void> updatePassUsecase(String password){
  return  updatePasswordRepoImp.updatePassword(password);
  }
}