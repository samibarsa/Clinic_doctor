import 'dart:developer';
import 'package:doctor_app/Features/AddOrder/data/datasources/add_order_data_source.dart';
import 'package:doctor_app/Features/AddOrder/data/repositories/add_order_repo_impl.dart';
import 'package:doctor_app/Features/AddOrder/domain/usecases/add_order_usecase.dart';
import 'package:doctor_app/Features/AddPatient/data/DataSource/add_Patient_remote_data_source.dart';
import 'package:doctor_app/Features/AddPatient/data/repos/add_patient_repo_impl.dart';
import 'package:doctor_app/Features/AddPatient/domain/usecase/add_patient_usecase.dart';
import 'package:doctor_app/Features/Auth/data/repo/update_pass_repo_imp.dart';
import 'package:doctor_app/Features/Auth/domain/usecase/update_pass_usecase.dart';
import 'package:doctor_app/Features/Auth/data/repo/auth_repository_impl.dart';
import 'package:doctor_app/Features/Auth/domain/usecase/usecacses.dart';
import 'package:doctor_app/Features/Home/data/remote/remote_data_source.dart';
import 'package:doctor_app/Features/Home/data/repos/data_repo_impl.dart';
import 'package:doctor_app/Features/Home/domain/usecase/fetch_doctor_data.dart';
import 'package:doctor_app/Features/Home/domain/usecase/fetch_order_usecase.dart';
import 'package:doctor_app/Features/Home/domain/usecase/fetch_patient_usecase.dart';
import 'package:doctor_app/clinic_doctor.dart';
import 'package:doctor_app/core/get_app_version.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appVersion = await getAppVersion();
  log(appVersion.toString());

  final supabase = await Supabase.initialize(
    url: SupabaseKeys.projectUrl,
    anonKey: SupabaseKeys.anonyKey,
  );
  final dataRepoImpl = DataRepositoryImpl(RemoteDataSource(supabase.client));
  final authRepositoryImpl = AuthRepositoryImpl(supabase.client);
  final addOrderUsecase = AddOrderUsecase(
      addOrderRepoImpl: AddOrderRepoImpl(
          addOrderRemoteDataSource:
              AddOrderRemoteDataSource(supabaseClient: supabase.client)));
  final prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('is_logged_in') ?? false;

  bool startWidget = isLoggedIn ? true : false;

  var clinicDoctor = ClinicDoctor(
    signInUseCase: SignInUseCase(authRepositoryImpl),
    signOutUseCase: SignOutUseCase(authRepositoryImpl),
    signUpUseCase: SignUpUseCase(authRepositoryImpl),
    ressetPasswordUseCase: RessetPasswordUseCase(authRepositoryImpl),
    verifyTokenUseCase: VerifyTokenUseCase(authRepositoryImpl),
    updatePassUsecase: UpdatePassUsecase(
        updatePasswordRepoImp:
            UpdatePasswordRepoImp(supabaseClient: supabase.client)),
    fetchOrdersUseCase: FetchOrdersUseCase(dataRepoImpl),
    fetchDoctorDataUseCase: FetchDoctorDataUseCase(dataRepoImpl),
    startWidget: startWidget,
    fetchPatientUsecase: FetchPatientUsecase(dataRepositoryImpl: dataRepoImpl),
    addPatientUsecase: AddPatientUsecase(
        addPatientRepoImpl: AddPatientRepoImpl(
            addOrderRemoteDataSource:
                AddPatientRemoteDataSource(supabase: supabase.client))),
    addOrderUsecase: addOrderUsecase,
  );
  runApp(clinicDoctor);
}
