import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:khosousi_online/core/ui/widgets/custom_app_bar.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';
import 'package:khosousi_online/features/notification/presentation/widgets/notification_item1.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: _buildAppbar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return NotificationItem1()
                  ;
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 8,);
                },
                itemCount: 10),
          ),
        ));
  }

  PreferredSizeWidget _buildAppbar() {
    return customeAppBar;
  }
}
