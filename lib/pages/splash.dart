import 'dart:async';
import 'package:flutter/material.dart';
import 'package:yellow_exchange/bloc/splash_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  SplashBloc splashBloc = SplashBloc();

  late Image backgroundImage;
  late Image forgotPasswordImage;

  double value = 100;
  Widget _myAnimatedWidget = Image.asset(key: const Key("1"), "assets/logo_animada.gif");

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Timer(const Duration(milliseconds: 4000), () async {
        setState(() {
          _myAnimatedWidget = Padding(
            key: const Key("2"),
            padding: const EdgeInsets.only(top: 5, left: 2),
            child: Image.asset("assets/logo_extensa_B.png"),
          );
        });
        Timer(const Duration(milliseconds: 1500), () async {
          splashBloc.getUserLoggedAndDefineRoute(context);
        });

      });
    });
    super.initState();
    backgroundImage = Image.asset("assets/login_white.png");
    forgotPasswordImage = Image.asset("assets/forgot_password.png");
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    precacheImage(backgroundImage.image, context);
    precacheImage(forgotPasswordImage.image, context);
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool useMobileLayout = shortestSide < 600;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/login_white.png"),
          fit: BoxFit.cover,
        ),
      ),
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