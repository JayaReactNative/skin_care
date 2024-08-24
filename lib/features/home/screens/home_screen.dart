import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skin_care/core/theme/apptheme.dart';
import 'package:skin_care/dependency_injection.dart';
import 'package:skin_care/features/Profile/controller/profile_bloc.dart';
import 'package:skin_care/features/Profile/controller/profile_state.dart';
import 'package:skin_care/features/home/controllers/home/home_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skin_care/features/setting/model/language_model.dart';
import 'package:skin_care/features/setting/screens/settings.dart';
import '../../../shared/widgets/entry_out_transition_widget.dart';
import '../model/product_category_model.dart';
import '../model/related_product_model.dart';
import 'widgets/home/home_shimmer.dart';
import 'widgets/home/home_widget.dart';

class HomeScreen extends StatefulWidget {
  static const id = '/HomeScreen';
  const HomeScreen({
    super.key,
    this.enableEntryAnimation = true,
  });
  final bool enableEntryAnimation;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  List<RelatedProductCategory> RelatedProductCategoryList = [];
  List<Symptoms> productList = [];
  String? name;

  late final AnimationController entryAnimationController;
  List<Animation<double>> entryAnimations =
      List.filled(8, const AlwaysStoppedAnimation(1));

  @override
  void initState() {
    entryAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
      value: 0,
    );
    if (widget.enableEntryAnimation) {
      entryAnimations = List.generate(
        8,
        (index) => CurvedAnimation(
          parent: entryAnimationController,
          curve: Interval(0, .2 * (index + 1), curve: Curves.fastOutSlowIn),
        ),
      );
      Future.delayed(
        const Duration(milliseconds: 400),
        () => entryAnimationController.forward(),
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    entryAnimationController.dispose();
    super.dispose();
  }

  Widget item1(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfilLoadedState) {
          name = state.userdata[0].firstName + " " + state.userdata[0].lastName;
        }
        if (state is ProfileUpdatedState) {
          name = state.authDetail!.items.firstName +
              " " +
              state.authDetail!.items.firstName;
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Welcome ${name ?? ''}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: AppTheme.headings,
                    ),
                  ),
                  Builder(builder: (context) {
                    return IconButton(
                        onPressed: () {
                          // print(storage.read('token'));
                          Navigator.pushNamed(context, Settings.id);
                        },
                        icon: Icon(Icons.menu));
                  }),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              // TextField(
              //   style: const TextStyle(color: Colors.black), // Text color
              //   decoration: InputDecoration(
              //     hintText: 'What are you looking for ?',
              //     hintStyle: const TextStyle(color: Colors.grey), // Hint text color
              //     prefixIcon: const Icon(Icons.search,
              //         color: Colors.grey), // Search icon color
              //     filled: true, // Add background color
              //     fillColor: Colors.grey[200], // Background color
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8.0), // Border radius
              //       borderSide: BorderSide.none, // Remove border
              //     ),
              //     contentPadding: const EdgeInsets.symmetric(
              //         vertical: 12.0, horizontal: 16.0), // Padding
              //   ),
              // ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget item2 = const HomeShimmer();

  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(HomeInitEvent());
    return Scaffold(
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeRefreshLoadState) {
            RelatedProductCategoryList = state.ProductCategories;
            // print(">>>>>>>>>><<<<<<<<<<<<");
            // log(RelatedProductCategoryList[0].name.toString());
            productList = state.product;
            // // Accessing the category names and ids
            // for (RelatedProductCategory category in RelatedProductCategoryList) {
            //   print('Name: ${category.name}, ID: ${category.id}');
            // }
            item2 = HomeWidget(
              RelatedProductCategoryList: RelatedProductCategoryList,
              symptomslist: productList,
              tipsModel: tipsModel,
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 8,
            ),
            child: SafeArea(
              child: ListView(
                shrinkWrap: false,
                primary: true,
                children: [
                  EntryOutTransition(
                    entryAnimation: entryAnimations[1],
                    // outAnimation: outAnimationController,
                    entryBeginOffset: const Offset(0, .5),
                    outBeginOffset: const Offset(0, .5),
                    child: item1(context),
                  ),
                  EntryOutTransition(
                    entryAnimation: entryAnimations[4],
                    // outAnimation: outAnimationController,
                    entryBeginOffset: const Offset(0, .5),
                    outBeginOffset: const Offset(0, .5),
                    child: AnimatedSwitcher(
                      duration: const Duration(
                        milliseconds: 300,
                      ),
                      child: item2,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
