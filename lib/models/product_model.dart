import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final DateTime? createdAt;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.createdAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json, String documentId) {
    double parsePrice(dynamic value) {
      if (value is int) return value.toDouble();
      if (value is double) return value;
      return 0.0;
    }

    return ProductModel(
      id: documentId,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: parsePrice(json['price']),
      imageUrl: json['imageUrl'] ?? '',
      category: json['category'] ?? '',
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'createdAt': createdAt,
    };
  }
}
