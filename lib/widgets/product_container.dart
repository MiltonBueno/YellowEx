import 'dart:io';

import 'package:flutter/material.dart';
import '../bloc/home_bloc.dart';
import '../classes/product.dart';

Widget productContainer(context, HomeBloc homeBloc, Product product){

  var size = MediaQuery.of(context).size;
  var shortestSide = MediaQuery.of(context).size.shortestSide;
  final bool useMobileLayout = shortestSide < 600;

  return
    Container(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        // border: Border.all(
        //   color: Colors.grey.withOpacity(0.5),
        //   width: 2
        // )
      ),
      child: Column(
        children: [
          Flexible(
              flex: 4,
              child: Stack(
                children: [
                  SizedBox(
                      height: double.maxFinite,
                      width: double.maxFinite,
                      child: product.image ?? Image.file(File(product.imageAsset), fit: BoxFit.contain)
                  ),
                  Positioned(
                      top: 5,
                      right: 5,
                      child: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 5.0,
                              )
                            ],
                          ),
                          child: StreamBuilder<double>(
                              stream: homeBloc.favoriteInitialSize.stream,
                              initialData: 35,
                              builder: (context, favoriteInitialSize) {
                                return StreamBuilder<Color>(
                                    stream: homeBloc.favoriteInitialColor.stream,
                                    initialData: Colors.black,
                                    builder: (context, favoriteInitialColor) {
                                      return StreamBuilder<double>(
                                          stream: homeBloc.favoriteFinalSize.stream,
                                          initialData: 35,
                                          builder: (context, favoriteFinalSize) {
                                            return StreamBuilder<Color>(
                                                stream: homeBloc.favoriteFinalColor.stream,
                                                initialData: Colors.black,
                                                builder: (context, favoriteFinalColor) {
                                                  return GestureDetector(
                                                    onTap: (){
                                                      homeBloc.favoriteProduct();
                                                    },
                                                    onLongPress: (){
                                                      homeBloc.favoriteProductMulticolor();
                                                    },
                                                    child: StreamBuilder<int>(
                                                        stream: homeBloc.statePhase.stream,
                                                        initialData: 1,
                                                        builder: (context, statePhase) {
                                                          return Padding(
                                                            padding: const EdgeInsets.only(top: 3.0),
                                                            child: TweenAnimationBuilder<double>(
                                                                duration: const Duration(milliseconds: 125),
                                                                tween: Tween<double>(
                                                                  begin: favoriteInitialSize.data,
                                                                  end: favoriteFinalSize.data,
                                                                ),
                                                                builder: (BuildContext context, double size, Widget? child) {
                                                                  return StreamBuilder<double>(
                                                                      stream: homeBloc.tValue.stream,
                                                                      initialData: 1,
                                                                      builder: (context, tValue) {
                                                                        double initialSize = favoriteInitialSize.data!;
                                                                        double finalSize = favoriteFinalSize.data!;
                                                                        return Icon(
                                                                          Icons.favorite,
                                                                          size: size,
                                                                          // color: Colors.red,
                                                                          color: Color.lerp(
                                                                              favoriteInitialColor.data,
                                                                              favoriteFinalColor.data,
                                                                              // tValue.data!
                                                                              (initialSize > finalSize)
                                                                                  ? ((initialSize / size - 1) / ((initialSize / finalSize) - 1))
                                                                                  : (initialSize < finalSize)
                                                                                  ? ((size / initialSize - 1) / ((finalSize / initialSize) - 1))
                                                                                  : 0
                                                                          ),
                                                                        );
                                                                      }
                                                                  );
                                                                }
                                                            ),
                                                          );
                                                        }
                                                    ),
                                                  );
                                                }
                                            );
                                          }
                                      );
                                    }
                                );
                              }
                          )
                      )
                  )
                ],
              )
          ),
          Flexible(
              flex: 2,
              child: Column(
                children: [
                  Flexible(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "R\$ ${product.value.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        product.name,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ],
              )
          ),
        ],
      ),
    );
}