import 'dart:convert'; // Import the dart:convert package
import 'dart:developer'; // Import the dart:developer package
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweetchickwardrobe/utils/global_widgets.dart';

class UserProfileSidebar extends StatefulWidget {
  @override
  _UserProfileSidebarState createState() => _UserProfileSidebarState();
}

class _UserProfileSidebarState extends State<UserProfileSidebar> {
  User? currentUser; // Firebase Auth User
  Map<String, dynamic>? userData; // User data from Firestore
  Map<String, dynamic>? additionalInfoData; // Additional info data from Firestore

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await fetchUserData();
      },
    );
  }

  Future<void> fetchUserData() async {
    try {
      currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        String userId = currentUser!.uid;

        // Fetch user data from 'users' collection
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();

        // Fetch additional info from 'additional_info' collection
        QuerySnapshot additionalInfoSnapshot = await FirebaseFirestore.instance.collection('additional_info').where('user_id', isEqualTo: userId).get();

        // Convert data to JSON with indentation for logging
        String userDataJson = userSnapshot.data() != null ? jsonEncode(_convertTimestamps(userSnapshot.data() as Map<String, dynamic>)) : 'No user data available';

        String additionalInfoDataJson = additionalInfoSnapshot.docs.isNotEmpty
            ? jsonEncode(additionalInfoSnapshot.docs.map((doc) => _convertTimestamps(doc.data() as Map<String, dynamic>)).toList())
            : 'No additional info data available';

        // Log user data
        log('User data:\n$userDataJson');

        if (userSnapshot.exists) {
          setState(() {
            userData = userSnapshot.data() as Map<String, dynamic>?;
          });
        }

        // Log additional info data
        log('Additional info data:\n$additionalInfoDataJson');

        if (additionalInfoSnapshot.docs.isNotEmpty) {
          setState(() {
            additionalInfoData = additionalInfoSnapshot.docs[0].data() as Map<String, dynamic>?;
          });
        }
      }
    } catch (e) {
      log("Error fetching user data: $e");
    }
  }

  // Utility function to recursively convert Timestamps to DateTime
  Map<String, dynamic> _convertTimestamps(Map<String, dynamic> data) {
    data.forEach((key, value) {
      if (value is Timestamp) {
        data[key] = value.toDate().toString(); // Convert Timestamp to string
      } else if (value is Map<String, dynamic>) {
        data[key] = _convertTimestamps(value);
      } else if (value is List) {
        data[key] = value.map((item) {
          if (item is Map<String, dynamic>) {
            return _convertTimestamps(item);
          }
          return item;
        }).toList();
      }
    });
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background with gradient
          Container(
              // decoration: BoxDecoration(
              //   gradient: LinearGradient(
              //     begin: Alignment.topLeft,
              //     end: Alignment.bottomRight,
              //     colors: [R.colors.softPink, R.colors.softlime],
              //   ),
              // ),
              ),
          SingleChildScrollView(
            child: Column(
              children: [
                GlobalWidgets.buildHeader(context), // Header stays at the top

                userData == null
                    ? Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.purple.shade700,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              userData!['name'] ?? 'N/A',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              userData!['email'] ?? 'N/A',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 32),

                            // Additional Information Card
                            additionalInfoData != null
                                ? Card(
                                    color: Colors.white,
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Shipping Information',
                                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.purple),
                                          ),
                                          SizedBox(height: 16),
                                          Row(
                                            children: [
                                              Icon(Icons.location_on, color: Colors.purple.shade700),
                                              SizedBox(width: 8),
                                              Text('Address Line 1: ${additionalInfoData!['contact_info']['shipping_address']['address_line_1'] ?? 'N/A'}'),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.location_on, color: Colors.purple.shade700),
                                              SizedBox(width: 8),
                                              Text('Address Line 2: ${additionalInfoData!['contact_info']['shipping_address']['address_line_2'] ?? 'N/A'}'),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.location_city, color: Colors.purple.shade700),
                                              SizedBox(width: 8),
                                              Text('City: ${additionalInfoData!['contact_info']['shipping_address']['city'] ?? 'N/A'}'),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.flag, color: Colors.purple.shade700),
                                              SizedBox(width: 8),
                                              Text('State: ${additionalInfoData!['contact_info']['shipping_address']['state'] ?? 'N/A'}'),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.public, color: Colors.purple.shade700),
                                              SizedBox(width: 8),
                                              Text('Country: ${additionalInfoData!['contact_info']['shipping_address']['country'] ?? 'N/A'}'),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.local_post_office, color: Colors.purple.shade700),
                                              SizedBox(width: 8),
                                              Text('Postal Code: ${additionalInfoData!['contact_info']['shipping_address']['postal_code'] ?? 'N/A'}'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Text(
                                    'No additional information available.',
                                    style: TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                GlobalWidgets.buildFooterWidget(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
