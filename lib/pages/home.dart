import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(child: Container(color: Colors.white,)),
          Align(
            alignment: Alignment.bottomCenter,
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
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Color(0xFFFFFFFF),
        // color: Color(0xff1a1a1a),
        // color: Color(0xff1a2a28),
        // color: Colors.yellow.shade700.withOpacity(0.7),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: GNav(
            // backgroundColor: const Color(0xff1a2a28).withOpacity(0),
            color: const Color(0xFF69BEA0),
            // color: const Color(0xffFFA500),
            // color: const Color(0xffF5C13D),
            // color: const Color(0xff1a2a28),
            activeColor: Color(0xFF1a2a28),
            // activeColor: Color(0xffF2A007),
            // activeColor: Color(0xff1a2a28),
            tabBorderRadius: 15,
            tabBackgroundColor: Color(0x3369BEA0).withOpacity(0.2),
            // tabBackgroundColor: Colors.green.withOpacity(0.5),
            // tabBackgroundColor: Colors.yellow.shade600.withOpacity(0.5),
            gap: 8,
            padding: EdgeInsets.all(16),
            tabs: [
              GButton(icon: Icons.home_filled, text: "Home",),
              GButton(icon: Icons.favorite, text: "Favorites",),
              GButton(icon: Icons.compass_calibration, text: "Discover",),
              GButton(icon: Icons.shopping_cart, text: "Cart",),
              GButton(icon: Icons.person, text: "Profile",),
            ],
          ),
        ),
      ),
    );
  }
}
