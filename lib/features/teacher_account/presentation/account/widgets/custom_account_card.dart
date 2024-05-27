
import 'package:flutter/material.dart';

class CustomAccountCard extends StatelessWidget {
  final Widget? child;
  final bool? isList;
  final String? title;
  final List<Widget>? childrenList;
  const CustomAccountCard({
    Key? key,
    this.child,
    this.isList,
    this.title,
    this.childrenList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(
        10,
      ),
      shadowColor: Colors.black,
      child: Card(
        elevation: 1,
        margin: EdgeInsets.symmetric(horizontal: 12),
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          child: isList == null
              ? child
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      title!,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    ...[
                      for (int index = 0; index < childrenList!.length; index++)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            childrenList![index],
                            if (index < childrenList!.length - 1)
                              Divider(
                                height: 1,
                                color: Colors.grey.shade300,
                              )
                          ],
                        )
                    ]
                  ],
                ),
        ),
      ),
    );
  }
}
