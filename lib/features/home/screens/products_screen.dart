import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skin_care/core/theme/apptheme.dart';
import 'package:skin_care/features/home/controllers/product/product_bloc.dart';
import 'package:skin_care/features/home/screens/widgets/product/product_item_shimmer.dart';
import 'package:skin_care/features/setting/model/language_model.dart';
import '../../../shared/widgets/entry_out_transition_widget.dart';
import '../model/product_category_model.dart';
import '../model/related_product_model.dart';
import 'widgets/home/home_shimmer.dart';
import 'widgets/product/product_cat_shimmer.dart';
import 'widgets/product/product_cat_widget.dart';
import 'widgets/product/product_item_widget.dart';

class ProductScreen extends StatefulWidget {
  static const id = '/ProductScreen';
  ProductScreen({
    super.key,
    this.enableEntryAnimation = true,
  });
  final bool enableEntryAnimation;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
    with TickerProviderStateMixin {
  // List<RelatedProductCategory> RelatedProductCategoryList = [];
  // List<Product> productList = [];

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

  Widget item1 = RelatedProductCatWidget();
  Widget item2 = ProductItemWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate(context).lbl_screen_appbar_title),
        // actions: const [
        //   Icon(Icons.tune),
        //   SizedBox(
        //     width: 20,
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 8,
        ),
        child: SafeArea(
          child: ListView(
            primary: true,
            shrinkWrap: false,
            children: [
              EntryOutTransition(
                entryAnimation: entryAnimations[1],
                // outAnimation: outAnimationController,
                entryBeginOffset: const Offset(0, .5),
                outBeginOffset: const Offset(0, .5),
                child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    Widget child = item1;
                    if (state.status == ProductStatus.loading) {
                      return const RelatedProductCatShimmer();
                    }
                    return child;
                  },
                ),
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
                  child: BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      Widget child = item2;
                      if (state.status == ProductStatus.loading) {
                        return const ProductItemShimmer();
                      }
                      return child;
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
