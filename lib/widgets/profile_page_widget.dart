import 'package:flutter/material.dart';
import '../bloc/home_bloc.dart';

Widget profile(context, HomeBloc homeBloc){

  var size = MediaQuery.of(context).size;
  var shortestSide = MediaQuery.of(context).size.shortestSide;
  final bool useMobileLayout = shortestSide < 600;

  return Column(
    children: [
      Expanded(child: Container(
        color: Colors.white,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: size.width,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text("Profile", style: TextStyle(fontSize: 30),),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 25,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent, // cor transparente no início do gradiente
                      Colors.grey.withOpacity(0.15), // cor da sombra com transparência
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    ],
  );
}