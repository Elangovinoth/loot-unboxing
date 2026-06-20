import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/app_state.dart';
import '../utils/theme.dart';
import '../widgets/product_card.dart';
import '../services/mock_data.dart';
import 'product_detail_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: state.refresh,
        color: AppColors.teal,
        backgroundColor: AppColors.surface,
        child: CustomScrollView(
          slivers: [
            // ── App Bar ───────────────────────────────────────
            SliverToBoxAdapter(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'PriceRadar',
                                style: TextStyle(
                                  color: AppColors.teal,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              Text(
                                'Live across 5 platforms',
                                style: TextStyle(
                                    color: AppColors.textMuted, fontSize: 12),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              // Margin badge
                              GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const SettingsScreen()),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 7),
                                  decoration: BoxDecoration(
                                    color: AppColors.surfaceElevated,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color:
                                            AppColors.amber.withOpacity(0.4)),
                                  ),
                                  child: Column(
                                    children: [
                                      const Text(
                                        'MARGIN',
                                        style: TextStyle(
                                          color: AppColors.amber,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                      Text(
                                        state.marginLabel,
                                        style: const TextStyle(
                                          color: AppColors.amber,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const SettingsScreen()),
                                ),
                                child: Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: AppColors.surface,
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                        Border.all(color: AppColors.border),
                                  ),
                                  child: const Icon(Icons.settings_outlined,
                                      color: AppColors.textSecondary,
                                      size: 18),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Live indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 7,
                                height: 7,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: state.isRefreshing
                                      ? AppColors.amber
                                      : AppColors.teal,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                state.isRefreshing
                                    ? 'Refreshing...'
                                    : 'Live prices',
                                style: TextStyle(
                                  color: state.isRefreshing
                                      ? AppColors.amber
                                      : AppColors.teal,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            _formatTime(state.lastUpdated),
                            style: const TextStyle(
                                color: AppColors.textMuted, fontSize: 11),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Search bar
                      TextField(
                        onChanged: state.setSearch,
                        style: const TextStyle(
                            color: AppColors.textPrimary, fontSize: 15),
                        decoration: InputDecoration(
                          hintText: 'Search products, brands...',
                          prefixIcon: const Icon(Icons.search_rounded,
                              color: AppColors.textMuted, size: 20),
                          suffixIcon: state.searchQuery.isNotEmpty
                              ? GestureDetector(
                                  onTap: () => state.setSearch(''),
                                  child: const Icon(Icons.close,
                                      color: AppColors.textMuted, size: 18),
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Category pills
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children:
                              MockDataService.categories.map((cat) {
                            final selected =
                                state.selectedCategory == cat['id'];
                            return GestureDetector(
                              onTap: () => state.setCategory(cat['id']!),
                              child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 8),
                                decoration: BoxDecoration(
                                  color: selected
                                      ? AppColors.tealDim
                                      : AppColors.surface,
                                  borderRadius: BorderRadius.circular(99),
                                  border: Border.all(
                                    color: selected
                                        ? AppColors.teal.withOpacity(0.4)
                                        : AppColors.border,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(cat['emoji']!,
                                        style: const TextStyle(fontSize: 13)),
                                    const SizedBox(width: 5),
                                    Text(
                                      cat['name']!,
                                      style: TextStyle(
                                        color: selected
                                            ? AppColors.teal
                                            : AppColors.textSecondary,
                                        fontSize: 13,
                                        fontWeight: selected
                                            ? FontWeight.w700
                                            : FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Results count
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${state.filtered.length} product${state.filtered.length != 1 ? 's' : ''}',
                            style: const TextStyle(
                                color: AppColors.textSecondary, fontSize: 13),
                          ),
                          const Text(
                            'Best price first',
                            style: TextStyle(
                                color: AppColors.textMuted, fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),

            // ── Product List ──────────────────────────────────
            state.filtered.isEmpty
                ? SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('🔍',
                              style: TextStyle(fontSize: 48)),
                          const SizedBox(height: 12),
                          const Text(
                            'No products found',
                            style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Try a different search or category',
                            style: TextStyle(
                                color: AppColors.textMuted, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, i) {
                        final product = state.filtered[i];
                        return ProductCard(
                          product: product,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ProductDetailScreen(product: product),
                            ),
                          ),
                        );
                      },
                      childCount: state.filtered.length,
                    ),
                  ),

            const SliverToBoxAdapter(child: SizedBox(height: 90)),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final diff = DateTime.now().difference(dt).inSeconds;
    if (diff < 60) return 'just now';
    if (diff < 3600) return '${diff ~/ 60}m ago';
    return '${dt.hour}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
