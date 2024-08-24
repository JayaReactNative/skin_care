import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:skin_care/features/home/screens/home_screen.dart';
import 'package:skin_care/features/setting/model/language_model.dart';
import 'package:skin_care/main.dart';

import '../../../dependency_injection.dart';
import 'login_signup.dart';

class OnboardingScreen extends StatefulWidget {
  static const id = '/onboardingscreen';
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController pageController;
  double currentPage = 0;

  @override
  void initState() {
    pageController = PageController(initialPage: 0)
      ..addListener(() {
        setState(() {
          currentPage = pageController.page ?? 0.0;
        });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    List<Map<String, dynamic>> pageItem = [
      {
        "image": "assets/images/onboarding.png",
        "title": translate(context).lbl_slider_title,
        "desc":
            //  'Create a dedicated "Skincare Consultation" section where users can ask questions, seek advice, and provide feedback.',
            translate(context).lbl_slider_desc
      },
      {
        "image": "assets/images/onboarding.png",
        "title": translate(context).lbl_slider_title2,
        "desc":
            // 'Create a dedicated "Skincare Consultation" section where users can ask questions, seek advice, and provide feedback.',
            translate(context).lbl_slider_desc2
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              scrollDirection: Axis.horizontal,
              itemCount: pageItem.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: mq.height * 0.07,
                        ),
                        Image.asset(
                          pageItem[index]["image"] ??
                              "assets/images/onboarding.png",
                        ),
                        SizedBox(
                          height: mq.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: pageItem
                              .map((e) => Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      color: currentPage == pageItem.indexOf(e)
                                          ? Colors.red
                                          : Colors.red.shade100,
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    width: mq.width * 0.05,
                                    height: 5,
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          Text(
                            pageItem[index]["title"] ?? "title",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(
                            height: mq.height * 0.02,
                          ),
                          Text(
                            pageItem[index]["desc"] ?? "desc",
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: mq.width * 0.1),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              alignment:
                  currentPage == 0 ? Alignment.centerRight : Alignment.center,
              child: InkWell(
                onTap: () {
                  if (currentPage == 1) {
                    print("Navigating...");

                    Navigator.pushNamedAndRemoveUntil(
                        context, LoginSignUp.id, (route) => false);
                    storage.write('onborded', true);
                    // Navigator.pushAndRemoveUntil(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const LoginSignUp(),
                    //   ),
                    //   (route) => false,
                    // );
                  }
                  if (currentPage < pageItem.length - 1) {
                    // Increment the current page index and animate to it
                    pageController.animateToPage(
                      currentPage.toInt() + 1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear,
                    );
                  }
                },
                child: AnimatedContainer(
                  alignment: Alignment.center,
                  width: currentPage == 0 ? mq.width * 0.15 : mq.width * 0.7,
                  height: mq.width * 0.15,
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    gradient: LinearGradient(
                      colors: [
                        const Color.fromARGB(255, 200, 6, 35),
                        const Color.fromARGB(255, 251, 101, 129)
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    // shape:
                    //     currentPage == 0 ? BoxShape.circle : BoxShape.rectangle,
                    borderRadius: currentPage == 1
                        ? const BorderRadius.all(Radius.circular(20))
                        : const BorderRadius.all(Radius.circular(100)),
                  ),
                  duration: const Duration(milliseconds: 300),
                  child: currentPage == 0
                      ? const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )
                      : Text(
                          translate(context).lbl_get_started,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                ),
              ),
            ),
          ),
          // IconButton(
          //     onPressed: () {
          //       Navigator.pushAndRemoveUntil(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => const HomeScreen(),
          //         ),
          //         (route) => false,
          //       );
          //     },
          //     icon: const Icon(
          //       Icons.home,
          //     )),
          SizedBox(
            height: mq.height * 0.01,
          ),
        ],
      ),
    );
  }
}
