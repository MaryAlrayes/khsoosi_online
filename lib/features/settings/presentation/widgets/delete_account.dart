import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:khosousi_online/core/ui/widgets/custom_elevated_btn.dart';
import 'package:khosousi_online/core/utils/helpers/persistent_push.dart';
import 'package:khosousi_online/features/assistence/presentation/pages/contact_us_screen.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'حذف العضوية',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14),
        ),
        SizedBox(
          height: 8,
        ),
        RichText(
          text: TextSpan(children: [
            TextSpan(
                text: 'حذف العضوية: ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Roboto')),
            TextSpan(
              text:
                  'اذا كنت ترغب بحذف عضويتك من خصوصي اونلاين فضلا التواصل معنا لحذف عضويتك.',
              style: TextStyle(color: Colors.black54, fontFamily: 'Roboto'),
            ),
          ]),
        ),
        SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 30,
          child: CustomElevatedButton(
            label: 'تواصل معنا من أجل حذف عضويتك',
            onPressed: () {
              barPushScreen(
                context: context,
                screen: ContactUsScreen(),
              );
            },
            backgroundColor: Colors.red,
            icon: Icon(Icons.delete),
            foregroundColor: Colors.white,
          ),
        )
      ],
    );
  }
}
