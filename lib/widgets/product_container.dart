import 'dart:io';

import 'package:flutter/material.dart';
import '../bloc/home_bloc.dart';
import '../classes/product.dart';

Widget productContainer(context, HomeBloc homeBloc, ProductClass product){

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
                          child: StreamBuilder<List<int>>(
                            stream: homeBloc.favoritedProductsIds.stream,
                            initialData: const [],
                            builder: (context, favoritedProductsIds) {
                              return StreamBuilder<int>(
                                stream: homeBloc.selectedProduct.stream,
                                initialData: 0,
                                builder: (context, selectedProduct) {
                                  return GestureDetector(
                                    onTap: (){
                                      homeBloc.favoriteProduct(homeBloc.isThisProductFavorited(product.id), product);
                                    },
                                    onLongPress: (){
                                      homeBloc.favoriteProductMulticolor(homeBloc.isThisProductFavorited(product.id), product);
                                    },
                                    child: StreamBuilder<Favorite>(
                                      stream: homeBloc.favorite.stream,
                                      initialData: Favorite(favoriteFinalColor: Colors.black, favoriteInitialColor: Colors.black, favoriteFinalSize: 35, favoriteInitialSize: 35),
                                      builder: (context, favorite) {
                                        Favorite favoriteData = favorite.data ?? Favorite(favoriteFinalColor: Colors.black, favoriteInitialColor: Colors.black, favoriteFinalSize: 35, favoriteInitialSize: 35);
                                        double initialSize = 35;
                                        double finalSize = 35;
                                        Color initialColor = favoritedProductsIds.data!.contains(product.id) ?  Colors.red : Colors.black;
                                        Color finalColor = favoritedProductsIds.data!.contains(product.id) ?  Colors.black : Colors.red;
                                        if(selectedProduct.data == product.id){
                                          initialColor = favoritedProductsIds.data!.contains(product.id) ?  Colors.red : Colors.black;
                                          finalColor = favoritedProductsIds.data!.contains(product.id) ?  Colors.black : Colors.red;
                                          initialSize = favoriteData.favoriteInitialSize;
                                          finalSize = favoriteData.favoriteFinalSize;
                                          initialColor = favoriteData.favoriteInitialColor;
                                          finalColor = favoriteData.favoriteFinalColor;
                                        }
                                        return Padding(
                                          padding: const EdgeInsets.only(top: 3.0),
                                          child: TweenAnimationBuilder<double>(
                                              duration: const Duration(milliseconds: 125),
                                              tween: Tween<double>(
                                                begin: initialSize,
                                                end: finalSize,
                                              ),
                                              builder: (BuildContext context, double size, Widget? child) {
                                                return StreamBuilder<double>(
                                                    stream: homeBloc.tValue.stream,
                                                    initialData: 1,
                                                    builder: (context, tValue) {
                                                      return StreamBuilder<bool>(
                                                        stream: homeBloc.deactivateFavorite.stream,
                                                        initialData: false,
                                                        builder: (context, deactivate) {
                                                          return deactivate.data! && selectedProduct.data == product.id
                                                              ? favoritedProductsIds.data!.contains(product.id) ? Icon(Icons.favorite, size: size, color: Colors.black,) : Icon(Icons.favorite, size: size, color: Colors.red,)
                                                              : Icon(
                                                            Icons.favorite,
                                                            size: size,
                                                            // color: Colors.red,
                                                            color: Color.lerp(
                                                                initialColor,
                                                                finalColor,
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