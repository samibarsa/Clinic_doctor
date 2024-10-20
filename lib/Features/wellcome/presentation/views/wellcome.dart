import 'package:doctor_app/Features/wellcome/presentation/widgets/wellcome_screan_body.dart';
import 'package:flutter/material.dart';


class WellcomeScrean extends StatelessWidget {
  const WellcomeScrean({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
     
      ),
      body:  const WellcomeViewBody(),
    );
  }
}
