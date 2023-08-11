import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../bloc/home_bloc.dart';
import '../classes/category.dart';

Widget fastFilter(context, HomeBloc homeBloc){

  var size = MediaQuery.of(context).size;
  var shortestSide = MediaQuery.of(context).size.shortestSide;
  final bool useMobileLayout = shortestSide < 600;

  return
    Container(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                "Filter by category",
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: StreamBuilder<String>(
                  stream: homeBloc.selectedCategory.stream,
                  initialData: "",
                  builder: (context, category) {
                    return Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10, left: 20),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.decelerate,
                            width: 100,
                            padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
                            decoration: BoxDecoration(
                                color: category.data == Category.electronics ? const Color(0xFFFFCC33).withOpacity(0.5) : Colors.white,
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: GestureDetector(
                              onTap: (){
                                if(category.data == Category.electronics){
                                  homeBloc.selectCategory("");
                                }else{
                                  homeBloc.selectCategory(Category.electronics);
                                }
                              },
                              child: Column(
                                children: const [
                                  SizedBox(
                                    height: 70,
                                    child: Icon(FontAwesomeIcons.mobile, size: 50,),
                                  ),
                                  Text("Electronics", style: TextStyle(
                                      fontWeight: FontWeight.w500
                                  ),)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 100,
                            padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
                            decoration: BoxDecoration(
                                color: category.data == Category.sports ? const Color(0xFFFFCC33).withOpacity(0.5) : Colors.white,
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: GestureDetector(
                              onTap: (){
                                if(category.data == Category.sports){
                                  homeBloc.selectCategory("");
                                }else{
                                  homeBloc.selectCategory(Category.sports);
                                }
                              },
                              child: Column(
                                children: const [
                                  SizedBox(
                                    height: 70,
                                    child: Icon(FontAwesomeIcons.basketball, size: 50,),
                                  ),
                                  Text("Sports", style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 100,
                            padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
                            decoration: BoxDecoration(
                                color: category.data == Category.recreation ? const Color(0xFFFFCC33).withOpacity(0.5) : Colors.white,
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: GestureDetector(
                              onTap: (){
                                if(category.data == Category.recreation){
                                  homeBloc.selectCategory("");
                                }else{
                                  homeBloc.selectCategory(Category.recreation);
                                }
                              },
                              child: Column(
                                children: const [
                                  SizedBox(
                                    height: 70,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 12),
                                      child: Icon(FontAwesomeIcons.bicycle, size: 50,),
                                    ),
                                  ),
                                  Text("Recreation", style: TextStyle(
                                      fontWeight: FontWeight.w500
                                  ),)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 100,
                            padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
                            decoration: BoxDecoration(
                                color: category.data == Category.instruments ? const Color(0xFFFFCC33).withOpacity(0.5) : Colors.white,
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: GestureDetector(
                              onTap: (){
                                if(category.data == Category.instruments){
                                  homeBloc.selectCategory("");
                                }else{
                                  homeBloc.selectCategory(Category.instruments);
                                }
                              },
                              child: Column(
                                children: const [
                                  SizedBox(
                                    height: 70,
                                    child: Icon(FontAwesomeIcons.guitar, size: 50,),
                                  ),
                                  Text("Instruments", style: TextStyle(
                                      fontWeight: FontWeight.w500
                                  ),)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 100,
                            padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
                            decoration: BoxDecoration(
                                color: category.data == Category.clothing ? const Color(0xFFFFCC33).withOpacity(0.5) : Colors.white,
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: GestureDetector(
                              onTap: (){
                                if(category.data == Category.clothing){
                                  homeBloc.selectCategory("");
                                }else{
                                  homeBloc.selectCategory(Category.clothing);
                                }
                              },
                              child: Column(
                                children: const [
                                  SizedBox(
                                    height: 70,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 12),
                                      child: Icon(FontAwesomeIcons.shirt, size: 50,),
                                    ),
                                  ),
                                  Text("Clothing", style: TextStyle(
                                      fontWeight: FontWeight.w500
                                  ),)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
              ),
            ),
          ],
        )
    );
}