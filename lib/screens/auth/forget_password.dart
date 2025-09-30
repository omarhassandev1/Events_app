import 'package:flutter/material.dart';

import '../../common/theme/app_colors.dart';
import '../../common/widgets/custom_main_button.dart';
import '../../common/widgets/custom_outlined_button.dart';
import '../../common/widgets/custom_text_field.dart';
import '../../gen/assets.gen.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  static const routName = '/forgetPassword';

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(title: Text('Forget Password')),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: double.infinity, child: Assets.svg.watch.svg()),
              const SizedBox(height: 24,),
              CustomMainButton(text: 'Reset Password', onPressed: () {}),

            ],
          ),
        ),
      ),
    );
  }
}
