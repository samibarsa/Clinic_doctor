import 'package:doctor_app/Features/Splash/data/get_remote_version.dart';
import 'package:doctor_app/Features/Splash/domain/repos/get_version_repo.dart';

class GetVersionRepoImpl extends GetVersionRepo {
  final GetRemoteVersion getRemoteVersionC;

  GetVersionRepoImpl({required this.getRemoteVersionC});
  @override
  Future<Map<String,dynamic>> getRemoteVersion() async {
    return getRemoteVersionC.getRemoteVersion();
  }
}
