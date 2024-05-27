import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/style/common_styles.dart';
import 'package:khosousi_online/core/ui/widgets/custom_elevated_btn.dart';
import 'package:khosousi_online/core/ui/widgets/custom_text_field.dart';
import 'package:khosousi_online/core/utils/helpers/launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaScreen extends StatelessWidget {
  SocialMediaScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مواقع التواصل الاجتماعي'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'حابب تتواصل معنا؟',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'عندك أي استفسارات, اقتراحات, شكاوى؟ اختر الطريقة التي تناسبك ووصلها لنا...',
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(
                height: 24,
              ),
              Expanded(
                child: ListView(
                  children: [
                    _buildFacebook(),
                    Divider(
                      height: 1,
                      color: Colors.grey.shade300,
                    ),
                    _buildYoutube(),
                    Divider(
                      height: 1,
                      color: Colors.grey.shade300,
                    ),
                    _buildInstagram(),
                    Divider(
                      height: 1,
                      color: Colors.grey.shade300,
                    ),
                    _buildWhatsapp(),
                    Divider(
                      height: 1,
                      color: Colors.grey.shade300,
                    ),
                    _buildX(),
                    Divider(
                      height: 1,
                      color: Colors.grey.shade300,
                    ),
                    _buildTiktok()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListTile _buildTiktok() {
    return ListTile(
      onTap: () async {
        await CustomLauncher.launchUrl('https://www.tiktok.com/@khsoosi.com');
      },
      title: Text('TikTok'),
      subtitle: Text('تواصل معنا على تكتوك'),
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: ColorManager.black,
        child: Icon(
          FontAwesomeIcons.tiktok,
          color: Colors.white,
        ),
      ),
    );
  }

  ListTile _buildX() {
    return ListTile(
      onTap: () async {
        await CustomLauncher.launchUrl('https://www.twitter.com/khsoosi');
      },
      title: Text('منصة X'),
      subtitle: Text('تواصل معنا على منصة X'),
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: ColorManager.black,
        child: Icon(
          FontAwesomeIcons.xTwitter,
          color: Colors.white,
        ),
      ),
    );
  }

  ListTile _buildWhatsapp() {
    return ListTile(
      onTap: () async {
        await CustomLauncher.launchUrl('https://wa.me/971521746493');
      },
      title: Text('WhatsApp'),
      subtitle: Text('971521746493+'),
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Color(0xff0CBC87),
        child: Icon(
          FontAwesomeIcons.whatsapp,
          color: Colors.white,
        ),
      ),
    );
  }

  ListTile _buildInstagram() {
    return ListTile(
      onTap: () async {
        await CustomLauncher.launchUrl('https://www.instagram.com/khsoosi_edu');
      },
      title: Text('Instagram'),
      subtitle: Text('تواصل معنا على انستغرام'),
      leading: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: [
              Color(0xffFD8760),
              Color(0xffDD2D92),
              Color(0xff7B40C7),
            ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
        child: CircleAvatar(
            radius: 25,
            child: Icon(
              FontAwesomeIcons.instagram,
              color: Colors.white,
            ),
            backgroundColor: Colors.transparent),
      ),
    );
  }

  ListTile _buildYoutube() {
    return ListTile(
      onTap: () async {
        await CustomLauncher.launchUrl(
            'https://www.youtube.com/channel/UCGbNZCEu7qvEWj688Jt8XYg');
      },
      title: Text('Youtube'),
      subtitle: Text('تواصل معنا على يوتيوب'),
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Color(0xffff0000),
        child: Icon(
          FontAwesomeIcons.youtube,
          color: Colors.white,
        ),
      ),
    );
  }

  ListTile _buildFacebook() {
    return ListTile(
      onTap: () async {
        await CustomLauncher.launchUrl('https://facebook.com/teacherprivate1');
      },
      title: Text('Facebook'),
      subtitle: Text('تواصل معنا على فيسبوك'),
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Color(0xff5D82D1),
        child: Icon(
          FontAwesomeIcons.facebookF,
          color: Colors.white,
        ),
      ),
    );
  }
}
