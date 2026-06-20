class PlatformData {
  final String key;
  final String name;
  final Color color;
  final double price;
  final double rating;
  final int reviews;
  final String delivery;
  final bool inStock;
  final String url;
  final double originalPrice;

  const PlatformData({
    required this.key,
    required this.name,
    required this.color,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.delivery,
    required this.inStock,
    required this.url,
    required this.originalPrice,
  });
}

class PricePoint {
  final DateTime date;
  final double price;
  const PricePoint({required this.date, required this.price});
}

class Product {
  final String id;
  final String name;
  final String brand;
  final String category;
  final String image;
  final String description;
  final List<String> specs;
  final List<PricePoint> priceHistory;
  final List<PlatformData> platforms;
  final List<String> tags;

  const Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.image,
    required this.description,
    required this.specs,
    required this.priceHistory,
    required this.platforms,
    required this.tags,
  });

  double get bestPrice =>
      platforms.map((p) => p.price).reduce((a, b) => a < b ? a : b);

  double get originalPrice => platforms.first.originalPrice;

  int get discountPercent =>
      ((originalPrice - bestPrice) / originalPrice * 100).round();

  PlatformData get bestPlatform =>
      platforms.reduce((a, b) => a.price < b.price ? a : b);

  double get allTimeLow =>
      priceHistory.map((p) => p.price).reduce((a, b) => a < b ? a : b);

  double get allTimeHigh =>
      priceHistory.map((p) => p.price).reduce((a, b) => a > b ? a : b);
}

// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/painting.dart';
