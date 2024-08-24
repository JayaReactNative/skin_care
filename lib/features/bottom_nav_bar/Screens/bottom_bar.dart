import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skin_care/features/chats/controller/chat_bloc/chat_bloc.dart';
import 'package:skin_care/features/favourite/favourite_screen.dart';
import 'package:skin_care/features/Profile/screens/profile_screen.dart';
import 'package:skin_care/features/onboarding/screens/login_signup.dart';
import 'package:skin_care/features/setting/model/language_model.dart';

import '../../chats/screens/chatscreen.dart';
import '../../chats/screens/image_history.dart';
import '../../home/screens/home_screen.dart';

class BottomNavBar extends StatefulWidget {
  static const id = '/BottomNavBar';
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // void _onItemTapped(int index) {
  //   _pageController.animateToPage(index,
  //       duration: const Duration(milliseconds: 10),
  //       curve: Curves.fastOutSlowIn);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeScreen(),
          ImageHistory(),
          ChatScreen(),
          FavouriteScreen(),
          ProfileScreen(),
        ],
      ),
      //  PageView(
      //   controller: _pageController,
      //   physics: const NeverScrollableScrollPhysics(),
      //   onPageChanged: (index) {
      //     setState(() {
      //       _selectedIndex = index;
      //     });
      //   },
      //   children: [
      //     //
      //     HomeScreen(),

      //     ChatScreen(),
      //     FavouriteScreen(),

      //     ProfileScreen(), //
      //   ],
      // ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomNavigationBar(
          //     currentIndex: _selectedIndex,
          // onTap: (index) {
          //   setState(() {
          //     _selectedIndex = index;
          //   });
          // },

          backgroundColor: Color.fromARGB(255, 255, 234, 237),
          elevation: 8,

          type: BottomNavigationBarType.fixed,
          // type: ,
          // fixedColor: Colors.green,

          // unselectedLabelStyle: TextStyle(color: Colors.black),
          showUnselectedLabels: true,

          unselectedItemColor: const Color.fromARGB(255, 0, 0, 0),
          unselectedFontSize: 14,
          selectedFontSize: 14,
          // selectedLabelStyle: const TextStyle(
          //     fontWeight: FontWeight.bold, color: Colors.black),
          // // iconSize: 25,
          // unselectedLabelStyle:
          //     TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              activeIcon: ImageIcon(
                AssetImage(
                  'assets/icons/home.png',
                ),
                size: 20,
                color: Color.fromARGB(255, 195, 5, 34),
              ),
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              icon: ImageIcon(
                AssetImage(
                  'assets/icons/home1.png',
                ),
                color: Color.fromARGB(255, 195, 5, 34),
                size: 20,
              ),
              label: translate(context).lbl_nav_home,
            ),
            BottomNavigationBarItem(
              activeIcon: ImageIcon(
                AssetImage(
                  'assets/icons/history.png',
                ),
                size: 20,
                color: Color.fromARGB(255, 195, 5, 34),
              ),
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              icon: ImageIcon(
                AssetImage(
                  'assets/icons/history.png',
                ),
                color: Color.fromARGB(255, 195, 5, 34),
                size: 20,
              ),
              label: translate(context).lbl_nav_history,
            ),
            BottomNavigationBarItem(
              activeIcon: ImageIcon(
                AssetImage(
                  'assets/icons/chat1.png',
                ),
                color: Color.fromARGB(255, 195, 5, 34),
                size: 20,
              ),
              icon: ImageIcon(
                AssetImage('assets/icons/chat1.png'),
                color: Color.fromARGB(255, 195, 5, 34),
                size: 20,
              ),
              label: translate(context).lbl_nav_chat,
            ),
            BottomNavigationBarItem(
              activeIcon: ImageIcon(
                AssetImage(
                  'assets/icons/heart.png',
                ),
                color: Color.fromARGB(255, 195, 5, 34),
                size: 20,
              ),
              icon: ImageIcon(
                AssetImage('assets/icons/heart1.png'),
                color: Color.fromARGB(255, 195, 5, 34),
                size: 20,
              ),
              label: translate(context).lbl_nav_favourite,
            ),
            BottomNavigationBarItem(
              activeIcon: ImageIcon(
                AssetImage(
                  'assets/icons/avatar.png',
                ),
                color: Color.fromARGB(255, 195, 5, 34),
                size: 20,
              ),
              icon: ImageIcon(
                AssetImage('assets/icons/avatar1.png'),
                color: Color.fromARGB(255, 195, 5, 34),
                size: 20,
              ),
              label: translate(context).lbl_nav_profile,
            ),
          ],
          currentIndex: _selectedIndex,

          selectedItemColor: Color.fromARGB(255, 0, 0, 0),
          onTap: (index) {
            setState(() {
              if (index == 2) {
                Navigator.pushNamed(context, ChatScreen.id);
                BlocProvider.of<ChatBloc>(context).add(ChatLoadEvent());
              } else {
                _selectedIndex = index;
              }
            });
          },
        ),
      ),
    );
  }
}
