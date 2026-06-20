import 'package:flutter/painting.dart';
import '../models/product.dart';

class MockDataService {
  static const _amazon = Color(0xFFFF9900);
  static const _flipkart = Color(0xFF2874F0);
  static const _meesho = Color(0xFFF43397);
  static const _snapdeal = Color(0xFFE40000);
  static const _myntra = Color(0xFFFF3F6C);

  static List<Product> get products => [
        Product(
          id: '1',
          name: 'Samsung Galaxy S24 Ultra 5G',
          brand: 'Samsung',
          category: 'smartphones',
          image:
              'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=600',
          description:
              '6.8" QHD+ Display, 200MP Camera, Snapdragon 8 Gen 3, 5000mAh battery',
          specs: ['256GB Storage', '12GB RAM', 'Titanium Build', 'S Pen'],
          tags: ['deal', 'bestseller'],
          priceHistory: [
            PricePoint(date: DateTime(2024, 1, 1), price: 134999),
            PricePoint(date: DateTime(2024, 1, 15), price: 129999),
            PricePoint(date: DateTime(2024, 2, 1), price: 124999),
            PricePoint(date: DateTime(2024, 2, 15), price: 119999),
            PricePoint(date: DateTime(2024, 3, 1), price: 122999),
            PricePoint(date: DateTime(2024, 3, 15), price: 117999),
          ],
          platforms: [
            PlatformData(key: 'amazon', name: 'Amazon', color: _amazon, price: 117999, rating: 4.5, reviews: 2341, delivery: '2 days', inStock: true, url: 'https://amazon.in', originalPrice: 134999),
            PlatformData(key: 'flipkart', name: 'Flipkart', color: _flipkart, price: 119499, rating: 4.3, reviews: 1876, delivery: '3 days', inStock: true, url: 'https://flipkart.com', originalPrice: 134999),
            PlatformData(key: 'snapdeal', name: 'Snapdeal', color: _snapdeal, price: 121000, rating: 4.0, reviews: 432, delivery: '5 days', inStock: true, url: 'https://snapdeal.com', originalPrice: 134999),
          ],
        ),
        Product(
          id: '2',
          name: 'Sony WH-1000XM5 Headphones',
          brand: 'Sony',
          category: 'audio',
          image:
              'https://images.unsplash.com/photo-1546435770-a3e426bf472b?w=600',
          description:
              'Industry-leading ANC, 30hr battery, LDAC Hi-Res Audio, Multipoint connect',
          specs: ['30hr Battery', 'Noise Cancelling', 'Multipoint', 'Foldable'],
          tags: ['deal', 'trending'],
          priceHistory: [
            PricePoint(date: DateTime(2024, 1, 1), price: 29990),
            PricePoint(date: DateTime(2024, 1, 15), price: 27990),
            PricePoint(date: DateTime(2024, 2, 1), price: 25990),
            PricePoint(date: DateTime(2024, 2, 15), price: 24990),
            PricePoint(date: DateTime(2024, 3, 1), price: 26490),
            PricePoint(date: DateTime(2024, 3, 15), price: 23990),
          ],
          platforms: [
            PlatformData(key: 'amazon', name: 'Amazon', color: _amazon, price: 23990, rating: 4.6, reviews: 5621, delivery: '1 day', inStock: true, url: 'https://amazon.in', originalPrice: 29990),
            PlatformData(key: 'flipkart', name: 'Flipkart', color: _flipkart, price: 24490, rating: 4.4, reviews: 3210, delivery: '2 days', inStock: true, url: 'https://flipkart.com', originalPrice: 29990),
            PlatformData(key: 'meesho', name: 'Meesho', color: _meesho, price: 22500, rating: 3.7, reviews: 189, delivery: '7 days', inStock: true, url: 'https://meesho.com', originalPrice: 29990),
          ],
        ),
        Product(
          id: '3',
          name: 'Apple MacBook Air M3',
          brand: 'Apple',
          category: 'laptops',
          image:
              'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=600',
          description:
              '13" Liquid Retina, Apple M3 chip, 18hr battery, fanless design',
          specs: ['M3 Chip', '8GB RAM', '256GB SSD', '18hr Battery'],
          tags: ['bestseller'],
          priceHistory: [
            PricePoint(date: DateTime(2024, 1, 1), price: 114900),
            PricePoint(date: DateTime(2024, 1, 15), price: 112900),
            PricePoint(date: DateTime(2024, 2, 1), price: 112900),
            PricePoint(date: DateTime(2024, 2, 15), price: 109900),
            PricePoint(date: DateTime(2024, 3, 1), price: 111900),
            PricePoint(date: DateTime(2024, 3, 15), price: 108900),
          ],
          platforms: [
            PlatformData(key: 'amazon', name: 'Amazon', color: _amazon, price: 108900, rating: 4.8, reviews: 4532, delivery: '2 days', inStock: true, url: 'https://amazon.in', originalPrice: 114900),
            PlatformData(key: 'flipkart', name: 'Flipkart', color: _flipkart, price: 109900, rating: 4.7, reviews: 2341, delivery: '3 days', inStock: true, url: 'https://flipkart.com', originalPrice: 114900),
          ],
        ),
        Product(
          id: '4',
          name: 'Nike Air Max 270',
          brand: 'Nike',
          category: 'footwear',
          image:
              'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600',
          description:
              'Max Air heel cushioning, engineered mesh upper, rubber outsole',
          specs: ['Air Max Heel', 'Mesh Upper', 'Rubber Outsole', 'All Day'],
          tags: ['trending', 'deal'],
          priceHistory: [
            PricePoint(date: DateTime(2024, 1, 1), price: 12995),
            PricePoint(date: DateTime(2024, 1, 15), price: 11995),
            PricePoint(date: DateTime(2024, 2, 1), price: 10995),
            PricePoint(date: DateTime(2024, 2, 15), price: 9995),
            PricePoint(date: DateTime(2024, 3, 1), price: 10495),
            PricePoint(date: DateTime(2024, 3, 15), price: 9495),
          ],
          platforms: [
            PlatformData(key: 'amazon', name: 'Amazon', color: _amazon, price: 9495, rating: 4.3, reviews: 8921, delivery: '3 days', inStock: true, url: 'https://amazon.in', originalPrice: 12995),
            PlatformData(key: 'flipkart', name: 'Flipkart', color: _flipkart, price: 9799, rating: 4.2, reviews: 5432, delivery: '4 days', inStock: true, url: 'https://flipkart.com', originalPrice: 12995),
            PlatformData(key: 'myntra', name: 'Myntra', color: _myntra, price: 9295, rating: 4.4, reviews: 3210, delivery: '2 days', inStock: true, url: 'https://myntra.com', originalPrice: 12995),
            PlatformData(key: 'meesho', name: 'Meesho', color: _meesho, price: 8999, rating: 3.5, reviews: 432, delivery: '8 days', inStock: false, url: 'https://meesho.com', originalPrice: 12995),
          ],
        ),
        Product(
          id: '5',
          name: 'LG 55" OLED C3 4K TV',
          brand: 'LG',
          category: 'televisions',
          image:
              'https://images.unsplash.com/photo-1593784991095-a205069470b6?w=600',
          description:
              'OLED evo panel, α9 AI Processor 4K, Dolby Vision IQ, webOS 23',
          specs: ['OLED evo Panel', '120Hz', 'G-Sync Compatible', 'Dolby Atmos'],
          tags: ['deal'],
          priceHistory: [
            PricePoint(date: DateTime(2024, 1, 1), price: 169990),
            PricePoint(date: DateTime(2024, 1, 15), price: 159990),
            PricePoint(date: DateTime(2024, 2, 1), price: 154990),
            PricePoint(date: DateTime(2024, 2, 15), price: 149990),
            PricePoint(date: DateTime(2024, 3, 1), price: 152990),
            PricePoint(date: DateTime(2024, 3, 15), price: 144990),
          ],
          platforms: [
            PlatformData(key: 'amazon', name: 'Amazon', color: _amazon, price: 144990, rating: 4.6, reviews: 1234, delivery: '5 days', inStock: true, url: 'https://amazon.in', originalPrice: 169990),
            PlatformData(key: 'flipkart', name: 'Flipkart', color: _flipkart, price: 146990, rating: 4.5, reviews: 987, delivery: '7 days', inStock: true, url: 'https://flipkart.com', originalPrice: 169990),
            PlatformData(key: 'snapdeal', name: 'Snapdeal', color: _snapdeal, price: 148000, rating: 4.1, reviews: 234, delivery: '10 days', inStock: true, url: 'https://snapdeal.com', originalPrice: 169990),
          ],
        ),
        Product(
          id: '6',
          name: 'Dyson V15 Detect Vacuum',
          brand: 'Dyson',
          category: 'appliances',
          image:
              'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=600',
          description:
              'Laser dust detection, 60min runtime, HEPA filtration, 240 AW suction',
          specs: ['Laser Detection', '60min Battery', 'HEPA Filter', '240AW'],
          tags: ['bestseller'],
          priceHistory: [
            PricePoint(date: DateTime(2024, 1, 1), price: 65900),
            PricePoint(date: DateTime(2024, 1, 15), price: 62900),
            PricePoint(date: DateTime(2024, 2, 1), price: 59900),
            PricePoint(date: DateTime(2024, 2, 15), price: 57900),
            PricePoint(date: DateTime(2024, 3, 1), price: 58900),
            PricePoint(date: DateTime(2024, 3, 15), price: 55900),
          ],
          platforms: [
            PlatformData(key: 'amazon', name: 'Amazon', color: _amazon, price: 55900, rating: 4.7, reviews: 2341, delivery: '2 days', inStock: true, url: 'https://amazon.in', originalPrice: 65900),
            PlatformData(key: 'flipkart', name: 'Flipkart', color: _flipkart, price: 56900, rating: 4.5, reviews: 1234, delivery: '3 days', inStock: true, url: 'https://flipkart.com', originalPrice: 65900),
          ],
        ),
      ];

  static const List<Map<String, String>> categories = [
    {'id': 'all', 'name': 'All', 'emoji': '⚡'},
    {'id': 'smartphones', 'name': 'Phones', 'emoji': '📱'},
    {'id': 'laptops', 'name': 'Laptops', 'emoji': '💻'},
    {'id': 'audio', 'name': 'Audio', 'emoji': '🎧'},
    {'id': 'televisions', 'name': 'TVs', 'emoji': '📺'},
    {'id': 'footwear', 'name': 'Shoes', 'emoji': '👟'},
    {'id': 'appliances', 'name': 'Home', 'emoji': '🏠'},
  ];
}
