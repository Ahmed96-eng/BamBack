// import 'package:flutter/material.dart';

// class TopItem extends StatelessWidget {
//   const TopItem({
//     required this.height,
//     required this.width,
//     this.onTap,
//     this.image,
//     this.title,
//     this.icon,
//     this.iconSelect = false,
//   });

//   final double height;
//   final double width;
//   final GestureTapCallback? onTap;
//   final String? image;
//   final String? title;
//   final IconData? icon;
//   final bool? iconSelect;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         height: height,
//         width: width * 0.26,
//         // margin: EdgeInsets.all(5),
//         // decoration: BoxDecoration(border: Border.all()),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               // padding: EdgeInsets.all(8),
//               // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
//               child: iconSelect!
//                   ? Icon(
//                       icon,
//                       size: height * 0.63,
//                       color: Colors.white70,
//                     )
//                   : Image.asset(
//                       image!,
//                       fit: BoxFit.fill,
//                       color: Colors.white,
//                       height: height * 0.6,
//                       width: width * 0.1,
//                     ),
//             ),
//             // SizedBox(
//             //   // height: height * 0.01,
//             // ),
//             Text(
//               title!,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
