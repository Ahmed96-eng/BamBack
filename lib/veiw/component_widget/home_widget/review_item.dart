// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:qattan/model/review_model.dart';
// import 'package:qattan/veiw/component_widget/icon_button_widget.dart';

// class ReviewWidget extends StatelessWidget {
//   const ReviewWidget({
//     required this.height,
//     required this.width,
//     this.reviewController,
//     this.onpressed,
//     this.reviewData,
//   });

//   final double height;
//   final double width;
//   final TextEditingController? reviewController;
//   final VoidCallback? onpressed;
//   final ReviewData? reviewData;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: height * 0.8,
//       width: width,
//       color: Colors.grey[300],
//       padding: EdgeInsets.all(width * 0.04),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Flexible(
//                 // flex: 1,
//                 child: TextField(
//                     controller: reviewController,
//                     decoration: InputDecoration(
//                       contentPadding:
//                           EdgeInsets.symmetric(horizontal: 12, vertical: 3),
//                       fillColor: Colors.white,
//                       filled: true,
//                       hintText: "review_hint".tr,
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide.none,
//                         borderRadius: BorderRadius.circular(45),
//                       ),
//                     )),
//               ),
//               SizedBox(
//                 width: width * 0.02,
//               ),
//               Padding(
//                 padding: EdgeInsets.all(width * 0.025),
//                 child: IconButtonWidget(
//                   icon: Icons.send_rounded,
//                   radius: width * 0.05,
//                   size: width * 0.05,
//                   onpressed: onpressed,
//                 ),
//               ),
//               SizedBox(
//                 width: width * 0.02,
//               ),
//             ],
//           ),
//           SizedBox(
//             height: height * 0.02,
//           ),
//           Flexible(
//             // flex: 1,
//             child:
//                 //  ListView.builder(
//                 //   itemCount: 5,
//                 //   itemBuilder: (context, index) =>
//                 ListTile(
//               leading: CircleAvatar(),
//               title: Text("العميل"),
//               subtitle: Text("تعليق"),
//             ),
//           ),
//           // ),
//         ],
//       ),
//     );
//   }
// }
