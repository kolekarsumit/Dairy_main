class Product {
  final String productId;
  final String productName;
  final String price1;
  final String quantity1;
  final String price2;
  final String quantity2;
  final String price3;
  final String quantity3;
  bool isEnable;
  double? fat;
  int? calories;
  int? protein;
  String? expiryDate;
  String? insertionDate;
  int? stock;

  Product({
    required this.productId,
    required this.productName,
    required this.price1,
    required this.quantity1,
    required this.price2,
    required this.quantity2,
    required this.price3,
    required this.isEnable,
    required this.quantity3,
  });

  Product.withDetails({
    required this.productId,
    required this.productName,
    required this.price1,
    required this.quantity1,
    required this.price2,
    required this.quantity2,
    required this.price3,
    required this.quantity3,
    required this.fat,
    required this.calories,
    required this.protein,
    required this.expiryDate,
    required this.insertionDate,
    required this.isEnable,
    required this.stock,
  });

  Map<String, dynamic> toJson() {
    return {
      'productId': productId??'',
      'productName': productName??'',
      'price1': price1??'',
      'quantity1': quantity1??'',
      'price2': price2??'',
      'quantity2': quantity2??'',
      'price3': price3??'',
      'quantity3': quantity3??'',
      'isEnable':isEnable??true,
      'fat': fat??0.0,
      'calories': calories??0,
      'protein': protein??0,
      'expiryDate': expiryDate??'',
      'insertionDate': insertionDate??'',
      'stock': stock??0,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product.withDetails(
      productId: json['productId'],
      productName: json['productName'],
      price1: json['price1'],
      quantity1: json['quantity1'],
      price2: json['price2'],
      quantity2: json['quantity2'],
      price3: json['price3'],
      isEnable:json['isEnable'],
      quantity3: json['quantity3'],
      fat: json['fat'],
      calories: json['calories'],
      protein: json['protein'],
      expiryDate: json['expiryDate'],
      insertionDate: json['insertionDate'],
      stock: json['stock'],
    );
  }
}