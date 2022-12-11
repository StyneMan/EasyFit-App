// import 'package:dwec_app/helper/constants/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';


// class CartShimmer extends StatelessWidget {
//   const CartShimmer({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: MediaQuery.of(context).size.height * 0.18,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               color: Constants.accentColor,
//               borderRadius: BorderRadius.all(Radius.circular(8.0),),
//             ),
//             child: Center(
//               child: Shimmer.fromColors(
//                 baseColor: Constants.shimmerBaseColor,
//                 highlightColor: Constants.shimmerHighlightColor,
//                 child: SizedBox(height: MediaQuery.of(context).size.height * 0.15,),
//               ),
//             )
//           ),
//           const SizedBox(width: 16.0,),
//           Expanded(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                           child: Shimmer.fromColors(
//                             baseColor: Constants.shimmerBaseColor,
//                             highlightColor: Constants.shimmerHighlightColor,
//                             child: Container(
//                               width: 100,
//                               height: 16,
//                               color: Colors.grey[300],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 4.0,
//                         ),
//                         ClipRRect(
//                           borderRadius: const BorderRadius.all(Radius.circular(10)),
//                           child: Shimmer.fromColors(
//                             baseColor: Constants.shimmerBaseColor,
//                             highlightColor: Constants.shimmerHighlightColor,
//                             child: Container(
//                               width: 128,
//                               height: 10,
//                               color: Colors.grey[300]
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 4.0,
//                     ),
//                     ClipRRect(
//                       borderRadius: const BorderRadius.all(Radius.circular(10)),
//                       child: Shimmer.fromColors(
//                         baseColor: Constants.shimmerBaseColor,
//                         highlightColor: Constants.shimmerHighlightColor,
//                         child: Container(
//                           width: 120,
//                           height: 10,
//                           color: Colors.grey[300]
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     ClipRRect(
//                       borderRadius: const BorderRadius.all(Radius.circular(10)),
//                       child: Shimmer.fromColors(
//                         baseColor: Constants.shimmerBaseColor,
//                         highlightColor: Constants.shimmerHighlightColor,
//                         child: Container(
//                           width: 15,
//                           height: 22,
//                           color: Colors.grey[300]
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 4.0,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         ClipRRect(
//                           borderRadius: const BorderRadius.all(Radius.circular(10)),
//                           child: Shimmer.fromColors(
//                             baseColor: Constants.shimmerBaseColor,
//                             highlightColor: Constants.shimmerHighlightColor,
//                             child: Container(
//                               width: 25,
//                               height: 15,
//                               color: Colors.grey[300]
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(6.0),
//                           child: ClipRRect(
//                             borderRadius: const BorderRadius.all(Radius.circular(10)),
//                             child: Shimmer.fromColors(
//                               baseColor: Constants.shimmerBaseColor,
//                               highlightColor: Constants.shimmerHighlightColor,
//                               child: Container(
//                                 width: 10,
//                                 height: 10,
//                                 color: Colors.grey[300]
//                               ),
//                             ),
//                           ),
//                         ),
//                         ClipRRect(
//                           borderRadius: const BorderRadius.all(Radius.circular(10)),
//                           child: Shimmer.fromColors(
//                             baseColor: Constants.shimmerBaseColor,
//                             highlightColor: Constants.shimmerHighlightColor,
//                             child: Container(
//                               width: 25,
//                               height: 15,
//                               color: Colors.grey[300]
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ]
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }