import 'dart:developer';

import 'package:doctor_app/Features/AddOrder/data/datasources/add_order_data_source.dart';
import 'package:doctor_app/Features/AddOrder/data/repositories/add_order_repo_impl.dart';
import 'package:doctor_app/Features/AddOrder/domain/usecases/add_order_usecase.dart';
import 'package:doctor_app/Features/AddOrder/presentation/maneger/cubit/AddOrder/addorder_cubit.dart';
import 'package:doctor_app/Features/AddOrder/presentation/maneger/cubit/GetPrice/get_price_cubit.dart';
import 'package:doctor_app/Features/AddPatient/data/DataSource/add_Patient_remote_data_source.dart';
import 'package:doctor_app/Features/AddPatient/data/repos/add_patient_repo_impl.dart';
import 'package:doctor_app/Features/AddPatient/domain/usecase/add_patient_usecase.dart';
import 'package:doctor_app/Features/AddPatient/presentation/maneger/cubit/AddPatient/add_patient_cubit.dart';
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
import 'package:doctor_app/Features/getRemoteVersion/data/get_remote_version.dart';
import 'package:doctor_app/core/get_app_version.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:month_year_picker/month_year_picker.dart';
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
 await GetRemoteVersion.getRemoteVersion(supabaseClient: supabase.client);
  final dataRepoImpl = DataRepositoryImpl(RemoteDataSource(supabase.client));
  final authRepositoryImpl = AuthRepositoryImpl(supabase.client);
  final addOrderUsecase = AddOrderUsecase(
      addOrderRepoImpl: AddOrderRepoImpl(
          addOrderRemoteDataSource: AddOrderRemoteDataSource(
              supabaseClient: supabase.client))); // التحقق من حالة تسجيل الدخول
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
                AddPatientRemoteDataSource(supabase: supabase.client))),
    addOrderUsecase: addOrderUsecase,
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
    required this.addOrderUsecase,
  });
  final bool startWidget;

  final SignInUseCase signInUseCase;
  final AddOrderUsecase addOrderUsecase;
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
      designSize: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
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
              create: (context) {
                final now = DateTime.now();
                final startOfMonth = DateTime(now.year, now.month, 1);
                final endOfMonth = DateTime(now.year, now.month + 1, 0);
                return OrderCubit(fetchOrdersUseCase, fetchDoctorDataUseCase,
                    fetchPatientUsecase)
                  ..fetchOrders(startDate: startOfMonth, endDate: endOfMonth)
                  ..fetchDoctorDataUseCase();
              },
            ),
            BlocProvider<AddPatientCubit>(
                create: (context) => AddPatientCubit(addPatientUsecase)),
            BlocProvider<GetPriceCubit>(
              create: (context) => GetPriceCubit(addOrderUsecase),
            ),
            BlocProvider<AddOrderCubit>(
              create: (context) => AddOrderCubit(addOrderUsecase),
            ),
          ],
          child: MaterialApp(
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              MonthYearPickerLocalizations
                  .delegate, // إضافة دعم month_year_picker
            ],
            supportedLocales: const [
              Locale('en', 'english'),
              Locale('ar', 'Arabic'),
            ],
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
