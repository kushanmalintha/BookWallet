class Shop {
  final int shopId;
  final String name;
  final String category;
  final String locatedCity;
  final String phoneNumber;
  final String locationLink;

  Shop({
    required this.shopId,
    required this.name,
    required this.category,
    required this.locatedCity,
    required this.phoneNumber,
    required this.locationLink,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      shopId: json['shopId'],
      name: json['name'],
      category: json['category'],
      locatedCity: json['locatedCity'],
      phoneNumber: json['phoneNumber'],
      locationLink: json['locationLink'],
    );
  }
}
