import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/utils.dart';
import 'package:skin_care/core/theme/apptheme.dart';
import 'package:flutter/services.dart';
import 'package:skin_care/features/home/model/product_model.dart';
import 'package:skin_care/features/home/model/skin_type_model.dart';

import '../../../../../main.dart';
import '../../../controllers/product/product_bloc.dart';
import '../../../model/product_category_model.dart';
import '../../../model/related_product_model.dart';

class RelatedProductCatWidget extends StatelessWidget {
  RelatedProductCatWidget({super.key});
  List<RelatedProductCategory> relatedProductCategoryList = [];
  List<SkinTypeItem> skinType = [];
  int selectedIndex = 0;
  int selectedskintypeindex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        relatedProductCategoryList = state.relatedProductCategoryList;
        if (state is ProductIndexChangedState || state is ProductLoadedState) {
          selectedIndex = state.selectedIndex;
          selectedskintypeindex = state.skintypeindex;
        }
        if (state is ProductLoadedState) {
          selectedIndex = state.selectedIndex;
          skinType = state.skintype;
          selectedskintypeindex = state.skintypeindex;
        }
        // if (state is )

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: relatedProductCategoryList.map((e) {
                      bool isSelected = relatedProductCategoryList.indexOf(e) ==
                          selectedIndex;
                      return GestureDetector(
                        onTap: () {
                          context.read<ProductBloc>().add(
                                ProductLoadEvent(
                                  relatedProductCategoryList:
                                      relatedProductCategoryList,
                                  selectedIndex:
                                      relatedProductCategoryList.indexOf(e),
                                  selectedskintypeindex: state.skintypeindex,
                                ),
                              );
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
                              color: isSelected ? Colors.red : Colors.white),
                          child: Text(
                            e.name,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.red,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Sort by Skin type",
                  style: AppTheme.heading2,
                  // textAlign: TextAlign.left,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: skinType.map((e) {
                      bool isSelected =
                          skinType.indexOf(e) == selectedskintypeindex;
                      return e.name.trim().isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                log("tapped on skin type ${skinType.indexOf(e)}");
                                print(selectedskintypeindex);
                                // context.read<ProductBloc>().add(
                                //       Productskintype(
                                //         Skintype: skinType,
                                //         selectedskintypeindex: skinType.indexOf(e),
                                //       ),
                                //     );
                                context.read<ProductBloc>().add(
                                      ProductLoadEvent(
                                        relatedProductCategoryList:
                                            relatedProductCategoryList,
                                        selectedIndex: state.selectedIndex,
                                        selectedskintypeindex:
                                            skinType.indexOf(e),
                                      ),
                                    );
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
                                    color:
                                        isSelected ? Colors.red : Colors.white),
                                child: Text(
                                  e.name ?? "demo",
                                  style: TextStyle(
                                    color:
                                        isSelected ? Colors.white : Colors.red,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox();
                    }).toList(),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        );
      },
    );
  }
}
