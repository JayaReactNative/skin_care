import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skin_care/features/home/controllers/home/home_bloc.dart';

import '../../../../../main.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 200, // Set your image height
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Colors.white,
              ),
            ),
          ),
        ),
        // SizedBox(
        //   height: 20,
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: const Text(
                  "Products",
                  style: TextStyle(color: Colors.transparent),
                ),
              ),
              const Icon(Icons.filter, color: Colors.transparent),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                5, // Set the number of shimmering product category items
                (index) => Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(right: 12),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 100, // Set your product category item width
                      height: 40, // Set your product category item height
                      // color: Colors.white,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        // SizedBox(
        //   height: 20,
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: const Text(
                  "Product related to Symptoms",
                  style: TextStyle(color: Colors.transparent),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),

        GridView.builder(
          shrinkWrap: true,
          primary: false,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemCount: symptomslist.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: mq.width * 0.16,
                      width: mq.width * 0.16,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 80, // Set your product item name width
                      height: 20, // Set your product item name height
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        )

        // Wrap(
        //   alignment: WrapAlignment.center,
        //   children: List.generate(
        //     10, // Set the number of shimmering product items
        //     (index) => Container(
        //       padding: const EdgeInsets.all(8),
        //       margin: const EdgeInsets.symmetric(horizontal: 10),
        //       child: Column(
        //         children: [
        //           Shimmer.fromColors(
        //             baseColor: Colors.grey[300]!,
        //             highlightColor: Colors.grey[100]!,
        //             child: Container(
        //               height: mq.width * 0.16,
        //               width: mq.width * 0.16,
        //               decoration: const BoxDecoration(
        //                 shape: BoxShape.circle,
        //                 color: Colors.white,
        //               ),
        //             ),
        //           ),
        //           const SizedBox(
        //             height: 10,
        //           ),
        //           Shimmer.fromColors(
        //             baseColor: Colors.grey[300]!,
        //             highlightColor: Colors.grey[100]!,
        //             child: Container(
        //               width: 80, // Set your product item name width
        //               height: 20, // Set your product item name height
        //               decoration: const BoxDecoration(
        //                 color: Colors.white,
        //                 borderRadius: BorderRadius.all(
        //                   Radius.circular(10),
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
