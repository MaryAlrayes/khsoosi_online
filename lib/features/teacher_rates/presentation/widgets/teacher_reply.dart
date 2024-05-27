import 'package:flutter/cupertino.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';
import 'package:khosousi_online/core/ui/widgets/custom_read_text.dart';

class TeacherReply extends StatelessWidget {
  const TeacherReply({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8).copyWith(top: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: ColorManager.gray3.withOpacity(.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildName(),
                  SizedBox(height: 8),
                  _buildComment(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Flexible _buildComment(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: Container(
        width: (MediaQuery.of(context).size.width - 48 - 48) / 1.2,
        child: CustomReadText(
          text: 'تسلمي شكرا',
          trimLines: 2,
        ),
      ),
    );
  }

  Text _buildName() {
    return Text(
      'adnan s',
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Padding _buildImage() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        alignment: Alignment.topRight,
        child: CustomImage(
          image: EndPointsManager.maleUserDefaultImageBaseUrl,
          isCircle: true,
          radius: 10,
        ),
      ),
    );
  }
}
