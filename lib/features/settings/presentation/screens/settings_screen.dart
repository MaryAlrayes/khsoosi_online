import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:khosousi_online/core/ui/widgets/custom_elevated_btn.dart';
import 'package:khosousi_online/features/settings/presentation/widgets/delete_account.dart';
import 'package:khosousi_online/features/settings/presentation/widgets/pause_switch.dart';
import 'package:khosousi_online/features/settings/presentation/widgets/user_status.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الإعدادات'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(
            16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserStatus(),
              SizedBox(
                height: 16,
              ),
              Divider(
                height: 1,
                color: Colors.grey.shade300,
              ),
              SizedBox(
                height: 16,
              ),
              DeleteAccount(),
            ],
          ),
        ),
      )),
    );
  }
}
