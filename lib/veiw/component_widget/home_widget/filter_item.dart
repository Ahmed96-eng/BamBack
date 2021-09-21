// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:qattan/veiw/component_widget/icon_button_widget.dart';

// class FilterDialog extends StatelessWidget {
//   const FilterDialog({
//     required this.width,
//     required this.height,
//   });

//   final double width;
//   final double height;

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: AlignmentDirectional.topCenter,
//       child: AlertDialog(
//         backgroundColor: Colors.blue[300],
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                       decoration: InputDecoration(
//                     contentPadding: EdgeInsets.symmetric(
//                       horizontal: width * 0.03,
//                     ),
//                     fillColor: Colors.white,
//                     filled: true,
//                     hintText: "search_hint".tr,
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide.none,
//                       borderRadius: BorderRadius.circular(45),
//                     ),
//                   )),
//                 ),
//                 SizedBox(
//                   width: width * 0.02,
//                 ),
//                 IconButtonWidget(
//                   icon: Icons.search,
//                   radius: width * 0.05,
//                   size: width * 0.05,
//                   onpressed: () {},
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: height * 0.03,
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                       decoration: InputDecoration(
//                     contentPadding: EdgeInsets.symmetric(
//                       horizontal: width * 0.03,
//                     ),
//                     fillColor: Colors.white,
//                     filled: true,
//                     hintText: "search_hint".tr,
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide.none,
//                       borderRadius: BorderRadius.circular(45),
//                     ),
//                   )),
//                 ),
//                 SizedBox(
//                   width: width * 0.02,
//                 ),
//                 IconButtonWidget(
//                   icon: Icons.search,
//                   radius: width * 0.05,
//                   size: width * 0.05,
//                   onpressed: () {},
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
