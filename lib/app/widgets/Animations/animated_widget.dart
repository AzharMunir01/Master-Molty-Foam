import 'dart:math' as math;

import 'package:flutter/material.dart';


/// This is the stateful widget that the main application instantiates.
class RotatedImageWidget extends StatefulWidget {
  const RotatedImageWidget({Key? key}) : super(key: key);

  @override
  State<RotatedImageWidget> createState() => _RotatedImageWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _RotatedImageWidgetState extends State<RotatedImageWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 600),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SpinningContainer(controller: _controller);
  }
}

class SpinningContainer extends AnimatedWidget {
  const SpinningContainer({
    Key? key,
    required AnimationController controller,
  }) : super(key: key, listenable: controller);

  Animation<double> get _progress => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Center(
          child: Wrap(
            children: [
              SizedBox(
                height: 80.0,
                width: 80.0,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.white, width: 7.0),
                  ),
                  child: Transform.rotate(
                    angle: _progress.value * 2.0 * math.pi,
                    child: Image(image: AssetImage("assets/images/QmszQi.png")),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
