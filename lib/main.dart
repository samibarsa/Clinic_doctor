import 'package:doctor_app/Features/Auth/Signup/data/auth_repository_impl.dart';
import 'package:doctor_app/Features/Auth/Signup/domain/usecases/sign_up.dart';
import 'package:doctor_app/Features/Auth/Signup/presentation/maneger/cubit/auth_cubit.dart';
import 'package:doctor_app/Features/Splash/splash_screan.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: SupabaseKeys.anonyKey,
    anonKey: SupabaseKeys.projectUrl,
  );
  var supabaseClient =
      SupabaseClient(SupabaseKeys.anonyKey, SupabaseKeys.projectUrl);
  runApp(ClinicDoctor(
    signInUseCase: SignInUseCase(AuthRepositoryImpl(supabaseClient)),
    signOutUseCase: SignOutUseCase(AuthRepositoryImpl(supabaseClient)),
    signUpUseCase: SignUpUseCase(AuthRepositoryImpl(supabaseClient)),
  ));
}

class ClinicDoctor extends StatelessWidget {
  const ClinicDoctor(
      {super.key,
      required this.signInUseCase,
      required this.signOutUseCase,
      required this.signUpUseCase});
  final SignInUseCase signInUseCase;
  final SignOutUseCase signOutUseCase;
  final SignUpUseCase signUpUseCase;

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
              signUpUseCase: signUpUseCase),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: AppFont.primaryFont, // تطبيق الخط على جميع النصوص
              textTheme: const TextTheme(
                bodyMedium: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
