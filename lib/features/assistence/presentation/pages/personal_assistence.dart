import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';
import 'package:khosousi_online/core/ui/widgets/custom_text_field.dart';

class PersonalAssistenceScreen extends StatelessWidget {
  static const routeName = 'personal_assistence_screen';
  const PersonalAssistenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('مساعدك الشخصي من خصوصي اونلاين'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                  child: Container(
                padding: EdgeInsets.all(8),
                child: ListView.separated(
                  reverse: true,
                  itemBuilder: (context, index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: index % 2 == 0
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.end,
                      children: [
                        if (index % 2 == 0) ...[
                          CustomImage(
                              isCircle: true,
                              radius: 18,
                              image:
                                  'https://images.unsplash.com/photo-1568602471122-7832951cc4c5?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fHVzZXIlMjBwcm9maWxlfGVufDB8fDB8fHww'),
                          SizedBox(width: 8),
                        ],
                        Container(
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.60),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: index % 2 == 0
                                  ? Color(0xff17A2B8)
                                  : Color(0xffF5F7F9)),
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(index % 2 != 0 ? 'الدعم الفني' : 'أنا',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: index % 2 == 0
                                              ? Colors.white
                                              : Colors.black87)),
                                  SizedBox(height: 4),
                                  Text(
                                      DateFormat('dd-MM-yyyy ')
                                          .format(DateTime.now())
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Roboto',
                                          color: index % 2 == 0
                                              ? Colors.white
                                              : Colors.black87))
                                ],
                              ),
                              SizedBox(height: 12),
                              Text(
                                'هذا النص للتجربة هذا النص للتجربة هذا النص للتجربة هذا النص للتجربة هذا النص للتجربة هذا النص للتجربة هذا النص للتجربة',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: index % 2 == 0
                                        ? Colors.white
                                        : Colors.black87),
                              ),
                            ],
                          ),
                        ),
                        if (index % 2 != 0) ...[
                          SizedBox(width: 8),
                          CustomImage(
                            radius: 18,
                            isCircle: true,
                            image:
                                'https://teacherprivate.com/assets/template_files/images/logo-khsoosi-60pxx.webp',
                          ),
                        ],
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    height: 16,
                  ),
                  itemCount: 14,
                ),
              )),
              Divider(
                height: 1,
                color: ColorManager.gray4.withOpacity(0.2),
              ),
              _buildSendMessageField()
            ],
          ),
        ),
      ),
    );
  }

  Container _buildSendMessageField() {
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical:8),
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
    );
  }
}
