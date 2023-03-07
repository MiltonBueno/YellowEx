import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  // late Widget _myAnimatedWidget;
  double value = 100;

  Widget _myAnimatedWidget = Image.asset(key: const Key("1"), "assets/logo_animada.gif");

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // _myAnimatedWidget = Image.asset(key: const Key("2"), "assets/logo_animada.gif");
      // Timer(const Duration(milliseconds: 4000), () async {
      //   setState(() {
      //     _myAnimatedWidget = Padding(
      //       key: const Key("3"),
      //       padding: const EdgeInsets.only(top: 5, left: 2),
      //       child: Image.asset("assets/logo_extensa_A.png"),
      //     );
      //   });
      // });
      Timer(const Duration(milliseconds: 4000), () async {
        setState(() {
          _myAnimatedWidget = Padding(
            key: const Key("2"),
            padding: const EdgeInsets.only(top: 5, left: 2),
            child: Image.asset("assets/logo_extensa_B.png"),
          );
        });
      });
    });
    // _animationController.forward().then((value){
    //   setState(() {
    //     _myAnimatedWidget = Image.asset("assets/logo_extensa_A.gif");
    //   });
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool useMobileLayout = shortestSide < 600;

    return Container(
      color: Colors.white,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.2, vertical: size.height * 0.2),
          child: AnimatedSwitcher(
            // switchOutCurve: Curves.bounceOut,
            // switchInCurve: Curves.easeInOutCubic,
            // transitionBuilder: (widget, animation) => RotationTransition(
            //   // alignment: Alignment.bottomCenter,
            //   turns: animation,
            //   child: widget,
            // ) ,
            duration: const Duration(milliseconds: 1500),
            child: _myAnimatedWidget
          ),
        ),
      ),
    );
  }
}