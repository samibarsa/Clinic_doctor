import 'package:doctor_app/Features/AddOrder/data/DataSource/add_order_remote_data_source.dart';
import 'package:doctor_app/Features/AddOrder/data/repos/add_patient_repo_impl.dart';
import 'package:doctor_app/Features/AddOrder/domain/usecase/add_patient_usecase.dart';
import 'package:doctor_app/Features/AddOrder/presentation/maneger/cubit/cubit/add_patient_cubit.dart';
import 'package:doctor_app/Features/Auth/data/repo/update_pass_repo_imp.dart';
import 'package:doctor_app/Features/Auth/domain/usecase/update_pass_usecase.dart';
import 'package:doctor_app/Features/Auth/presentation/maneger/update_password_cubit/update_password_cubit.dart';
import 'package:doctor_app/Features/Auth/data/repo/auth_repository_impl.dart';
import 'package:doctor_app/Features/Auth/domain/usecase/usecacses.dart';
import 'package:doctor_app/Features/Auth/presentation/maneger/authCubit/auth_cubit.dart';
import 'package:doctor_app/Features/Home/data/remote/remote_data_source.dart';
import 'package:doctor_app/Features/Home/data/repos/data_repo_impl.dart';
import 'package:doctor_app/Features/Home/domain/usecase/fetch_doctor_data.dart';
import 'package:doctor_app/Features/Home/domain/usecase/fetch_order_usecase.dart';
import 'package:doctor_app/Features/Home/domain/usecase/fetch_patient_usecase.dart';
import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_cubit.dart';
import 'package:doctor_app/Features/Splash/splash_screan.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة Supabase
  final supabase = await Supabase.initialize(
    url: SupabaseKeys.projectUrl,
    anonKey: SupabaseKeys.anonyKey,
  );
  final dataRepoImpl = DataRepositoryImpl(RemoteDataSource(supabase.client));
  final authRepositoryImpl = AuthRepositoryImpl(supabase.client);
  // التحقق من حالة تسجيل الدخول
  final prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('is_logged_in') ?? false;

  bool startWidget = isLoggedIn ? true : false;

  runApp(ClinicDoctor(
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
                AddOrderRemoteDataSource(supabase: supabase.client))),
  ));
}

class ClinicDoctor extends StatelessWidget {
  const ClinicDoctor({
    super.key,
    required this.signInUseCase,
    required this.signOutUseCase,
    required this.signUpUseCase,
    required this.ressetPasswordUseCase,
    required this.verifyTokenUseCase,
    required this.updatePassUsecase,
    required this.fetchOrdersUseCase,
    required this.fetchDoctorDataUseCase,
    required this.startWidget,
    required this.fetchPatientUsecase,
    required this.addPatientUsecase,
  });
  final bool startWidget;

  final SignInUseCase signInUseCase;
  final AddPatientUsecase addPatientUsecase;
  final FetchDoctorDataUseCase fetchDoctorDataUseCase;
  final FetchOrdersUseCase fetchOrdersUseCase;
  final SignOutUseCase signOutUseCase;
  final SignUpUseCase signUpUseCase;
  final RessetPasswordUseCase ressetPasswordUseCase;
  final VerifyTokenUseCase verifyTokenUseCase;
  final UpdatePassUsecase updatePassUsecase;
  final FetchPatientUsecase fetchPatientUsecase;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthCubit>(
              create: (context) => AuthCubit(
                  signInUseCase: signInUseCase,
                  signOutUseCase: signOutUseCase,
                  signUpUseCase: signUpUseCase,
                  ressetPasswordUseCase: ressetPasswordUseCase,
                  verifyTokenUseCase: verifyTokenUseCase),
            ),
            BlocProvider<VerifyCubit>(
              create: (context) =>
                  VerifyCubit(verifyTokenUseCase: verifyTokenUseCase),
            ),
            BlocProvider<UpdatePasswordCubit>(
              create: (context) =>
                  UpdatePasswordCubit(updatePassUsecase: updatePassUsecase),
            ),
            BlocProvider<OrderCubit>(
              create: (context) => OrderCubit(fetchOrdersUseCase,
                  fetchDoctorDataUseCase, fetchPatientUsecase)
                ..fetchOrders()
                ..fetchDoctorDataUseCase(),
            ),
            BlocProvider<AddPatientCubit>(
                create: (context) => AddPatientCubit(addPatientUsecase)),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme(
                brightness: Brightness
                    .light, // السطوع (أو Brightness.dark للوضع الداكن)
                primary: const Color(AppColor.primaryColor), // اللون الأساسي
                onPrimary: Colors.white, // لون النص فوق اللون الأساسي
                secondary: Colors.greenAccent, // اللون الثانوي
                onSecondary: Colors.black, // لون النص فوق اللون الثانوي
                error: Colors.red, // لون الخطأ
                onError: Colors.white, // لون النص فوق الخلفية
                surface: Colors.grey.shade100, // لون الأسطح مثل بطاقات العرض
                onSurface: Colors.black, // لون النص فوق الأسطح
              ),
              fontFamily: AppFont.primaryFont,
              textTheme: const TextTheme(
                bodyMedium: TextStyle(fontSize: 16.0),
              ),
            ),
            home: SplashScreen(
              startWidget: startWidget,
            ),
          ),
        );
      },
    );
  }
}
