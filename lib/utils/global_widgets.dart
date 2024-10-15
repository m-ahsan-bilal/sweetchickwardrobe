// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:math';
import 'dart:html' as html;
import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sizer/sizer.dart';
import 'package:sweetchickwardrobe/dashboard/vm/base_vm.dart';
import 'package:sweetchickwardrobe/dashboard/vm/common_vm.dart';
import 'package:sweetchickwardrobe/utils/category_row.dart';
import 'package:sweetchickwardrobe/utils/gradient_wrapper.dart';
import 'package:sweetchickwardrobe/utils/hive.dart';
import 'package:sweetchickwardrobe/utils/responsive_widget.dart';
import 'package:sweetchickwardrobe/utils/sized_boxes.dart';

import '../resources/resources.dart';

class GlobalWidgets {
  static Widget buildFooterWidget(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;
    return GradientWrapper(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                  context
                          .watch<BaseVm>()
                          .appData
                          ?.serviceCardsWidget
                          ?.cards
                          ?.length ??
                      0, (index) {
                final card = context
                    .read<BaseVm>()
                    .appData
                    ?.serviceCardsWidget
                    ?.cards?[index];
                return InkWell(
                  onTap: () {},
                  child: Container(
                    width: width * 0.14,
                    height: height * 0.1,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: R.colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.network(
                              card?.icon ?? "",
                              height: width * 0.02,
                              width: width * 0.02,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 25,
                                  width: 25,
                                  child: Icon(Icons.error),
                                );
                              },
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                card?.title ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: width * 0.009,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: height * 0.003),
                              Text(
                                card?.description ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: width * 0.007,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 40),

            // Categories Row

            // CategoryRow(),

            const SizedBox(height: 40),

            // Contact Us, Privacy Policy, etc.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        context.go("/contact_us");
                      },
                      child: const Text("Contact Us"),
                    ),
                    InkWell(
                      onTap: () {
                        context.go("/terms_and_conditions");
                      },
                      child: const Text("Terms & Conditions"),
                    ),
                    InkWell(
                      onTap: () {
                        context.go("/privacy_policy");
                      },
                      child: const Text("Privacy Policy"),
                    ),
                  ],
                ),
                CategoryColumn(),
                Row(
                  children: List.generate(
                      context.watch<BaseVm>().appData?.socialLinks?.length ?? 0,
                      (index) {
                    final link =
                        context.watch<BaseVm>().appData?.socialLinks?[index];
                    return IconButton(
                      color: R.colors.transparent,
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(R.colors.transparent)),
                      icon: Row(
                        children: [
                          Image.network(
                            link?.imageUrl ?? "",
                            fit: BoxFit.cover,
                            height: 25,
                            width: 25,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 25,
                                width: 25,
                                child: Icon(Icons.error),
                              );
                            },
                          ),
                        ],
                      ),
                      onPressed: () {
                        html.window.open(link?.url ?? "", 'new tab');
                      },
                    );
                  }),
                )
              ],
            ),

            const SizedBox(height: 10),
            const Text("© 2024 SweetChickWardrobe. All Rights Reserved."),
          ],
        ),
      ),
    );
  }

  // static Widget buildFooter(BuildContext context) {
  //   final mediaQuery = MediaQuery.of(context);
  //   final width = mediaQuery.size.width;
  //   final height = mediaQuery.size.height;
  //   return Container(
  //     padding: const EdgeInsets.all(16),
  //     color: Colors.grey[200],
  //     child: Column(children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: serviceCards.map((card) {
  //           return InkWell(
  //             onTap: card.onTap,
  //             child: Container(
  //               width: width * 0.14,
  //               height: height * 0.1,
  //               padding: EdgeInsets.all(10),
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.circular(12.0),
  //                 boxShadow: [
  //                   BoxShadow(
  //                     color: Colors.grey.withOpacity(0.5),
  //                     spreadRadius: 2,
  //                     blurRadius: 5,
  //                     offset: Offset(0, 3),
  //                   ),
  //                 ],
  //               ),
  //               child: Center(
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                   children: [
  //                     Container(
  //                       padding: EdgeInsets.all(5),
  //                       decoration: BoxDecoration(
  //                         color: card.color,
  //                         borderRadius: BorderRadius.circular(10),
  //                       ),
  //                       child: Icon(card.icon, size: width * 0.02),
  //                     ),
  //                     // SizedBox(width: width * 0.0001),
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Text(
  //                           card.title,
  //                           style: TextStyle(
  //                             color: Colors.black,
  //                             fontSize: width * 0.009,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                           textAlign: TextAlign.center,
  //                         ),
  //                         SizedBox(height: height * 0.003),
  //                         Text(
  //                           card.description,
  //                           style: TextStyle(
  //                             color: Colors.black54,
  //                             fontSize: width * 0.007,
  //                           ),
  //                           textAlign: TextAlign.center,
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           );
  //         }).toList(),
  //       ),
  //       // ServiceCardWidget(),
  //       SizedBox(
  //         height: 40,
  //       ),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               InkWell(
  //                 onTap: () {
  //                   context.go("/contact_us");
  //                 },
  //                 child: const Text("Contact Us"),
  //               ),
  //               InkWell(
  //                 onTap: () {
  //                   context.go("/terms_and_conditions");
  //                 },
  //                 child: const Text("Terms & Conditions"),
  //               ),
  //               InkWell(
  //                 onTap: () {
  //                   context.go("/privacy_policy");
  //                 },
  //                 child: const Text("Privacy Policy"),
  //               ),
  //             ],
  //           ),
  //           Row(
  //             children: [
  //               IconButton(
  //                 icon: const Icon(Icons.facebook),
  //                 onPressed: () {
  //                   // Open Facebook page
  //                 },
  //               ),
  //               IconButton(
  //                 icon: const Icon(Icons.facebook),
  //                 onPressed: () {
  //                   // Open Twitter page
  //                 },
  //               ),
  //               IconButton(
  //                 icon: const Icon(Icons.facebook),
  //                 onPressed: () {
  //                   // Open Instagram page
  //                 },
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //       // const SizedBox(height: 10),
  //       // const Text("© 2024 SweetChickWardrobe. All Rights Reserved."),
  //     ]),
  //   );
  // }

  static Widget buildHeader(BuildContext context) {
    return GradientWrapper(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo (Clickable to return to Home)
                InkWell(
                  onTap: () async {
                    context.go("/dashboard");
                  },
                  child: Image.asset(
                    R.images.logoTransparent,
                    height: 40,
                  ),
                ),

                // Menu (Clickable items for navigation)
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        context.go("/dashboard");
                      },
                      child: const Text("Home"),
                    ),
                    TextButton(
                      onPressed: () {
                        context.go("/shop_view");
                      },
                      child: const Text("Shop"),
                    ),
                    TextButton(
                      onPressed: () {
                        context.go("/about_us");
                      },
                      child: const Text("About"),
                    ),
                    TextButton(
                      onPressed: () {
                        context.go("/contact_us");
                      },
                      child: const Text("Contact"),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Badge.count(
                      count: context.read<BaseVm>().cartItems.length,
                      child: IconButton(
                        icon: const Icon(Icons.shopping_cart),
                        onPressed: () {
                          context.go("/cart_view");
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.account_circle_outlined),
                      onPressed: () {
                        context.go("/user_profile");
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout_outlined),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Logout'),
                              content: const Text(
                                  'Are you sure you want to log out?'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text('Logout'),
                                  onPressed: () async {
                                    await FirebaseAuth.instance.signOut();
                                    await HiveStorage.deleteHive();
                                    Navigator.of(context).pop();
                                    context.go('/login');
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            CategoryRow(),
          ],
        ),
      ),
    );
  }

// //
//   static Widget buildHeader(
//     BuildContext context,
//   ) {
//     return GradientWrapper(
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//         // color: Colors.white,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             // Logo (Clickable to return to Home)
//             InkWell(
//               onTap: () async {
//                 // context.read<BaseVm>().getAdditionalInfo("OfoWF0L9Z5cxLX4IUz1xb1zCpHz1");

//                 // Navigate to Home Screen or refresh Home Screen
//                 context.go("/dashboard");
//                 //
//                 // final d = await FirebaseFirestore.instance
//                 //     .collection('additional_info')
//                 //     .doc("1gecHjl9e5IQNxAAdiqi")
//                 //     .get();
//                 // var data = d.data() as Map<String, dynamic>;
//                 // debugPrint("data: $data");

//                 //
//               },
//               child: Image.asset(R.images.logoTransparent, height: 40),
//             ),

//             // Menu (Clickable items for navigation)
//             Row(
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     // Navigate to Home Screen
//                     context.go("/dashboard");
//                   },
//                   child: const Text("Home"),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     // Navigate to Shop Screen
//                     context.go("/shop_view");
//                   },
//                   child: const Text("Shop"),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     // Navigate to About Screen
//                     context.go("/about_us");
//                   },
//                   child: const Text("About"),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     // Navigate to Contact Screen
//                     context.go("/contact_us");
//                   },
//                   child: const Text("Contact"),
//                 ),
//               ],
//             ),

//             // Icons (Search and Cart functionalities)
//             Row(
//               children: [
//                 // IconButton(
//                 //   icon: const Icon(Icons.search),
//                 //   onPressed: () {
//                 //     // Open search functionality
//                 //   },
//                 // ),
//                 Badge.count(
//                   count: context.read<BaseVm>().cartItems.length,
//                   child: IconButton(
//                     icon: const Icon(Icons.shopping_cart),
//                     onPressed: () {
//                       // Navigate to Cart Screen
//                       context.go("/cart_view");
//                     },
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.account_circle_outlined),
//                   onPressed: () {
//                     context.go("/user_profile");
//                   },
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.logout_outlined),
//                   onPressed: () {
//                     // Show the AlertDialog
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                           title: Text('Logout'),
//                           content: Text('Are you sure you want to log out?'),
//                           actions: <Widget>[
//                             TextButton(
//                               child: Text('Cancel'),
//                               onPressed: () {
//                                 Navigator.of(context).pop(); // Close the dialog
//                               },
//                             ),
//                             TextButton(
//                               child: Text('Logout'),
//                               onPressed: () async {
//                                 await FirebaseAuth.instance.signOut();
//                                 await HiveStorage.deleteHive();

