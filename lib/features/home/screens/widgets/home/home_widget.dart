import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/utils.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skin_care/core/theme/apptheme.dart';
import 'package:skin_care/features/chats/model.dart/tips_models.dart';
import 'package:skin_care/features/home/controllers/home/home_bloc.dart';
import 'package:skin_care/features/setting/model/language_model.dart';

import '../../../../../main.dart';
import '../../../controllers/product/product_bloc.dart';
import '../../../model/product_category_model.dart';
import '../../../model/related_product_model.dart';

class HomeWidget extends StatelessWidget {
  HomeWidget({
    super.key,
    required this.RelatedProductCategoryList,
    required this.symptomslist,
    required this.tipsModel,
  });
  List<RelatedProductCategory> RelatedProductCategoryList = [];
  List<Symptoms> symptomslist = [];
  TipsModel tipsModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeRefreshLoadState) {
              if (state.tipsModel.items.isNotEmpty) {
                // title = state.tipsModel.items[0].title;
                // subTitle = state.tipsModel.items[0].subTitle;
                // log("====>>>  $title, $subTitle");
              }
            }
            return Stack(
              children: [
                Image.asset("assets/images/banner.png"),
                if (tipsModel.items.isNotEmpty)
                  Positioned(
                    top: 40,
                    left: 30,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tipsModel.items[0].title,
                          style:
                              AppTheme.heading1.copyWith(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          tipsModel.items[0].subTitle,
                          style:
                              AppTheme.bodyText2.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                translate(context).lbl_products,
                style: AppTheme.heading2,
              ),
              const
              // Icon(Icons.tune),
              Spacer(),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: RelatedProductCategoryList.map((e) => InkWell(
                    onTap: () {
                      context.read<ProductBloc>().add(
                            ProductLoadEvent(
                              relatedProductCategoryList:
                                  RelatedProductCategoryList,
                              selectedIndex:
                                  RelatedProductCategoryList.indexOf(e),
                              selectedskintypeindex: 0,
                            ),
                          );
                      // context.read<ProductBloc>().add(
                      //       ProductLoadEvent(
                      //         // RelatedProductCategoryList: RelatedProductCategoryList,
                      //         selectedIndex:
                      //             RelatedProductCategoryList.indexOf(e),
                      //       ),
                      //     );
                      Navigator.pushNamed(context, "/ProductScreen");
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(
                          color: Colors.red,
                        ),
                      ),
                      child: Text(
                        e.name,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                  )).toList(),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                translate(context).lbl_product_related_symptoms,
                style: AppTheme.heading2,
              ),
              // Icon(Icons.filter),
              const Spacer(),
            ],
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          primary: false,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemCount: symptomslist.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                context.read<ProductBloc>().add(
                      HomeToSymptomsEvent(
                        // relatedProductCategoryList:
                        //     RelatedProductCategoryList,
                        // selectedIndex:
                        //     RelatedProductCategoryList.indexOf(e),
                        // selectedskintypeindex: 0,
                        title: symptomslist[index].symptomName,
                        symptomId: symptomslist[index].id,
                      ),
                    );
                // context.read<ProductBloc>().add(
                //       ProductLoadEvent(
                //         // RelatedProductCategoryList: RelatedProductCategoryList,
                //         selectedIndex:
                //             RelatedProductCategoryList.indexOf(e),
                //       ),
                //     );
                Navigator.pushNamed(context, "/ProductSymptomScreen");
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Container(
                      height: mq.width * 0.2,
                      width: mq.width * 0.2,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          // height: mq.height * 0.14,
                          fit: BoxFit.cover,
                          imageUrl: symptomslist[index].symptomImage[0],
                          placeholder: (context, url) {
                            return Shimmer.fromColors(
                                baseColor:
                                    const Color.fromARGB(255, 223, 223, 223),
                                highlightColor:
                                    const Color.fromARGB(255, 255, 255, 255),
                                child: Container(
                                  height: mq.width * 0.2,
                                  width: mq.width * 0.2,
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    shape: BoxShape.circle,
                                  ),
                                ));
                          },
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      // Image.asset(symptomslist[index].symptomImage[0]),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      symptomslist[index].symptomName,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            );
          },
        )

        // Wrap(
        //   children: productList
        //       .map((e) => Container(
        //             margin: const EdgeInsets.symmetric(horizontal: 15),
        //             padding: const EdgeInsets.all(8),
        //             child: Column(
        //               children: [
        //                 Container(
        //                   height: mq.width * 0.2,
        //                   width: mq.width * 0.2,
        //                   decoration: const BoxDecoration(
        //                     color: Colors.grey,
        //                     shape: BoxShape.circle,
        //                   ),
        //                   child: Image.asset(e.image),
        //                 ),
        //                 const SizedBox(
        //                   height: 10,
        //                 ),
        //                 Text(
        //                   e.name,
        //                   style: const TextStyle(color: Colors.black),
        //                 ),
        //               ],
        //             ),
        //           ))
        //       .toList(),
        // ),
      ],
    );
  }
}
