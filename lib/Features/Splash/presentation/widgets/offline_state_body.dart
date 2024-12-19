// ignore_for_file: use_build_context_synchronously

import 'package:doctor_app/Features/Splash/presentation/widgets/splash_screen_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

class OfflineStateBody extends StatelessWidget {
  const OfflineStateBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
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
    );
  }
}