//                                 //

//                                 // Close the dialog and navigate to the login page or homepage
//                                 Navigator.of(context).pop();
//                                 context.go(
//                                     '/login'); // Assuming you have a login route
//                               },
//                             ),
//                           ],
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

  static Widget emptyScreen(
    context, {
    required String image,
    required String title,
    required String desc,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              image,
              scale: 4,
              color: R.colors.primaryColor,
            ),
            h2,
            Text(
              title,
              textAlign: TextAlign.center,
              style: R.textStyles
                  .poppins(context: context)
                  .copyWith(color: R.colors.tealDark, fontSize: 15),
            ),
            h1,
            Text(
              desc,
              textAlign: TextAlign.center,
              style: R.textStyles
                  .poppins(context: context)
                  .copyWith(color: R.colors.blueGrey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  static Widget lottieWidget(BuildContext context, {double? width}) {
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.only(
        left: ResponsiveBreakpoints.of(context).isMobile
            ? 10.w
            : ResponsiveBreakpoints.of(context).isTablet
                ? 15.w
                : 20.w,
      ),
      child: Image.asset(
        R.images.logo,
        width: width ?? 50.w,
        height: 30,
      ),
    );
  }

  static Padding formPadding(
      {required BuildContext context, required Widget child}) {
    return Padding(
      padding: ResponsiveWidget.isLargeScreen(context)
          ? EdgeInsets.symmetric(horizontal: 10.w)
          : EdgeInsets.symmetric(horizontal: 8.sp),
      child: child,
    );
  }

  Widget footerWidget(
      {required BuildContext context, bool? fromLogin = false}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // width: width * 0.2, // Adjust width as needed
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ],
          ),
        ),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 18) +
                const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              color: R.colors.textMediumGrey.withOpacity(.25),
            ),
            child: (ResponsiveBreakpoints.of(context).isMobile ||
                    ResponsiveBreakpoints.of(context).isTablet)
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "COPYRIGHT TEXT",
                        style: R.textStyles.poppins(
                            context: context,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: R.colors.textMediumGrey.withOpacity(.7)),
                      ),
                      w2,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          txtWidget(
                              "contact us", 0, context, (fromLogin ?? false)),
                          w1,
                          txtWidget(
                              "about us", 1, context, (fromLogin ?? false)),
                          w1,
                          txtWidget(
                              "terms of use", 2, context, (fromLogin ?? false)),
                        ],
                      )
                    ],
                  )
                : Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "COPYRIGHT TEXT",
                        style: R.textStyles.poppins(
                            context: context,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: R.colors.textMediumGrey.withOpacity(.7)),
                      ),
                      w2,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          txtWidget(
                              "contact us", 0, context, (fromLogin ?? false)),
                          w1,
                          txtWidget(
                              "about us", 1, context, (fromLogin ?? false)),
                          w1,
                          txtWidget(
                              "terms of use", 2, context, (fromLogin ?? false)),
                        ],
                      )
                    ],
                  )),
      ],
    );
  }

  Widget txtWidget(
      String txt, int index, BuildContext context, bool fromLogin) {
    return InkWell(
      onTap: () {
        var vm = Provider.of<CommonVM>(context, listen: false);

        switch (index) {
          case 0:
            vm.selectedIndex = 1; //contactus
            break;
          case 1:
            vm.selectedIndex = 2; //about app
            break;
          case 2:
            vm.selectedIndex = 0; //terms
            break;
          default:
        }
        vm.fromLogin = fromLogin;
        context.goNamed("app_settings");
        vm.update();
        vm.appSettingsPC = vm.selectedIndex;
        vm.update();
      },
      child: Text(
        txt,
        style: R.textStyles
            .poppins(
                context: context,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: R.colors.lightBlack)
            .copyWith(decoration: TextDecoration.underline),
      ),
    );
  }

  static Widget topIndicatorWidget(
    BuildContext context, {
    required String first,
    required String second,
    String? third,
    void Function()? fTap,
    void Function()? sTap,
  }) {
    return Row(
      children: [
        InkWell(
          onTap: fTap ??
              () {
                // if (AppData.userProfile?.id == null) {
                //   context.pushReplacement("/guestCustomerDashboardView");
                // } else {
                //   context.pushReplacement("/customerDashboardView");
                // }
              },
          child: Text(
            '$first ',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: R.textStyles.poppins(
              context: context,
              fontSize: 18,
              color: R.colors.blueGrey.withOpacity(.7),
            ),
          ),
        ),
        InkWell(
          onTap: sTap,
          child: Text(
            second.isEmpty ? "" : '/ $second ',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: R.textStyles.poppins(
              context: context,
              fontSize: 18,
              color: R.colors.blueGrey.withOpacity(.7),
            ),
          ),
        ),
        if (third != null)
          Flexible(
            child: Text(
              '/ $third',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: R.textStyles.poppins(
                context: context,
                fontSize: 18,
                color: R.colors.blueGrey.withOpacity(.7),
              ),
            ),
          ),
      ],
    );
  }

  static Widget loadMore(BuildContext context,
      {required void Function() onTap}) {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () => onTap(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          decoration: BoxDecoration(
            color: R.colors.primaryColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                R.images.logo,
                height: 30,
                width: 30,
              ),
              const SizedBox(width: 8),
              Text(
                "Load More",
                style: R.textStyles.poppins(
                  context: context,
                  color: R.colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }

  static bookedWidget(double height) {
    return Container(
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: R.colors.black.withOpacity(.4),
      ),
      // child: Transform.rotate(
      //   angle: -19.5,
      child: Transform.rotate(
        angle: -33.0 * pi / 180,
        child: Text(
          'Booked',
          style: R.textStyles.damageplanPersonalUseBold(),
        ),
        // ),
      ),
    );
  }

  Widget dotedLine() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: DottedLine(
        direction: Axis.horizontal,
        lineLength: double.infinity,
        lineThickness: 1.0,
        dashLength: 5.0,
        dashColor: Colors.black,
        dashGradient: [R.colors.primaryColor, R.colors.secondaryColor],
        dashRadius: 0.1,
        dashGapLength: 3.0,
        dashGapColor: Colors.transparent,
        //dashGapGradient: [Colors.red, Colors.blue],
        dashGapRadius: 0.0,
      ),
    );
  }

  static Align loadMoreWidget(
      {required BuildContext context, void Function()? onTap}) {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          decoration: BoxDecoration(
            color: R.colors.primaryColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  R.images.logo,
                  height: 30,
                  width: 30,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "Load More",
                style: R.textStyles.poppins(
                  context: context,
                  color: R.colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }

  static Widget healthFitnessButton(BuildContext context,
      {required String title,
      required Color textColor,
      required Color backGroundColor}) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: backGroundColor,
      ),
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: R.textStyles.poppins(
          context: context,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }

  // static Widget errorBuilder({bool? fromMain = false}) {
  //   return Scaffold(
  //     backgroundColor: R.colors.mistyWhite,
  //     body: (fromMain ?? false)
  //         ? (!loaderAfterTime)
  //             ? Center(child: GlobalWidgets.loaderWidget())
  //             : Stack(
  //                 children: [
  //                   Container(color: Colors.black.withOpacity(0.5)),
  //                   Center(
  //                     child: Card(
  //                       elevation: 5,
  //                       margin: const EdgeInsets.symmetric(horizontal: 20),
  //                       child: Padding(
  //                         padding: const EdgeInsets.all(20.0),
  //                         child: Column(
  //                           mainAxisSize: MainAxisSize.min,
  //                           children: [
  //                             const Icon(Icons.error outline, color: Colors.red, size: 50),
  //                             const SizedBox(height: 20),
  //                             const Text(
  //                               "Oops! An error occurred",
  //                               style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
  //                             ),
  //                             const SizedBox(height: 10),
  //                             const Text(
  //                               "We apologize for the inconvenience.",
  //                               textAlign: TextAlign.center,
  //                               style: TextStyle(color: Colors.black, fontSize: 16),
  //                             ),
  //                             const SizedBox(height: 10),
  //                             const Text(
  //                               "Please reload the page.",
  //                               style: TextStyle(color: Colors.black, fontSize: 16),
  //                             ),
  //                             const SizedBox(height: 20),
  //                             ElevatedButton(
  //                               onPressed: () {
  //                                 html.window.location.reload();
  //                               },
  //                               style: ElevatedButton.styleFrom(
  //                                 foregroundColor: Colors.white, backgroundColor: Colors.blue, disabledForegroundColor: Colors.grey.withOpacity(0.38),
  //                                 disabledBackgroundColor: Colors.grey.withOpacity(0.12),
  //                                 elevation: 5, // Add elevation for a raised appearance
  //                                 padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
  //                                 shape: RoundedRectangleBorder(
  //                                   borderRadius: BorderRadius.circular(30),
  //                                 ),
  //                                 shadowColor: Colors.blueAccent,
  //                               ),
  //                               child: const Text("Reload", style: TextStyle(fontSize: 16)),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               )
  //         : Stack(
  //             children: [
  //               Container(color: Colors.black.withOpacity(0.5)),
  //               Center(
  //                 child: Card(
  //                   elevation: 5,
  //                   margin: const EdgeInsets.symmetric(horizontal: 20),
  //                   child: Padding(
  //                     padding: const EdgeInsets.all(20.0),
  //                     child: Column(
  //                       mainAxisSize: MainAxisSize.min,
  //                       children: [
  //                         const Icon(Icons.error_outline, color: Colors.red, size: 50),
  //                         const SizedBox(height: 20),
  //                         const Text(
  //                           "Oops! An error occurred",
  //                           style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
  //                         ),
  //                         const SizedBox(height: 10),
  //                         const Text(
  //                           "We apologize for the inconvenience.",
  //                           textAlign: TextAlign.center,
  //                           style: TextStyle(color: Colors.black, fontSize: 16),
  //                         ),
  //                         const SizedBox(height: 10),
  //                         const Text(
  //                           "Please reload the page.",
  //                           style: TextStyle(color: Colors.black, fontSize: 16),
  //                         ),
  //                         const SizedBox(height: 20),
  //                         ElevatedButton(
  //                           onPressed: () {
  //                             html.window.location.reload();
  //                           },
  //                           style: ElevatedButton.styleFrom(
  //                             foregroundColor: Colors.white, backgroundColor: Colors.blue, disabledForegroundColor: Colors.grey.withOpacity(0.38),
  //                             disabledBackgroundColor: Colors.grey.withOpacity(0.12),
  //                             elevation: 5, // Add elevation for a raised appearance
  //                             padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
  //                             shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(30),
  //                             ),
  //                             shadowColor: Colors.blueAccent,
  //                           ),
  //                           child: const Text("Reload", style: TextStyle(fontSize: 16)),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //   );
  // }

  static Widget loaderWidget({double? size}) {
    return Center(
      child: Container(
        width: size ?? 50,
        height: size ?? 50,
        decoration: BoxDecoration(
            // boxShadow: [
            //   BoxShadow(
            //     color: R.colors.themePink.withOpacity(.50),
            //     spreadRadius: 3,
            //     blurRadius: 5,
            //   )
            // ],
            // borderRadius: BorderRadius.circular(30),
            ),
        child: SpinKitCubeGrid(
          // color: R.colors.themePink,
          // size: size ?? 50,
          itemBuilder: (BuildContext context, int index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: index.isEven ? R.colors.softPink : R.colors.softlime,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget BuildTextField(TextEditingController controller, String label,
      String hint, TextInputType keyboardType) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget BuildDropdown(
      String label, List<String> items, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: items
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(item),
                ))
            .toList(),
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select $label';
          }
          return null;
        },
      ),
    );
  }

  // void _reloadApp() {
  //   SchedulerBinding.instance.addPostFrameCallback((_) {
  //     html.window.location.reload();
  //   });
  // }

  static Widget scrollerWidget({
    required BuildContext context,
    required ScrollController controller,
    required Widget child,
  }) {
    return RawScrollbar(
      controller: controller,
      thickness: 2.4,
      thumbColor: R.colors.themePink,
      trackColor: R.colors.transparent,
      radius: const Radius.circular(5),
      thumbVisibility: false,
      scrollbarOrientation: ScrollbarOrientation.right,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: child,
      ),
    );
  }

  static PopupMenuItem popupMenuItem(int val, String title) {
    return PopupMenuItem(
        height: 0,
        value: val,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: R.textStyles.poppins().copyWith(
                  fontWeight: FontWeight.w500,
                  color: R.colors.themePink,
                  fontSize: 11,
                ),
          ),
        ));
  }
}
