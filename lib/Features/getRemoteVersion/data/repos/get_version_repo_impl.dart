import 'package:doctor_app/Features/getRemoteVersion/data/get_remote_version.dart';
import 'package:doctor_app/Features/getRemoteVersion/domain/repos/get_version_repo.dart';

class GetVersionRepoImpl extends GetVersionRepo {
  final GetRemoteVersion getRemoteVersionC;

  GetVersionRepoImpl({required this.getRemoteVersionC});
  @override
  Future<String> getRemoteVersion() async {
    return getRemoteVersionC.getRemoteVersion();
  }
}
