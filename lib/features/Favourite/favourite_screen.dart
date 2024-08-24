import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skin_care/features/home/controllers/product/product_bloc.dart';
import 'package:skin_care/features/home/model/favourite_list_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:skin_care/features/home/screens/product_detail_screen.dart';
import 'package:skin_care/features/setting/model/language_model.dart';

import '../../core/theme/apptheme.dart';
import '../../main.dart';
import '../home/model/product_model.dart';

class FavouriteScreen extends StatelessWidget {
  FavouriteScreen({super.key});
  List<FavouriteData> productList = [];

  @override
  Widget build(BuildContext context) {
    final productBloc = BlocProvider.of<ProductBloc>(context);
    productBloc.add(ProductFetchFav());

    // List<ProductModel> productList = [];
    // for (int i = 1; i <= 6; i++) {
    //   productList.add(
    //     ProductModel(
    //       title: "Title $i",
    //       image: "assets/images/item$i.png",
    //       desc: "Description for item $i",
    //       id: "id_$i",
    //       category: "Category $i",
    //       skinType: "Skin Type $i",
    //     ),
    //   );
    // }
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is FavouriteListState) {
          productList = state.favouritelist;
        }

        return Scaffold(
          appBar: AppBar(
            // leading:
            automaticallyImplyLeading: false,
            title: Text(translate(context).lbl_f_appbar_title,
                style: AppTheme.headings.copyWith(fontWeight: FontWeight.w500)),
          ),
          body: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            child: productList.isEmpty
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Empty List!",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Please add items to wishlist",
                        style: AppTheme.captionText.copyWith(fontSize: 15),
                      ),
                    ],
                  ))
                : GridView.builder(
                    // primary: false,
                    // shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                      mainAxisExtent: mq.width * 0.55,
                    ),
                    itemCount: productList.length,
                    // productList.length,
                    itemBuilder: (BuildContext context, int index) {
                      // bool isSelected = index == selectedIndex;
                      final product = productList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ProductDetailsScreen(
                                favourite: product,
                                isfavourite: true,
                              );
                            },
                          ));
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: mq.width * 0.9,
                              padding: const EdgeInsets.all(8),
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
                                    offset: const Offset(2, 3),
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
                                        imageUrl: product.productDetail[0]
                                                .productImage.isNotEmpty
                                            ? product.productDetail[0]
                                                .productImage[0]
                                            : "https://t.infibeam.com/img/no_image.jpg.999x350x350.jpg",
                                        placeholder: (context, url) {
                                          return Shimmer.fromColors(
                                              baseColor: const Color.fromARGB(
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
                                  // Align(
                                  //   alignment: Alignment.center,
                                  //   child: Image.asset(
                                  //     product.image!,
                                  //     fit: BoxFit.contain,
                                  //   ),
                                  // ),
                                  const SizedBox(height: 8),
                                  Text(
                                    product.productDetail[0].productName ??
                                        "foo",
                                    maxLines: 1,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    product.productDetail[0].description ??
                                        "foo",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  context.read<ProductBloc>().add(Favourite(
                                      userid: product.userId,
                                      productid: product.productId));
                                  // context.read<ProductBloc>().add(Getfavouritelist());
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}





/*

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skin_care/features/home/controllers/product/product_bloc.dart';

import '../../core/theme/apptheme.dart';
import '../../main.dart';
import '../home/model/product_model.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List<ProductModel> productList = [];
    // for (int i = 1; i <= 6; i++) {
    //   productList.add(
    //     ProductModel(
    //       title: "Title $i",
    //       image: "assets/images/item$i.png",
    //       desc: "Description for item $i",
    //       id: "id_$i",
    //       category: "Category $i",
    //       skinType: "Skin Type $i",
    //     ),
    //   );
    // }

    final homeBloc = BlocProvider.of<ProductBloc>(context);
    return Scaffold(
      appBar: AppBar(
        // leading:
        automaticallyImplyLeading: false,
        title: Text("Favourite",
            style: AppTheme.headings
                .copyWith(fontSize: 21, fontWeight: FontWeight.w500)),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            child: GridView.builder(
              // primary: false,
              // shrinkWrap: true,
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                mainAxisExtent: mq.width * 0.47,
              ),
              itemCount: homeBloc.favouritedata.length,
              itemBuilder: (BuildContext context, int index) {
                // bool isSelected = index == selectedIndex;
                final product = homeBloc.favouritedata[index];
                return GestureDetector(
                  onTap: () {},
                  child: Stack(
                    children: [
                      Container(
                        height: mq.width * 0.9,
                        padding: const EdgeInsets.all(8),
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
                              child: CachedNetworkImage(
                                height: mq.height * 0.14,
                                fit: BoxFit.fitWidth,
                                imageUrl: product.productDetail[0].productImage[
                                    0], //  product.productImage[0],
                                placeholder: (context, url) {
                                  return Shimmer.fromColors(
                                      baseColor:
                                          Color.fromARGB(255, 223, 223, 223),
                                      highlightColor: const Color.fromARGB(
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
                            const SizedBox(height: 8),
                            Text(
                              product.productDetail[0].productName ?? "foo",
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              product.productDetail[0].description ?? "foo",
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          icon: Icon(
                            Icons.favorite_outline,
                            color: Colors.red,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}


*/