import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yellow_exchange/widgets/product_container.dart';
import '../bloc/home_bloc.dart';
import '../classes/category.dart';
import '../classes/product.dart';
import 'fast_filter.dart';

Widget home(context, HomeBloc homeBloc){

  var size = MediaQuery.of(context).size;
  var shortestSide = MediaQuery.of(context).size.shortestSide;
  final bool useMobileLayout = shortestSide < 600;
  final appBarHeight = MediaQuery.of(context).padding.top;

  return Column(
    children: [
      Expanded(child: Container(
        color: Colors.white,
        child: Stack(
          // alignment: Alignment.center,
          children: [
            SizedBox(
              height: size.height - 80,
              width: size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: appBarHeight + 8, left: size.width * 0.025, right: size.width * 0.025),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            flex: 4,
                            child: TextField(
                              cursorColor: const Color(0xFFFFCC33),
                              decoration: InputDecoration(
                                  hintText: 'Search for products...',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.search),
                                    onPressed: () {},
                                  ),
                                  // focusColor: const Color(0xFFFFCC33),
                                  // iconColor: const Color(0xFFFFCC33),
                                  suffixIconColor: Colors.black54
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    // top: 0,
                                    // left: 0,
                                    // right: 0,
                                    // bottom: 0,
                                    child: IconButton(
                                      // iconSize: 30,
                                      icon: const Icon(FontAwesomeIcons.bell, color: Colors.black54,),
                                      onPressed: () {
                                        homeBloc.openNotificationPage();
                                      },
                                    ),
                                  ),
                                  StreamBuilder<bool>(
                                    stream: homeBloc.notificationWasRead.stream,
                                    initialData: true,
                                    builder: (context, wasRead) {
                                      return Visibility(visible: !wasRead.data!, child: const Positioned(top: 10, right: 10, child: Icon(Icons.circle, size: 12, color: Color(0xFFFFCC33),)));
                                    }
                                  )
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: IconButton(
                                iconSize: 30,
                                icon: const Icon(Icons.filter_alt_outlined, color: Colors.black54,),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.025),
                      child: Container(
                        height: 125,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.blueAccent.shade400, Colors.yellow.shade400],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: const Center(
                          child: Text(
                            'Advertisement',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    fastFilter(context, homeBloc),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      child: GridView.count(
                        crossAxisSpacing: size.width * 0.05,
                        mainAxisSpacing: size.width * 0.05,
                        padding: EdgeInsets.only(bottom: size.width * 0.05),
                        crossAxisCount: 2,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        childAspectRatio: 0.75,
                        children: [
                          productContainer(context, homeBloc, ProductClass(id: 0, name: "Smartphone Samsung Galaxy", value: 2000.00, category: Category.electronics, image: Image.asset("assets/celular_s21.jpg", fit: BoxFit.contain), imageAsset: '')),
                          productContainer(context, homeBloc, ProductClass(id: 1, name: "Produto qualquer", value: 150.00, category: Category.recreation, image: Image.asset("assets/forgot_password.jpg", fit: BoxFit.contain), imageAsset: '')),
                          productContainer(context, homeBloc, ProductClass(id: 2, name: "Fundo de tela", value: 300.00, category: Category.clothing, image: Image.file(File("/data/user/0/com.example.yellow_exchange/cache/ba2a3a23-a1e0-4fdd-93b2-3a6f81df61774085202887462916278.jpg"), fit: BoxFit.contain), imageAsset: '')),
                        ],
                      ),
                    ),
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