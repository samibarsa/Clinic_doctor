import 'package:doctor_app/Features/Auth/Signup/data/auth_repository_impl.dart';
import 'package:doctor_app/Features/Auth/Signup/domain/usecases/usecacses.dart';
import 'package:doctor_app/Features/Auth/Signup/presentation/maneger/cubit/auth_cubit.dart';
import 'package:doctor_app/Features/Splash/splash_screan.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة SharedPreferences

  // تهيئة Supabase مع SharedPreferences كـ asyncStorage
  final supabase = await Supabase.initialize(
    url: SupabaseKeys.projectUrl,
    anonKey: SupabaseKeys.anonyKey,
  );

  runApp(ClinicDoctor(
    signInUseCase: SignInUseCase(AuthRepositoryImpl(supabase.client)),
    signOutUseCase: SignOutUseCase(AuthRepositoryImpl(supabase.client)),
    signUpUseCase: SignUpUseCase(AuthRepositoryImpl(supabase.client)),
    ressetPasswordUseCase:
        RessetPasswordUseCase(AuthRepositoryImpl(supabase.client)),
    verifyTokenUseCase: VerifyTokenUseCase(AuthRepositoryImpl(supabase.client)),
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
  });

  final SignInUseCase signInUseCase;
  final SignOutUseCase signOutUseCase;
  final SignUpUseCase signUpUseCase;
  final RessetPasswordUseCase ressetPasswordUseCase;
  final VerifyTokenUseCase verifyTokenUseCase;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(
              signInUseCase: signInUseCase,
              signOutUseCase: signOutUseCase,
              signUpUseCase: signUpUseCase,
              ressetPasswordUseCase: ressetPasswordUseCase,
              verifyTokenUseCase: verifyTokenUseCase),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: AppFont.primaryFont,
              textTheme: const TextTheme(
                bodyMedium: TextStyle(fontSize: 16.0),
              ),
            ),
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
