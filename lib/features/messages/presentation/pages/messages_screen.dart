import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';
import 'package:khosousi_online/core/ui/widgets/custom_text_field.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Divider(
              height: 1,
              color: ColorManager.gray4.withOpacity(0.2),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.all(8),
              child: ListView.separated(
                reverse: true,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: index % 2 == 0
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.75),
                        decoration: BoxDecoration(
                            borderRadius: index % 2 == 0
                                ? BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.zero,
                                    bottomLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16))
                                : BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                    bottomLeft: Radius.zero,
                                    bottomRight: Radius.circular(16)),
                            color: index % 2 == 0
                                ? ColorManager.orange
                                : ColorManager.black),
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        child: Text(
                          'هذا النص للتجربة هذا النص للتجربة هذا النص للتجربة هذا النص للتجربة هذا النص للتجربة هذا النص للتجربة هذا النص للتجربة',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: 8,
                ),
                itemCount: 14,
              ),
            )),
            Divider(
              height: 1,
              color: ColorManager.gray4.withOpacity(0.2),
            ),
            Container(
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        validator: (value) {},
                        hintText: 'اكتب رسالتك هنا...',
                        isObscure: false),
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
                      onPressed: () {},
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _buildTopBar(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          _buildBackBtn(context),
          CustomImage(
            image:
                'https://images.unsplash.com/photo-1568602471122-7832951cc4c5?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fHVzZXIlMjBwcm9maWxlfGVufDB8fDB8fHww',
            radius: 20,
            isCircle: true,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'عمرو عويس - Amr Owies',
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  'نشط قبل ساعة واحدة',
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(fontSize: 12, color: ColorManager.gray4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconButton _buildBackBtn(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.arrow_back_ios,
      ),
    );
  }
}
