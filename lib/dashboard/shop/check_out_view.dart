
// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:sweetchickwardrobe/dashboard/model/cart_model.dart';
import 'package:sweetchickwardrobe/dashboard/view/widgets/complete_order_widget.dart';
import 'package:sweetchickwardrobe/utils/global_widgets.dart';

class CheckOutView extends StatefulWidget {
  final List<CartItem> cartItems;

  const CheckOutView({super.key, required this.cartItems});

  @override
  State<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView> {
  int _currentStep = 0;
  final _shippingFormKey = GlobalKey<FormState>();
  final _paymentFormKey = GlobalKey<FormState>();

  
  String _address = '';
  String _city = '';
  String _province = '';
  String _contactNumber = '';
  String _email = '';
  String _cardNumber = '';
  String _expiryDate = '';
  String _cvv = '';
  String _name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GlobalWidgets.buildHeader(context),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 300.0, vertical: 20.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Stepper(
                  type: StepperType.vertical,
                  currentStep: _currentStep,
                  onStepCancel: _currentStep == 0
                      ? null
                      : () {
                          setState(() {
                            _currentStep -= 1;
                          });
                        },
                  onStepContinue: _onStepContinue,
                  onStepTapped: (step) => _onStepTapped(step),
                  steps: _buildSteps(),
                ),
              ),
            ),
            GlobalWidgets.buildFooterWidget(context),
          ],
        ),
      ),
    );
  }

  void _onStepTapped(int step) {
    if (step == 1 && _currentStep == 0) {
      // Validate shipping form before allowing to proceed to payment step
      if (_shippingFormKey.currentState!.validate()) {
        _shippingFormKey.currentState!.save();
        setState(() {
          _currentStep = step;
        });
      }
    } else if (step == 2 && _currentStep == 1) {
      // Validate payment form before allowing to proceed to review step
      if (_paymentFormKey.currentState!.validate()) {
        _paymentFormKey.currentState!.save();
        setState(() {
          _currentStep = step;
        });
      }
    } else if (step <= _currentStep) {
      // Allow moving back to any previous step
      setState(() {
        _currentStep = step;
      });
    }
  }

  List<Step> _buildSteps() {
    return [
      Step(
        title: const Text('Shipping'),
        content: _buildShippingForm(),
        isActive: _currentStep >= 0,
        state: _currentStep > 0 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: const Text('Payment'),
        content: _buildPaymentForm(),
        isActive: _currentStep >= 1,
        state: _currentStep > 1 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: const Text('Review'),
        content: _buildReviewOrder(),
        isActive: _currentStep >= 2,
        state: _currentStep >= 2 ? StepState.complete : StepState.indexed,
      ),
    ];
  }

  Widget _buildShippingForm() {
    return Form(
      key: _shippingFormKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
            onSaved: (value) {
              _name = value!;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Address'),
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
          TextFormField(
            decoration: const InputDecoration(labelText: 'City'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your city';
              }
              return null;
            },
            onSaved: (value) {
              _city = value!;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Province'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your province';
              }
              return null;
            },
            onSaved: (value) {
              _province = value!;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Contact Number'),
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your contact number';
              }
              return null;
            },
            onSaved: (value) {
              _contactNumber = value!;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
            onSaved: (value) {
              _email = value!;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentForm() {
    return Form(
      key: _paymentFormKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Card Number'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your card number';
              } else if (value.length < 16) {
                return 'Card number must be 16 digits';
              }
              return null;
            },
            onSaved: (value) {
              _cardNumber = value!;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Expiry Date'),
            keyboardType: TextInputType.datetime,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the expiry date';
              }
              return null;
            },
            onSaved: (value) {
              _expiryDate = value!;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'CVV'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your CVV';
              } else if (value.length < 3) {
                return 'CVV must be 3 digits';
              }
              return null;
            },
            onSaved: (value) {
              _cvv = value!;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReviewOrder() {
    final double total = widget.cartItems.fold(
      0,
      (sum, item) => sum + (item.quantity * (item.product.price ?? 0)),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Review your order',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        // Shipping Details
        _buildShippingDetails(),

        const SizedBox(height: 20),

        // Order Details
        _buildOrderDetails(),

        const SizedBox(height: 20),

        // Grand Total
        Text(
          'Grand Total: ₹${total.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 20),

        // Confirm Order Button
        Center(
          child: ElevatedButton(
            onPressed: CompleteOrderWidget.new,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            ),
            child: const Text('Confirm Order'),
          ),
        ),
      ],
    );
  }

  // Helper function to build the Shipping Details section
  Widget _buildShippingDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Shipping Details',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text('Name: $_name'),
        Text('Address: $_address'),
        Text('City: $_city'),
        Text('Province: $_province'),
        Text('Contact Number: $_contactNumber'),
        Text('Email: $_email'),
      ],
    );
  }

  // Helper function to build the Order Details section
  Widget _buildOrderDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Order Details',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...widget.cartItems.map((item) {
          final product = item.product;
          final price = product.price ?? 0;
          final quantity = item.quantity;
          final total = price * quantity;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    product.name ?? 'Unnamed Product',
                    style: const TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '$quantity x ₹${price.toStringAsFixed(2)} = ₹${total.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  void _onStepContinue() {
    final isLastStep = _currentStep == _buildSteps().length - 1;

    if (_currentStep == 0) {
      if (_shippingFormKey.currentState!.validate()) {
        _shippingFormKey.currentState!.save();
        setState(() {
          _currentStep += 1;
        });
      }
    } else if (_currentStep == 1) {
      if (_paymentFormKey.currentState!.validate()) {
        _paymentFormKey.currentState!.save();
        setState(() {
          _currentStep += 1;
        });
      }
    } else if (isLastStep) {
      CompleteOrderWidget();
    }
  }
}
