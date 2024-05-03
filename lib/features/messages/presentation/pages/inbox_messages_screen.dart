import 'package:flutter/material.dart';
import 'package:khosousi_online/core/ui/widgets/custom_app_bar.dart';
import 'package:khosousi_online/features/messages/presentation/widgets/main_message_item.dart';

class InboxMessagesScreen extends StatelessWidget {
  const InboxMessagesScreen({super.key});

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
                  return MainMessageItem()
                  ;
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 1,
                  );
                },
                itemCount: 10),
          ),
        ));
  }

  PreferredSizeWidget _buildAppbar() {
    return customeAppBar;
  }


}
