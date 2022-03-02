// import 'package:flutter/material.dart';
// import 'package:qattan/constant.dart';
// import 'package:qattan/features/responsive_setup/responsive_builder.dart';
// import 'package:qattan/veiw/component_widget/common_button.dart';
// import 'package:qattan/veiw/component_widget/navigator.dart';
// import 'package:qattan/veiw/component_widget/text_form_field_widget.dart';
// import 'package:qattan/veiw/screens/auth/enter_phone.dart';

// class EnterEmail extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ResponsiveBuilder(builder: (context, sizeConfig) {
//       final height = sizeConfig.screenHeight!;
//       final width = sizeConfig.screenWidth!;
//       return Scaffold(
//         body: Container(
//           width: width,
//           height: height,
//           child: ListView(
//             children: [
//               Container(
//                 height: height * 0.32,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: mainColor,
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(35),
//                     bottomRight: Radius.circular(35),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // SizedBox(
//                       //   height: height * 0.02,
//                       // ),
//                       InkWell(
//                         child: Image.asset(
//                           'asset/images/Back_Button.png',
//                           fit: BoxFit.fill,
//                           height: height * 0.06,
//                           width: width * 0.12,
//                         ),
//                         onTap: () {
//                           back(context);
//                         },
//                       ),
//                       Spacer(),
//                       Text("Enter ypur email"),
//                       SizedBox(
//                         height: height * 0.01,
//                       ),
//                       Text(
//                         "Lorem ipsum dolor sit amet, consectetur adipiscing elit.Integer maximus accumsan erat id facilisis.",
//                       ),
//                       SizedBox(
//                         height: height * 0.02,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Container(
//                   height: height * 0.48,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     // crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       TextFormFieldWidget(
//                         hint: 'Your Email',
//                       ),
//                       SizedBox(
//                         height: height * 0.03,
//                       ),
//                       Text("Code was send your email"),
//                       Text("Kylie_04@gmail.com"),
//                       SizedBox(
//                         height: height * 0.04,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text("This code will expire on"),
//                           SizedBox(
//                             width: width * 0.01,
//                           ),
//                           Text("5 minutes"),
//                         ],
//                       ),
//                       Align(
//                         alignment: AlignmentDirectional.bottomCenter,
//                         child: CommonButton(
//                           text: 'SAVE EMAIL ADDRESS',
//                           width: width * 0.85,
//                           containerColor: buttonColor,
//                           textColor: buttonTextColor,
//                           onTap: () {
//                             goTo(context, EnterPhone());
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Align(
//                 alignment: AlignmentDirectional.bottomCenter,
//                 child: CommonButton(
//                   text: 'RESEND LINK',
//                   width: width * 0.85,
//                   containerColor: secondColor,
//                   textColor: buttonTextColor,
//                   onTap: () {},
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }
