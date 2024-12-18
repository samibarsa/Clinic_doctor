import 'package:doctor_app/Features/AddOrder/domain/usecases/add_order_usecase.dart';
import 'package:doctor_app/Features/AddOrder/presentation/maneger/cubit/AddOrder/addorder_cubit.dart';
import 'package:doctor_app/Features/AddOrder/presentation/maneger/cubit/GetPrice/get_price_cubit.dart';
import 'package:doctor_app/Features/AddPatient/domain/usecase/add_patient_usecase.dart';
import 'package:doctor_app/Features/AddPatient/presentation/maneger/cubit/AddPatient/add_patient_cubit.dart';
import 'package:doctor_app/Features/Auth/domain/usecase/update_pass_usecase.dart';
import 'package:doctor_app/Features/Auth/domain/usecase/usecacses.dart';
import 'package:doctor_app/Features/Auth/presentation/maneger/authCubit/auth_cubit.dart';
import 'package:doctor_app/Features/Auth/presentation/maneger/update_password_cubit/update_password_cubit.dart';
import 'package:doctor_app/Features/Home/domain/usecase/fetch_doctor_data.dart';
import 'package:doctor_app/Features/Home/domain/usecase/fetch_order_usecase.dart';
import 'package:doctor_app/Features/Home/domain/usecase/fetch_patient_usecase.dart';
import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_cubit.dart';
import 'package:doctor_app/Features/Splash/domain/usecase/get_remote_version_usecase.dart';
import 'package:doctor_app/Features/Splash/presentation/maneger/cubit/get_remote_version_cubit.dart';
import 'package:doctor_app/Features/Splash/presentation/view/splash_screan.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:month_year_picker/month_year_picker.dart';

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
    required this.addOrderUsecase, required this.getRemoteVersionUsecase,
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
  final GetRemoteVersionUsecase getRemoteVersionUsecase;
  
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
            ), BlocProvider<GetRemoteVersionCubit>(
              create: (context) =>
               GetRemoteVersionCubit(getRemoteVersionUsecase)
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
