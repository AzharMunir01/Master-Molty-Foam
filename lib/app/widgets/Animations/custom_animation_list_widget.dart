import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';


class CustomAnimationLimiterWidget extends StatelessWidget {
  final List<Widget>? childrens;
  double? sizeRatio;

  CustomAnimationLimiterWidget({
    Key? key,
    @required this.childrens,
    this.sizeRatio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: SizedBox(
        height: sizeRatio,
        child: AnimationLimiter(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 300),
                  childAnimationBuilder: (widget) => SlideAnimation(
                        verticalOffset: 150.0,
                        child: FadeInAnimation(
                          child: widget,
                        ),
                      ),
                  children: childrens!),
            ),
          ),
        ),
      ),
    );
  }
}
