import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:shimmer/shimmer.dart';

import 'package:flutter/services.dart';
import 'package:skin_care/features/home/model/favourite_list_model.dart';
import 'package:skin_care/features/home/screens/product_detail_screen.dart';

import '../../../../../core/theme/apptheme.dart';
import '../../../../../dependency_injection.dart';
import '../../../../../main.dart';
import '../../../controllers/product/product_bloc.dart';
import '../../../model/all_products.dart';

class ProductItemWidget extends StatelessWidget {
  ProductItemWidget({super.key});
  List<AllProductsItem> productList = [];
  List<FavouriteData> favouritedata = [];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    // ProductFetchFav
    final productBloc = BlocProvider.of<ProductBloc>(context);
    productBloc.add(ProductFetchFav());
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoadedState) {
          // log(state.selectedIndex.toString());
          // log(state.productist.map((e) => e.toJson()).toList().toString());

          productList = state.productist.where((element) {
            return state.relatedProductCategoryList[state.selectedIndex].id ==
                    element.categoryId &&
                state.skintype[state.skintypeindex].id == element.skinTypeId;
          }).toList();
        }
        if (state is FavouriteListState) {
          favouritedata = state.favouritelist;

          // log("done transferring  ${favouritedata.map((e) => " ${e.productId} ")}");
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
          child: productList.isEmpty
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "No item found!",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    // Text(
                    //   "Please add items to wishlist",
                    //   style: AppTheme.captionText.copyWith(fontSize: 15),
                    // ),
                  ],
                ))
              : GridView.builder(
                  primary: false,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    mainAxisExtent: mq.width * 0.52,
                  ),
                  itemCount: productList.length,
                  itemBuilder: (BuildContext context, int index) {
                    // bool isSelected = index == selectedIndex;
                    final product = productList[index];
                    // bool isfavourite=
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return ProductDetailsScreen(
                              product: product,
                            );
                          },
                        ));
                      },
                      child: Stack(
                        children: [
                          Container(
                            height: mq.width * 0.5,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 0.2,
                                  color: Colors.grey.shade200,
                                  blurRadius: 0.6,
                                  offset: Offset(2, 3),
                                ),
                              ],
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Hero(
                                    tag: product.id,
                                    child: CachedNetworkImage(
                                      height: mq.height * 0.14,
                                      fit: BoxFit.fitWidth,
                                      imageUrl: product.productImage.isNotEmpty
                                          ? product.productImage[0]
                                          : "https://t.infibeam.com/img/no_image.jpg.999x350x350.jpg",
                                      placeholder: (context, url) {
                                        return Shimmer.fromColors(
                                            baseColor: Color.fromARGB(
                                                255, 223, 223, 223),
                                            highlightColor:
                                                const Color.fromARGB(
                                                    255, 255, 255, 255),
                                            child: Container(
                                              color: const Color.fromARGB(
                                                  255, 58, 58, 58),
                                              height: mq.height * 0.12,
                                              width: double.infinity,
                                            ));
                                      },
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                  // Image.asset(
                                  //   product.,
                                  //   fit: BoxFit.contain,
                                  // ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  product.productName ?? "foo",
                                  maxLines: 1,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    maxLines: 1,
                                    product.description ?? "foo",
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: -7,
                            right: -7,
                            child: IconButton(
                              icon: Icon(
                                favouritedata.any((element) =>
                                        element.productId == product.id)

                                    // favouritedata.where((element) {
                                    //           return element.productId == product.id;
                                    //         }) ==
                                    //         true
                                    // favouritedata.contains(product.id)
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                // print(product.id);
                                context.read<ProductBloc>().add(
                                      Favourite(
                                          userid: storage.read('userid'),
                                          productid: product.id),
                                    );
                                // context.read<ProductBloc>().add(Getfavouritelist());
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
