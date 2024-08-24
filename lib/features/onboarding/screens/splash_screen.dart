import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:skin_care/dependency_injection.dart';
import 'package:skin_care/features/Profile/controller/profile_bloc.dart';
import 'package:skin_care/features/Profile/controller/profile_event.dart';
import 'package:skin_care/features/auth/screens/login_screen.dart';
import 'package:skin_care/features/bottom_nav_bar/Screens/bottom_bar.dart';
import 'package:skin_care/features/chats/controller/chat_bloc/chat_bloc.dart';
import 'package:skin_care/features/onboarding/controller/splash_bloc.dart';

import '../../home/controllers/product/product_bloc.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productBloc = BlocProvider.of<ProductBloc>(context);

    // Dispatch the FetchFavoriteListEvent to fetch the favorite list when the screen is initialized
    // context.read<ProductBloc>().fetchFavouriteList();
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state.status == SplashStatus.success) {
            log("Redirecting...");
            if (storage.read('onborded') == true) {
              if (storage.read('islogin') == true) {
                context.read<ProfileBloc>().add(GetUserDetail());
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  BottomNavBar.id,
                  (route) => false,
                );
              } else {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  LoginScreen.id,
                  (route) => false,
                );
              }
            } else {
              Navigator.pushNamedAndRemoveUntil(
                context,
                OnboardingScreen.id,
                (route) => false,
              );
            }

            // Navigate to the onboarding screen

            // Navigator.of(context).pushReplacement(
            //   MaterialPageRoute(builder: (context) => const OnboardingScreen()),
            // );
          }
        },
        child: Center(
          child: Image.asset("assets/logo/skin_care_logo.png"),
        ),
      ),
    );
  }
}
