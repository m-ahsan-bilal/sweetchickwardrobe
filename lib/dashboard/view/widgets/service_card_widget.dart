// import 'dart:ui';

// import 'package:flutter/material.dart';

// import 'package:sweetchickwardrobe/dashboard/model/service_card_model.dart';

// class ServiceCardWidget extends StatefulWidget {
//   const ServiceCardWidget({super.key});

//   @override
//   State<ServiceCardWidget> createState() => _ServiceCardWidgetState();
// }

// class _ServiceCardWidgetState extends State<ServiceCardWidget> {
//   // List<ServiceCard> serviceCards = [];

//   // List<ServiceCard> serviceCards = [
//   //   ServiceCard(
//   //     icon: Icons.local_shipping,
//   //     title: "Free Shipping",
//   //     description: "When you spend \$50+",
//   //     color: Color.fromARGB(255, 184, 119, 141),
//   //     onTap: () {
//   //       debugPrint('shipping container tapped');
//   //     },
//   //   ),
//   //   ServiceCard(
//   //     icon: Icons.call,
//   //     title: "Call Us Anytime",
//   //     description: "+34 555 5555",
//   //     color: Color(0xffFCE1BB),
//   //     onTap: () {
//   //       debugPrint('call container tapped');
//   //     },
//   //   ),
//   //   ServiceCard(
//   //     icon: Icons.chat,
//   //     title: "Chat With Us",
//   //     description: "24-hour chat support",
//   //     color: Colors.green.shade100,
//   //     onTap: () {
//   //       debugPrint('chat container tapped');
//   //     },
//   //   ),
//   //   ServiceCard(
//   //     icon: Icons.card_giftcard,
//   //     title: "Gift Cards",
//   //     description: "For your loved one",
//   //     color: Colors.yellow.shade100,
//   //     onTap: () {
//   //       debugPrint('gift container tapped');
//   //     },
//   //   ),
//   // ];
//   List<ServiceCard> serviceCards = [
//     ServiceCard(
//       icon: Icons.local_shipping,
//       title: "Free Shipping",
//       description: "When you spend \$50+",
//       color: Color.fromARGB(255, 184, 119, 141),
//       onTap: () {
//         debugPrint('shipping container tapped');
//       },
//     ),
//     ServiceCard(
//       icon: Icons.call,
//       title: "Call Us Anytime",
//       description: "+34 555 5555",
//       color: Color(0xffFCE1BB),
//       onTap: () {
//         debugPrint('call container tapped');
//       },
//     ),
//     ServiceCard(
//       icon: Icons.chat,
//       title: "Chat With Us",
//       description: "24-hour chat support",
//       color: Colors.green.shade100,
//       onTap: () {
//         debugPrint('chat container tapped');
//       },
//     ),
//     ServiceCard(
//       icon: Icons.card_giftcard,
//       title: "Gift Cards",
//       description: "For your loved one",
//       color: Colors.yellow.shade100,
//       onTap: () {
//         debugPrint('gift container tapped');
//       },
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);
//     final width = mediaQuery.size.width;
//     final height = mediaQuery.size.height;

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: serviceCards.map((card) {
//         return InkWell(
//           onTap: card.onTap,
//           child: Container(
//             width: width * 0.14,
//             height: height * 0.1,
//             padding: EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12.0),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 2,
//                   blurRadius: 5,
//                   offset: Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: Center(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Container(
//                     padding: EdgeInsets.all(5),
//                     decoration: BoxDecoration(
//                       color: card.color,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Icon(card.icon, size: width * 0.02),
//                   ),
//                   // SizedBox(width: width * 0.0001),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         card.title,
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: width * 0.009,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(height: height * 0.003),
//                       Text(
//                         card.description,
//                         style: TextStyle(
//                           color: Colors.black54,
//                           fontSize: width * 0.007,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }
// }
