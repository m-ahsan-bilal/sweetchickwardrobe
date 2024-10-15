class AdditionalInfoModel {
  String? id;
  String? userId;
  ContactInfo? contactInfo;

  AdditionalInfoModel({
    this.id,
    this.userId,
    this.contactInfo,
  });

  // Factory constructor for creating a new instance from a map
  factory AdditionalInfoModel.fromJson(Map<String, dynamic> json) {
    return AdditionalInfoModel(
      id: json['id'] as String?,
      userId: json['user_id'] as String?,
      contactInfo: json['contact_info'] != null
          ? ContactInfo.fromJson(json['contact_info'] as Map<String, dynamic>)
          : null,
    );
  }

  // Method to convert an instance to a map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'contact_info': contactInfo?.toJson(),
    };
  }
}

class ContactInfo {
  ShippingAddress? shippingAddress;

  ContactInfo({this.shippingAddress});

  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    return ContactInfo(
      shippingAddress: json['shipping_address'] != null
          ? ShippingAddress.fromJson(
              json['shipping_address'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shipping_address': shippingAddress?.toJson(),
    };
  }
}

class ShippingAddress {
  String? postalCode;
  String? city;
  String? country;
  String? state;
  String? addressLine1;
  String? addressLine2;

  ShippingAddress({
    this.postalCode,
    this.city,
    this.country,
    this.state,
    this.addressLine1,
    this.addressLine2,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
      postalCode: json['postal_code'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      state: json['state'] as String?,
      addressLine1: json['address_line_1'] as String?,
      addressLine2: json['address_line_2'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postal_code': postalCode,
      'city': city,
      'country': country,
      'state': state,
      'address_line_1': addressLine1,
      'address_line_2': addressLine2,
    };
  }
}
