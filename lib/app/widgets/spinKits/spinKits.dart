import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../theme/color.dart';

class SpinKits extends StatefulWidget {
  final double? size;
  const SpinKits({Key? key, this.size}) : super(key: key);

  @override
  _SpinKitsState createState() => _SpinKitsState(size: size);
}

class _SpinKitsState extends State<SpinKits> with TickerProviderStateMixin {
  double? size;
  // AnimationController? animationController;

  _SpinKitsState({this.size});

  @override
  Widget build(BuildContext context) {
    return const Center(

      child: CircleAvatar(
        radius: 50,
      backgroundColor: Colors.white,
      child: SpinKitCircle(

        color: FColors.primaryDarkColor,
        size:80,
        duration: Duration(milliseconds: 2000),

      ),),);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    /*if (animationController != null) {
      animationController!.dispose();
    }*/
    super.dispose();
  }
}
