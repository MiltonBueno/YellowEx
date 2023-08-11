import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:yellow_exchange/bloc/home_bloc.dart';
import 'package:yellow_exchange/widgets/notifications_page_widget.dart';
import '../widgets/cart_page_widget.dart';
import '../widgets/favorites_page_widget.dart';
import '../widgets/home_page_widget.dart';
import '../widgets/my_listings_page_widget.dart';
import '../widgets/profile_page_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> with TickerProviderStateMixin {

  PageController pageController = PageController();
  int selectedIndex = 0;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    HomeBloc homeBloc = HomeBloc();

    var size = MediaQuery.of(context).size;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool useMobileLayout = shortestSide < 600;
    final appBarHeight = MediaQuery.of(context).padding.top;

    return StreamBuilder<bool>(
        stream: homeBloc.isNotificationPageOpen.stream,
        initialData: false,
        builder: (context, isOpen) {
        return Stack(
          children: [
            Positioned(
              child: Scaffold(
                backgroundColor: Colors.white,
                body: PageView(
                  controller: pageController,
                  onPageChanged: (index){
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  children: [
                    home(context, homeBloc),
                    favorites(context, homeBloc),
                    myListings(context, homeBloc),
                    cart(context, homeBloc),
                    profile(context, homeBloc)
                  ],
                ),
                bottomNavigationBar: Container(
                  height: 80,
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
              ),
            ),
            AnimatedPositioned(
              top: isOpen.data! ? 0 : appBarHeight + 14,
              bottom: isOpen.data! ? 0 : size.height  - (appBarHeight + 14),
              left: isOpen.data! ? 0 : size.width * (4.5 / 6),
              right: isOpen.data! ? 0 : size.width * (1.5 / 6),
              duration: const Duration(milliseconds: 150),
              child: GestureDetector(
                onTap: (){
                  homeBloc.closeNotificationPage();
                },
                child: notificationsPage(context, homeBloc)
              )
            ),
          ],
        );
      }
    );
  }

}


