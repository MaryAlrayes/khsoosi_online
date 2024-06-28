import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_elevated_btn.dart';
import 'package:khosousi_online/core/ui/widgets/custom_text_field.dart';
import 'package:khosousi_online/core/utils/helpers/snackbar.dart';

import '../../../../core/managers/assets_manager.dart';
import 'otp_forget_password_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const routeName = 'forget_password_screen';
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController textEditingController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('هل نسيت كلمة المرور؟'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildImage(context),
                Text(
                  'هل نسيت كلمة المرور؟',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'لتلقي كلمة مرور جديدة ، أدخل عنوان بريدك الإلكتروني أدناه.',
                   textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'ضع بريدك الالكتروني المسجل بالموقع هنا *',
                   textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                SizedBox(
                  height: 8,
                ),
                CustomTextField(
                  textEditingController: textEditingController,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.text,
                  validator: (value) {},
                  isObscure: false,
                  hintText: 'ادخل بريدك الالكتروني المسجل لدينا',
                  iconData: Icon(Icons.email),
                ),
                SizedBox(
                  height: 8,
                ),
                CustomElevatedButton(
                  backgroundColor: ColorManager.black,
                  label: 'ارسل كود إعادة تعيين كلمة المرور',
                  onPressed: () {
                    if(textEditingController.text.isEmpty){
                      showSnackbar(context, 'عليك إدخال بريدك الالكتروني');
                    }else{
                      Navigator.pushReplacementNamed(context, OtpForgetPasswordScreen.routeName);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );

  }

  SvgPicture _buildImage(BuildContext context) {
    return SvgPicture.asset(
      AppAssetsManager.forgotPassword,
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
    );
  }
}
