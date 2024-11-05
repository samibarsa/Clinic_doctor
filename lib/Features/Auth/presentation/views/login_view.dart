import 'package:doctor_app/Features/Auth/presentation/widget/login_view_body.dart';
import 'package:doctor_app/Features/Auth/presentation/maneger/authCubit/auth_state.dart';
import 'package:doctor_app/Features/Auth/presentation/maneger/authCubit/auth_cubit.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          progressIndicator: const CircularProgressIndicator(
            color: Color(AppColor.primaryColor),
          ),
          inAsyncCall: state is AuthLoading,
          child: Scaffold(
            body: LoginViewBody(
                formKey: formKey, email: email, password: password),
          ),
        );
      },
    );
  }
}
