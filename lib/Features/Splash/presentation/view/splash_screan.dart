// ignore_for_file: use_build_context_synchronously

import 'package:doctor_app/Features/Home/presentation/view/homePageViewWidget.dart';
import 'package:doctor_app/Features/Splash/presentation/widgets/error_alert_dialog.dart';
import 'package:doctor_app/Features/Splash/presentation/widgets/splash_screen_view_body.dart';
import 'package:doctor_app/Features/wellcome/presentation/views/wellcome.dart';
import 'package:doctor_app/core/get_app_version.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:doctor_app/Features/Splash/presentation/maneger/cubit/get_remote_version_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.startWidget});
  final bool startWidget;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetRemoteVersionCubit>(context).getRemoteVersion();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetRemoteVersionCubit, GetRemoteVersionState>(
      listener: (context, state) async {
        {
          if (state is GetRemoteVersionSucsess) {
            final futureVersion = await getAppVersion();

            if (state.version['version'] == futureVersion) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => widget.startWidget
                          ? const HomePageViewWidget()
                          : const WellcomeScrean()));
            }
          }
        }
        if (state is GetRemoteVersionFailure) {
          showDialog(
            context: context,
            builder: (context) => ErrorAlertDialog(
              errMessage: state.errMessage,
            ),
          );
        }
      },
      child: OfflineBuilder(
        connectivityBuilder: (context, connectivity, child) {
          // ignore: unrelated_type_equality_checks
          final connected = connectivity != ConnectivityResult.none;
          if (!connected) {
            return const Scaffold(
              body: Center(
                child: Text(
                  'لا يوجد اتصال بالإنترنت',
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(),
            body: const SplashScreenViewBody(),
          );
        },
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
