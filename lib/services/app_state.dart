import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../services/mock_data.dart';

class AppState extends ChangeNotifier {
  List<Product> _allProducts = MockDataService.products;
  List<Product> _filtered = MockDataService.products;
  String _searchQuery = '';
  String _selectedCategory = 'all';
  Set<String> _watchlist = {};
  double _margin = 1000;
  bool _isPercentage = false;
  double _marginPercent = 5;
  bool _isRefreshing = false;
  DateTime _lastUpdated = DateTime.now();

  // Getters
  List<Product> get filtered => _filtered;
  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;
  Set<String> get watchlist => _watchlist;
  double get margin => _margin;
  bool get isPercentage => _isPercentage;
  double get marginPercent => _marginPercent;
  bool get isRefreshing => _isRefreshing;
  DateTime get lastUpdated => _lastUpdated;

  List<Product> get watchlistProducts =>
      _allProducts.where((p) => _watchlist.contains(p.id)).toList();

  double effectiveMargin(double bestPrice) {
    if (_isPercentage) return bestPrice * (_marginPercent / 100);
    return _margin;
  }

  String get marginLabel =>
      _isPercentage ? '±${_marginPercent.toStringAsFixed(0)}%' : '±₹${_margin.toInt()}';

  void setSearch(String q) {
    _searchQuery = q;
    _applyFilters();
  }

  void setCategory(String cat) {
    _selectedCategory = cat;
    _applyFilters();
  }

  void setMargin(double val, {bool isPercent = false, double percent = 5}) {
    _margin = val;
    _isPercentage = isPercent;
    _marginPercent = percent;
    notifyListeners();
  }

  void toggleWatchlist(String id) {
    if (_watchlist.contains(id)) {
      _watchlist.remove(id);
    } else {
      _watchlist.add(id);
    }
    notifyListeners();
  }

  bool inWatchlist(String id) => _watchlist.contains(id);

  void _applyFilters() {
    var list = List<Product>.from(_allProducts);
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      list = list
          .where((p) =>
              p.name.toLowerCase().contains(q) ||
              p.brand.toLowerCase().contains(q) ||
              p.category.toLowerCase().contains(q) ||
              p.description.toLowerCase().contains(q))
          .toList();
    }
    if (_selectedCategory != 'all') {
      list = list.where((p) => p.category == _selectedCategory).toList();
    }
    _filtered = list;
    notifyListeners();
  }

  Future<void> refresh() async {
    _isRefreshing = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 1500));
    // Simulate slight price changes
    _allProducts = _allProducts.map((product) {
      final updatedPlatforms = product.platforms.map((p) {
        final delta = (DateTime.now().millisecondsSinceEpoch % 201) - 100;
        return PlatformData(
          key: p.key,
          name: p.name,
          color: p.color,
          price: (p.price + delta).clamp(p.originalPrice * 0.5, p.originalPrice),
          rating: p.rating,
          reviews: p.reviews,
          delivery: p.delivery,
          inStock: p.inStock,
          url: p.url,
          originalPrice: p.originalPrice,
        );
      }).toList();
      return Product(
        id: product.id,
        name: product.name,
        brand: product.brand,
        category: product.category,
        image: product.image,
        description: product.description,
        specs: product.specs,
        priceHistory: product.priceHistory,
        platforms: updatedPlatforms,
        tags: product.tags,
      );
    }).toList();
    _isRefreshing = false;
    _lastUpdated = DateTime.now();
    _applyFilters();
  }
}
