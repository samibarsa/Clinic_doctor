// ignore_for_file: use_build_context_synchronously

import 'package:doctor_app/Features/Home/presentation/view/homePageViewWidget.dart';
import 'package:doctor_app/Features/Splash/presentation/widgets/error_alert_dialog.dart';
import 'package:doctor_app/Features/Splash/presentation/widgets/maitenence_dialog.dart';
import 'package:doctor_app/Features/Splash/presentation/widgets/offline_state_body.dart';
import 'package:doctor_app/Features/Splash/presentation/widgets/update_version_alert_dialog.dart';
import 'package:doctor_app/Features/wellcome/presentation/views/wellcome.dart';
import 'package:doctor_app/core/get_app_version.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_app/Features/Splash/presentation/maneger/cubit/get_remote_version_cubit.dart';

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
            } else if (state.version['version'] == "0.0.0") {
              showDialog(
                context: context,
                builder: (context) => const MaitenenceDialog(),
              );
            } else {
              showDialog(
                context: context,
                builder: (context) => UpdateVersionAlertDialog(
                  version: state.version,
                ),
              );
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
      child: const OfflineStateBody(),
    );
  }
}
