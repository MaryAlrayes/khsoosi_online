import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:khosousi_online/core/managers/assets_manager.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/utils/helpers/persistent_push.dart';
import 'package:khosousi_online/features/accounts/presentation/otp/screens/otp_screen.dart';
import 'package:lottie/lottie.dart';

PopupMenuButton<int> buildWarningMenu(
    GlobalKey<PopupMenuButtonState<dynamic>> _popupMenu, BuildContext context) {
  return PopupMenuButton(
      position: PopupMenuPosition.under,
      color: Colors.white,
      key: _popupMenu,
      itemBuilder: (c) => [
            PopupMenuItem<int>(
              value: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () {
                    barPushScreen(
                        context: context,
                        screen: OtpScreen(
                          onSkipClicked: (returnedContext) {
                            Navigator.pop(returnedContext);
                          },
                        ));
                  },
                  contentPadding: EdgeInsets.zero,
                  title: RichText(
                    text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: [
                          TextSpan(
                            text: 'حسابك غير مفعل، اضغط من أجل تفعيل حسابك',
                          ),
                          WidgetSpan(
                            child: SizedBox(width: 4),
                          ),
                          TextSpan(
                            text: 'تغعيل الحساب',
                            style: TextStyle(color: ColorManager.orange),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                barPushScreen(
                                    context: context,
                                    screen: OtpScreen(
                                      onSkipClicked: (returnedContext) {
                                        Navigator.pop(returnedContext);
                                      },
                                    ));
                              },
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          ],
      child: InkWell(
        onTap: () {
          _popupMenu.currentState?.showButtonMenu();
        },
        child: SizedBox(
          height: 30,
          width: 30,
          child: Lottie.asset(
            AppAssetsManager.warning,
            repeat: true,
            fit: BoxFit.contain,
          ),
        ),
      ));
}
