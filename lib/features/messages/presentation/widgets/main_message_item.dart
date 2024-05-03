import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';
import 'package:khosousi_online/features/messages/presentation/pages/messages_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MainMessageItem extends StatelessWidget {
  const MainMessageItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
         PersistentNavBarNavigator.pushNewScreen(context,
            screen: MessagesScreen(), withNavBar: false, pageTransitionAnimation :PageTransitionAnimation.slideUp);
      },
      child: Container(
        height: 80,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Stack(alignment: Alignment.centerRight, children: [
          Row(
            children: [
              CustomImage(
                image:
                    'https://images.unsplash.com/photo-1568602471122-7832951cc4c5?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fHVzZXIlMjBwcm9maWxlfGVufDB8fDB8fHww',
                radius: 24,
                isCircle: true,
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                     'مرحبا كيف حالك',
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 14,
                        // color: Colors.grey
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            top: 2,
            child: Container(
              // color: Colors.blue,
              child: Text(
                DateFormat('dd-MM-yyyy ').format(DateTime.now()).toString(),
                style: TextStyle(
                  fontSize: 12,
                  color: ColorManager.gray4
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
