import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/managers/color_manager.dart';
import '../../../../core/ui/widgets/custom_text_field.dart';
import '../../../accounts/domain/repositories/auth_repo.dart';
import '../bloc/get_support_messages_bloc.dart';

class SendMessageSupport extends StatefulWidget {
  const SendMessageSupport({super.key});

  @override
  State<SendMessageSupport> createState() => _SendMessageSupportState();
}

class _SendMessageSupportState extends State<SendMessageSupport> {
  final _controller = TextEditingController();
  final _focusNode=FocusNode();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.text,
              validator: (value) {},
              hintText: 'اكتب رسالتك هنا...',
              isObscure: false,
              textEditingController: _controller,
              focusNode: _focusNode,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: ColorManager.black),
            padding: EdgeInsets.all(4),
            alignment: Alignment.center,
            child: IconButton(
              onPressed: () {
                BlocProvider.of<GetSupportMessagesBloc>(context).add(
                  AddMessage(
                    message: _controller.text,
                    userId: context.read<AuthRepo>().getUserId()!,
                  ),
                );
                _controller.clear();
                _focusNode.unfocus();

              },
              icon: Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
