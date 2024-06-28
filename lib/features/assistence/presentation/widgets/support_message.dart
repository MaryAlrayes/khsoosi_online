// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:khosousi_online/core/ui/widgets/custom_image.dart';

import '../../../../core/managers/color_manager.dart';
import '../../../../core/managers/endpoints_manager.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../../core/utils/helpers/date_formatter.dart';
import '../../../accounts/domain/repositories/auth_repo.dart';
import '../../domain/entities/support_message_entity.dart';
import '../bloc/get_support_messages_bloc.dart';

class SupportMessage extends StatelessWidget {
  final SupportMessageEntity supportMessageEntity;
  final SubmitStatus submitStatus;
  final bool sendingNow;
  const SupportMessage({
    Key? key,
    required this.supportMessageEntity,
    required this.submitStatus,
    required this.sendingNow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:
          supportMessageEntity.supportMessageUser == SupportMessageUser.me
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
      children: [
        if (supportMessageEntity.supportMessageUser ==
            SupportMessageUser.me) ...[
          CustomImage(
              isCircle: true,
              radius: 18,
              image: context.read<AuthRepo>().getUserInfo()!.image),
          SizedBox(width: 8),
        ],
        Stack(children: [
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.60),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: sendingNow
                    ? Colors.grey
                    : supportMessageEntity.supportMessageUser ==
                            SupportMessageUser.me
                        ? ColorManager.blue2
                        : ColorManager.lightWhite),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                        supportMessageEntity.supportMessageUser ==
                                SupportMessageUser.support
                            ? 'الدعم الفني'
                            : 'أنا',
                        style: TextStyle(
                            fontSize: 12,
                            color: supportMessageEntity.supportMessageUser ==
                                    SupportMessageUser.me
                                ? Colors.white
                                : Colors.black87)),
                    SizedBox(height: 4),
                    Text(
                        DateFormatter.getFormatedDate(
                            supportMessageEntity.date.toString(), true),
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            color: supportMessageEntity.supportMessageUser ==
                                    SupportMessageUser.me
                                ? Colors.white
                                : Colors.black87))
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  supportMessageEntity.message,
                  style: TextStyle(
                      fontSize: 12,
                      color: supportMessageEntity.supportMessageUser ==
                              SupportMessageUser.me
                          ? Colors.white
                          : Colors.black87),
                ),
              ],
            ),
          ),
          if (sendingNow) ...[
            Positioned(
              bottom: 4,
              left: 4,
              child: _buildMessageStatus(),
            )
          ]
        ]),
        if (supportMessageEntity.supportMessageUser ==
            SupportMessageUser.support) ...[
          SizedBox(width: 8),
          CustomImage(
            radius: 18,
            isCircle: true,
            image: EndPointsManager.logoIcon,
          ),
        ],
      ],
    );
  }

  Text _buildMessageStatus() {
    String text = '';
    Color c= Colors.white;
    if (submitStatus == SubmitStatus.loading) {
      text = 'جاري الارسال...';
    } else if (submitStatus == SubmitStatus.offline || submitStatus == SubmitStatus.error) {
      text = 'حدث خطأ';
      c=Colors.red;
    }
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        color: c,
      ),
    );
  }
}
