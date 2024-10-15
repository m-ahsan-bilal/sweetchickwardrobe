class AppData {
  String? terms;
  String? bannerImage;
  String? bannerText;
  String? aboutApp;
  List<SocialLink>? socialLinks;
  String? privacy;
  ServiceCardsWidget? serviceCardsWidget;

  AppData({
    this.terms,
    this.bannerImage,
    this.bannerText,
    this.aboutApp,
    this.socialLinks,
    this.privacy,
    this.serviceCardsWidget,
  });

  factory AppData.fromJson(Map<String, dynamic> json) {
    return AppData(
      terms: json['terms'] as String?,
      bannerText: json['banner_text'] as String?,
      bannerImage: json['banner_image'] as String?,
      aboutApp: json['about_app'] as String?,
      socialLinks: (json['social_links']?['links'] as List<dynamic>?)?.map((e) => SocialLink.fromJson(e as Map<String, dynamic>)).toList(),
      privacy: json['privacy'] as String?,
      serviceCardsWidget: json['service_cards_widget'] != null ? ServiceCardsWidget.fromJson(json['service_cards_widget'] as Map<String, dynamic>) : null,
    );
  }
}

class SocialLink {
  String? url;
  String? title;
  String? imageUrl;

  SocialLink({
    this.url,
    this.title,
    this.imageUrl,
  });

  factory SocialLink.fromJson(Map<String, dynamic> json) {
    return SocialLink(
      url: json['url'] as String?,
      title: json['title'] as String?,
      imageUrl: json['image_url'] as String?,
    );
  }
}

class ServiceCard {
  String? icon;
  String? description;
  String? actionUrl;
  String? title;

  ServiceCard({
    this.icon,
    this.description,
    this.actionUrl,
    this.title,
  });

  factory ServiceCard.fromJson(Map<String, dynamic> json) {
    return ServiceCard(
      icon: json['icon'] as String?,
      description: json['description'] as String?,
      actionUrl: json['action_url'] as String?,
      title: json['title'] as String?,
    );
  }
}

class ServiceCardsWidget {
  List<ServiceCard>? cards;

  ServiceCardsWidget({
    this.cards,
  });

  factory ServiceCardsWidget.fromJson(Map<String, dynamic> json) {
    return ServiceCardsWidget(
      cards: (json['cards'] as List<dynamic>?)?.map((e) => ServiceCard.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}
