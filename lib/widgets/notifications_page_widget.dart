import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../bloc/home_bloc.dart';

Widget notificationsPage(context, HomeBloc homeBloc){

  var size = MediaQuery.of(context).size;
  var shortestSide = MediaQuery.of(context).size.shortestSide;
  final bool useMobileLayout = shortestSide < 600;
  final appBarHeight = MediaQuery.of(context).padding.top;

  return Scaffold(
    body: Container(
      width: size.width,
      height: size.height,
      color: Colors.grey.shade200,
      child: StreamBuilder<bool>(
        stream: homeBloc.isNotificationPageAlreadyOpen.stream,
        initialData: false,
        builder: (context, isOpen) {
          return !isOpen.data! ? const SizedBox.shrink() : Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: appBarHeight),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      homeBloc.closeNotificationPage();
                    },
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Notifications",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 15),
                  width: size.width,
                  // color: Colors.blueAccent,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          StreamBuilder<bool>(
                              stream: homeBloc.notificationWasRead.stream,
                              initialData: true,
                              builder: (context, wasRead) {
                              return GestureDetector(
                                onTap: (){
                                  homeBloc.notificationWasRead.sink.add(true);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  height: 90,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    color: wasRead.data! ? Colors.grey.shade100 : Colors.white,
                                    border: const Border.symmetric(
                                      horizontal: BorderSide(
                                        color: Colors.grey,
                                        width: 1.5
                                      )
                                    )
                                  ),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        flex: 9,
                                        child: Text(
                                          "Welcome to the YellowEx app! Please feel free to test the functionalities. You can also access our code on GitHub and contribute if you'd like!",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: wasRead.data! ? FontWeight.normal : FontWeight.bold,

                                          ),
                                        ),
                                      ),
                                      wasRead.data! ? const SizedBox.shrink() : const Flexible(
                                          flex: 1,
                                          child: Center(
                                            child: Icon(Icons.circle, size: 16, color: Color(0xFFD2A30B)),
                                          )
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        }
      ),
    ),
  );
}