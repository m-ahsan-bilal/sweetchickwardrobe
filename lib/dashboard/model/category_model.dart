import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String? categoryId;
  final String? categoryName;
  final String? imageUrl;
  final Timestamp? createdAt;
  final int? status;
  final String? description;
  final Timestamp? updatedAt;

  CategoryModel({
    this.categoryId,
    this.categoryName,
    this.imageUrl,
    this.createdAt,
    this.status,
    this.description,
    this.updatedAt,
  });

  // Factory method to create an instance from a JSON map
  factory CategoryModel.fromJson(dynamic json) {
    return CategoryModel(
      categoryId: json['category_id'] as String?,
      categoryName: json['category_name'] as String?,
      imageUrl: json['image_url'] as String?,
      createdAt: json['created_at'] as Timestamp?,
      status: json['status'] as int?,
      description: json['description'] as String?,
      updatedAt: json['updated_at'] as Timestamp?,
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'category_id': categoryId,
      'category_name': categoryName,
      'image_url': imageUrl,
      'created_at': createdAt,
      'status': status,
      'description': description,
      'updated_at': updatedAt,
    };
  }

  // CopyWith method for updating the model
  CategoryModel copyWith({
    String? categoryId,
    String? categoryName,
    String? imageUrl,
    Timestamp? createdAt,
    int? status,
    String? description,
    Timestamp? updatedAt,
  }) {
    return CategoryModel(
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      description: description ?? this.description,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
