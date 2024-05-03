import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khosousi_online/features/accounts/presentation/signup/pages/signup_screen.dart';

class SignupBtn extends StatelessWidget {
  const SignupBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'ليس لديك حساب؟',
          ),
          TextButton(
            child: const Text(
              'إنشاء حساب',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
                 Navigator.pushNamed(context, SignupScreen.routeName);

            },
          ),
        ],
      ),
    );;
  }
}
