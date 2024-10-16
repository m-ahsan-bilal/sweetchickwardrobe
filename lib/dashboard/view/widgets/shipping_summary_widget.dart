// ignore_for_file: unused_field

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sweetchickwardrobe/dashboard/view/widgets/picker.dart';
import 'package:sweetchickwardrobe/dashboard/vm/base_vm.dart';
import 'package:sweetchickwardrobe/utils/global_function.dart';
import 'package:sweetchickwardrobe/utils/hive.dart';
import 'package:sweetchickwardrobe/utils/zbotToast.dart';

import '../../model/cart_model.dart';

class ShippingSummaryWidget extends StatefulWidget {
  const ShippingSummaryWidget({super.key});

  @override
  State<ShippingSummaryWidget> createState() => _ShippingSummaryWidgetState();
}

class _ShippingSummaryWidgetState extends State<ShippingSummaryWidget> {
  // The selected payment method
  String? _selectedPaymentMethod = 'cod';

  // final _shippingFormKey = GlobalKey<FormState>();
  final _additionalInfo = GlobalKey<FormState>();
  final discount = 0.0;

  final shippingFee = 0.0;
  double taxAmount = 0;
// subtotal
  double get subtotal => context
      .read<BaseVm>()
      .cartItems
      .fold(0, (sum, item) => sum + (item.product.price ?? 0) * item.quantity);
// Adjust shippingFee as necessary
  double get grandTotal => subtotal - discount + shippingFee;
  String _address = '';
  String _phone = '';
  String _postalCode = '';
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _postalcodeController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  String? city;
  String? state;
  String? country;
  Map? mapUser;
  bool isLoading = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((t) async {
      // here have to get the additional_info to show the data:
      // if the doc.exist then fill the fields else let the fields empty.

      // if the doc.exist then 'update' the button to update the record in firebase of additional_info,
      // else 'confirm' button to add the entry into additional_info collection.

      var vm = Provider.of<BaseVm>(context, listen: false);
      String? userId = await GlobalFunction.updateAuthToken();
      log("----------------------------------------------------- $userId");
      mapUser = await GlobalFunction.updateUser();

      isLoading = await vm.getAdditionalInfo(userId);

      _postalcodeController.text =
          vm.additionalInfoModel?.contactInfo?.shippingAddress?.postalCode ??
              "";
      _addressController.text =
          vm.additionalInfoModel?.contactInfo?.shippingAddress?.addressLine1 ??
              "";
      if (mapUser != null) {
        _phoneController.text = mapUser!['phone'] ?? "";
      }

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    return Container(
      padding: EdgeInsets.all(15),
      width: width * 0.25,
      // height: 500,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Form(
        key: _additionalInfo,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Shipping Details",
              style: TextStyle(
                color: Colors.black,
                fontSize: width * 0.015,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            if (isLoading)
              CountryPicker(
                city: (value) {
                  city = value;
                  log("value $value");
                  log("city $city");
                },
                state: (s) {
                  state = s;
                  log("value $s");
                  log("state $state");
                },
                country: (c) {
                  country = c;
                  log("value $c");
                  log("country $country");
                },
              ),

            SizedBox(height: 10),
            SizedBox(
                width: width * 0.01), // Adds some space between the two fields
            TextFormField(
              controller: _postalcodeController,
              keyboardType: TextInputType.number,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly, // Allow only digits
              ],
              decoration: InputDecoration(
                hintText: "Postal Code",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Color(0xffEFF3F6),
                focusColor: Colors.black,
                hoverColor: Colors.white,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your postal code';
                }
                return null;
              },
              onSaved: (value) {
                _postalCode = value!;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _addressController,
              keyboardType: TextInputType.streetAddress,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                labelText: "Address",
                hintText: "Enter Your Address",
                // contentPadding: const EdgeInsets.symmetric(
                //   horizontal: 16.0, vertical: 12.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Color(0xffEFF3F6),
                focusColor: Colors.black,
                hoverColor: Colors.white,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your address';
                }
                return null;
              },
              onSaved: (value) {
                _address = value!;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly, // Allow only digits
              ],
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                labelText: "Phone",
                hintText: "Enter Your Phone Number",

                // contentPadding: const EdgeInsets.symmetric(
                //   horizontal: 16.0, vertical: 12.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Color(0xffEFF3F6),
                focusColor: Colors.black,
                hoverColor: Colors.white,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your contact number';
                }
                return null;
              },
              onSaved: (value) {
                _phone = value!;
              },
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double
                  .infinity, // Make the button take the full width of its parent
              child: ElevatedButton(
                onPressed: () async {
                  ZBotToast.loadingShow();
                  await updateFunc();
                  ZBotToast.loadingClose();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                      vertical: 20), // Adjust vertical padding as needed
                ),
                child: Text(
                  context.read<BaseVm>().additionalInfoModel == null
                      ? "Confirm"
                      : "Update",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: width * 0.01,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center, // Center the text
                ),
              ),
            ),
            SizedBox(height: 10),
            Divider(thickness: 2, color: Colors.black),
            SizedBox(height: 20),
            Text(
              "Payment Method",
              style: TextStyle(
                color: Colors.black,
                fontSize: width * 0.011,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Cash on Delivery (COD)",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: width * 0.009,
                  ),
                ),
                Radio<String>(
                  value: 'cod',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedPaymentMethod = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Divider(color: Colors.black, thickness: 2),
            // Cart Total Section
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cart Total",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width * 0.011,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Text(
                          "Cart Subtotal:",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: width * 0.009,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        '\$${subtotal.toStringAsFixed(2)}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: width * 0.009,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Text(
                          "Shipping fee:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: width * 0.009,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "Free",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: width * 0.009,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Text(
                          "Discount:",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: width * 0.009,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        '\$${discount.toStringAsFixed(2)}',
                        // '₹{discount.toStringAsFixed(2)}',

                        style: TextStyle(
                            color: Colors.red,
                            fontSize: width * 0.009,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  const Divider(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Text(
                          "Grand Total:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: width * 0.009,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        ' \$${grandTotal.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: width * 0.009,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Center(
                    child: SizedBox(
                      width: double
                          .infinity, // Make the button take the full width of its parent
                      child: ElevatedButton(
                        onPressed: () {
                          List<CartItem> cartItems =
                              context.read<BaseVm>().cartItems;

                          // cart epmty list validation
                          if (cartItems.isEmpty) {
                            ZBotToast.showToastError(
                                title: 'oops',
                                message:
                                    "Please Add some products to place order");
                            print("Your cart is empty.");
                            return;
                          }

                          if (_additionalInfo.currentState!.validate()) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Confirm Order'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        context.go('/cart_view');
                                      },
                                      child: const Text('Back'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        if (mapUser == null) {
                                          return;
                                        }
                                        await confirmFunc(cartItems);

                                        // OrderModel model = OrderModel(
                                        //   items: items,
                                        //   deliveryAddress: DeliveryAddress(
                                        //     addressLine1: _addressController.text.trim(),
                                        //     addressLine2: _addressController.text.trim(),
                                        //     postalCode: _postalcodeController.text.trim(),
                                        //     state: state,
                                        //     city: city,
                                        //     country: country,
                                        //   ),
                                        //   deliveryStatus: "pending",
                                        //   discountAmount: discount,
                                        //   orderDate: "Timestamp.now()",
                                        //   orderStatus: 'order_placed',
                                        //   paymentMethod: PaymentMethod(
                                        //     cardHolderName: "",
                                        //     cvv: "",
                                        //     expiryDate: "",
                                        //     type: "COD",
                                        //   ),
                                        //   paymentStatus: 'pending',
                                        //   subtotjal: subtotal,
                                        //   taxAmount: taxAmount,
                                        //   totalAmount: grandTotajl,
                                        //   trackingNumber: "autogenerated",
                                        //   orderId: 'auto',
                                        //   userId: mapUser!['id'],
                                        // );
                                        // log("=================${model.toJson()}");
                                        // log("=================${jsonEncode(model.toJson())}");
                                        /*   showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title:
                                                  const Text('Order Completed'),
                                              content: const Text(
                                                'Thank you for your purchase!',
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    context.go('/dashboard');
                                                  },
                                                  child: const Text(
                                                      'Continue Shopping'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                       */
                                      },
                                      child: const Text('Confirm'),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            ZBotToast.showToastError(
                              title: 'Oops',
                              message: "please fill the required fields",
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                        ),
                        child: Text(
                          "Confirm Order ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: width * 0.011,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center, // Center the text
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateFunc() async {
    if (city == null || state == null || country == null) {
      ZBotToast.showToastError(
        title: "Select Country, State, City",
        message: "Please make sure to select the country , state and city",
      );
      return;
    }
    if (_additionalInfo.currentState!.validate()) {
      String? userId = await GlobalFunction.updateAuthToken();

      if (userId != null && userId != '') {
        if (context.read<BaseVm>().additionalInfoModel == null) {
          // Create a new document reference with an auto-generated ID
          DocumentReference docRef =
              FirebaseFirestore.instance.collection('additional_info').doc();
          // // Get the generated document ID
          String docId = docRef.id;
          ///////// Now, set the data with the generated docId as the category_id
          await docRef.set({
            'id': docId,
            'user_id': userId,
            'contact_info': {
              'shipping_address': {
                'state': state,
                'postal_code': _postalcodeController.text.trim(),
                'address_line_2': _addressController.text.trim(),
                'city': city,
                'country': country,
                'address_line_1': _addressController.text.trim(),
              },
            },
          });
          Map map = {
            "email": mapUser!['email'],
            "password": mapUser!['password'],
            "id": mapUser!['id'],
            'phone': _phoneController.text.trim(),
            'role': mapUser!['role'],
          };
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .update({
            'phone': _phoneController.text.trim(),
          });
          await HiveStorage.setHive(map);
          ZBotToast.showToastSuccess(message: 'Your Shipping detail Added.');
        } else {
          // here have to update these things.

          await FirebaseFirestore.instance
              .collection('additional_info')
              .doc(context.read<BaseVm>().additionalInfoModel?.id)
              .update({
            'id': context.read<BaseVm>().additionalInfoModel?.id,
            'user_id': userId,
            'contact_info': {
              'shipping_address': {
                'state': state,
                'postal_code': _postalcodeController.text.trim(),
                'address_line_2': _addressController.text.trim(),
                'city': city,
                'country': country,
                'address_line_1': _addressController.text.trim(),
              },
            },
          });

          Map map = {
            "email": mapUser!['email'],
            "password": mapUser!['password'],
            "id": mapUser!['id'],
            'phone': _phoneController.text.trim(),
          };
          log("message============================$map");
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .update({
            'phone': _phoneController.text.trim(),
          });
          await HiveStorage.update(map);
          log("|||| $map");
          log("updated records.");
          ZBotToast.showToastSuccess(message: "Your Shipping detail Updated.");
        }
      } else {
        ZBotToast.showToastError(
          title: "User is not authenticated!",
          message: "Please login again.",
        );
      }
    }
  }

  Future<void> confirmFunc(List<CartItem> cartItems) async {
    if (city == null || state == null || country == null) {
      ZBotToast.showToastError(
        title: "Select Country, State, City",
        message: "Please make sure to select the country , state and city",
      );
      return;
    }
    ZBotToast.loadingShow();
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('orders').doc();

    String docId = docRef.id;

    List<Map<String, dynamic>> list = [];

    cartItems.forEach((cartItem) {
      list.add({
        "price_per_unit": cartItem.product.price,
        "product_id": cartItem.product.id,
        "total_price": (cartItem.product.price ?? 0) * cartItem.quantity,
        "quantity": cartItem.quantity,
        "product_name": cartItem.product.name,
        "size": cartItem.selectedSize,
      });
    });
    Map<String, dynamic> m = {
      "tracking_number": docId,
      "payment_status": "pending",
      "payment_method": {
        "cvv": "",
        "Card_holder_name": "",
        "expiry_date": "",
        "type": "COD"
      },
      "tax_amount": taxAmount,
      "total_amount": grandTotal,
      "items": list,
      "order_status": "order_placed",
      "delivery_address": {
        'city': city,
        'country': country,
        'postal_code': _postalcodeController.text.trim(),
        'address_line_1': _addressController.text.trim(),
        'address_line_2': _addressController.text.trim(),
        'state': state,
      },
      "subtotal": subtotal,
      "delivery_status": "pending",
      "order_id": docId,
      "order_date": Timestamp.now(),
      "discount_amount": discount,
      "user_id": mapUser!['id'].toString(),
    };
    log('mapUser: ${mapUser.runtimeType}');
    log('user_id: ${mapUser!['id']}');

    log("=================${m}");

    await docRef.set(m);
    cartItems.clear();
    context.read<BaseVm>().cartItems.clear();
    context.read<BaseVm>().update();
    setState(() {});
    ZBotToast.loadingClose();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Order Completed'),
          content: const Text(
            'Thank you for your purchase!',
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.go('/dashboard');
              },
              child: const Text('Continue Shopping'),
            ),
          ],
        );
      },
    );
    ZBotToast.showToastSuccess(message: 'Your Order has been placed.');
  }
}
