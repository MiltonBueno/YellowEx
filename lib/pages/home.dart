import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {

  PageController pageController = PageController();
  int selectedIndex = 0;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool useMobileLayout = shortestSide < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: pageController,
        onPageChanged: (index){
          setState(() {
            selectedIndex = index;
          });
        },
        children: [
          home(context),
          favorites(context),
          myListings(context),
          cart(context),
          profile(context)
        ],
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFFFFFFFF),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: GNav(
            color: const Color(0xFFFFCC33),
            activeColor: const Color(0xFFFFA500),
            tabBorderRadius: 15,
            tabBackgroundColor: const Color(0xFFFF9933).withOpacity(0.1),
            gap: 8,
            padding: const EdgeInsets.all(12),
            onTabChange: (index){
              setState(() {
                selectedIndex = index;
                pageController.animateToPage(index, duration: const Duration(milliseconds: 350), curve: Curves.fastOutSlowIn);
              });
            },
            duration: const Duration(milliseconds: 350),
            selectedIndex: selectedIndex,
            tabs: const [
              GButton(icon: Icons.home_filled, text: "Home",),
              GButton(icon: Icons.favorite, text: "Favorites",),
              GButton(icon: Icons.shopping_bag, text: "My Listings",),
              GButton(icon: Icons.shopping_cart, text: "Cart",),
              GButton(icon: Icons.person, text: "Profile",),
            ],
            // tabBackgroundGradient: LinearGradient(
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            //   colors: [
            //     const Color(0x3369BEA0).withOpacity(0.0), // cor transparente no início do gradiente
            //     // const Color(0x3369BEA0).withOpacity(0.0), // cor transparente no início do gradiente
            //     const Color(0x3369BEA0).withOpacity(0.35), // cor da sombra com transparência
            //   ],
            // ),
          ),
        ),
      ),
    );
  }
  
  Widget home(context){

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
                                      onPressed: () {},
                                    ),
                                  ),
                                  const Positioned(top: 10, right: 10, child: Icon(Icons.circle, size: 12, color: Color(0xFFFFCC33),))
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
                      // Text("Home", style: TextStyle(fontSize: 30),),
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

  Widget favorites(context){

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
                      Text("Favorites", style: TextStyle(fontSize: 30),),
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

  Widget myListings(context){

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
                      Text("My listings", style: TextStyle(fontSize: 30),),
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

  Widget cart(context){

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
                      Text("Cart", style: TextStyle(fontSize: 30),),
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

  Widget profile(context){

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
  
}
