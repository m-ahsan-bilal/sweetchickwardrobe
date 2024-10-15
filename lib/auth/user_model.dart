import 'package:cloud_firestore/cloud_firestore.dart'; // For Timestamp

class UserModel {
  String? phone;
  Timestamp? updatedAt;
  String? profilePicture;
  String? name;
  int? role;
  String? id;
  int? status;
  String? email;
  String? password;
  Timestamp? createdAt;

  UserModel({
    this.phone,
    this.updatedAt,
    this.profilePicture,
    this.name,
    this.role,
    this.id,
    this.status,
    this.email,
    this.password,
    this.createdAt,
  });

  // Convert a UserModel instance to a Map for Firestore
  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'updated_at': updatedAt,
      'profile_picture': profilePicture,
      'name': name,
      'role': role,
      'id': id,
      'status': status,
      'email': email,
      'password': password,
      'created_at': createdAt,
    };
  }

  // Create a UserModel instance from a Map
  factory UserModel.fromJson(dynamic map) {
    return UserModel(
      phone: map['phone'],
      updatedAt: map['updated_at'],
      profilePicture: map['profile_picture'],
      name: map['name'],
      role: map['role'],
      id: map['id'],
      status: map['status'],
      email: map['email'],
      password: map['password'],
      createdAt: map['created_at'],
    );
  }

  // Create a copy of the current instance with optional modifications
  UserModel copyWith({
    String? phone,
    Timestamp? updatedAt,
    String? profilePicture,
    String? name,
    int? role,
    String? id,
    int? status,
    String? email,
    String? password,
    Timestamp? createdAt,
  }) {
    return UserModel(
      phone: phone ?? this.phone,
      updatedAt: updatedAt ?? this.updatedAt,
      profilePicture: profilePicture ?? this.profilePicture,
      name: name ?? this.name,
      role: role ?? this.role,
      id: id ?? this.id,
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
