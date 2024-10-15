import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  int? status;
  Discount? discount;
  String? description;
  String? categoryId;
  List<String>? sizes;
  Timestamp? createdAt;
  String? color;
  String? name;
  Timestamp? updatedAt;
  String? id;
  bool? isFeatured;
  bool? favorites;
  int? stockQuantity;
  bool? shareable;
  AdditionalInfo? additionalInfo;
  String? gender;
  Rating? rating;
  Shipping? shipping;
  double? price;
  List<String>? imageUrl;
  List<String>? tags;

  ProductModel({
    this.status,
    this.discount,
    this.description,
    this.categoryId,
    this.sizes,
    this.createdAt,
    this.color,
    this.name,
    this.updatedAt,
    this.id,
    this.isFeatured,
    this.favorites,
    this.stockQuantity,
    this.shareable,
    this.additionalInfo,
    this.gender,
    this.rating,
    this.shipping,
    this.price,
    this.imageUrl,
    this.tags,
  });

  factory ProductModel.fromJson(dynamic json) {
    return ProductModel(
      status: json['status'],
      discount: json['discount'] != null ? Discount.fromJson(json['discount']) : null,
      description: json['description'],
      categoryId: json['category_id'],
      sizes: json['sizes'] != null ? List<String>.from(json['sizes']) : null,
      createdAt: json['created_at'],
      color: json['color'],
      name: json['name'],
      updatedAt: json['updated_at'],
      id: json['id'],
      isFeatured: json['is_featured'],
      favorites: json['favorites'],
      stockQuantity: json['stock_quantity'],
      shareable: json['shareable'],
      additionalInfo: json['additional_info'] != null ? AdditionalInfo.fromJson(json['additional_info']) : null,
      gender: json['gender'],
      rating: json['rating'] != null ? Rating.fromJson(json['rating']) : null,
      shipping: json['shipping'] != null ? Shipping.fromJson(json['shipping']) : null,
      price: json['price']?.toDouble(),
      imageUrl: json['image_url'] != null ? List<String>.from(json['image_url']) : null,
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'discount': discount?.toJson(),
      'description': description,
      'category_id': categoryId,
      'sizes': sizes,
      'created_at': createdAt,
      'color': color,
      'name': name,
      'updated_at': updatedAt,
      'id': id,
      'is_featured': isFeatured,
      'favorites': favorites,
      'stock_quantity': stockQuantity,
      'shareable': shareable,
      'additional_info': additionalInfo?.toJson(),
      'gender': gender,
      'rating': rating?.toJson(),
      'shipping': shipping?.toJson(),
      'price': price,
      'image_url': imageUrl,
      'tags': tags,
    };
  }
}

class Discount {
  bool? available;
  int? percentage;

  Discount({this.available, this.percentage});

  factory Discount.fromJson(Map<String, dynamic> json) {
    return Discount(
      available: json['available'],
      percentage: json['percentage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'available': available,
      'percentage': percentage,
    };
  }
}

class AdditionalInfo {
  String? ageGroup;
  String? careInstructions;
  String? brand;
  String? material;
  List<String>? colors;

  AdditionalInfo({this.ageGroup, this.careInstructions, this.brand, this.material, this.colors});

  factory AdditionalInfo.fromJson(Map<String, dynamic> json) {
    return AdditionalInfo(
      ageGroup: json['age_group'],
      careInstructions: json['care_instructions'],
      brand: json['brand'],
      material: json['material'],
      colors: json['colors'] != null ? List<String>.from(json['colors']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'age_group': ageGroup,
      'care_instructions': careInstructions,
      'brand': brand,
      'material': material,
      'colors': colors,
    };
  }
}

class Rating {
  double? average;
  int? reviews;

  Rating({this.average, this.reviews});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      average: json['average']?.toDouble(),
      reviews: json['reviews'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'average': average,
      'reviews': reviews,
    };
  }
}

class Shipping {
  String? estimatedDelivery;
  bool? freeShipping;

  Shipping({this.estimatedDelivery, this.freeShipping});

  factory Shipping.fromJson(Map<String, dynamic> json) {
    return Shipping(
      estimatedDelivery: json['estimated_delivery'],
      freeShipping: json['free_shipping'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'estimated_delivery': estimatedDelivery,
      'free_shipping': freeShipping,
    };
  }
}
