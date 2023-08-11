import 'package:flutter/material.dart';
import 'package:yellow_exchange/bloc/my_listings_bloc.dart';

import '../bloc/home_bloc.dart';

Widget myListings(context, HomeBloc homeBloc){

  MyListingsBloc myListingsBloc = MyListingsBloc();

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
            GestureDetector(
              onTap: (){
                myListingsBloc.pickImageFromGallery();
              },
              child: SizedBox(
                width: size.width,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text("My listings", style: TextStyle(fontSize: 30),),
                    ],
                  ),
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