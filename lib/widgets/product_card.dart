import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../services/app_state.dart';
import '../utils/theme.dart';
import 'common_widgets.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final bestPrice = product.bestPrice;
    final margin = state.effectiveMargin(bestPrice);
    final inWatchlist = state.inWatchlist(product.id);

    final sortedPlatforms = [...product.platforms]
      ..sort((a, b) => a.price.compareTo(b.price));

    final withinMarginCount =
        product.platforms.where((p) => (p.price - bestPrice) <= margin).length;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // ── Header ─────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: product.image,
                      width: 88,
                      height: 88,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(
                        width: 88,
                        height: 88,
                        color: AppColors.surfaceElevated,
                      ),
                      errorWidget: (_, __, ___) => Container(
                        width: 88,
                        height: 88,
                        color: AppColors.surfaceElevated,
                        child: const Icon(Icons.image_not_supported,
                            color: AppColors.textMuted),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tags
                        if (product.tags.isNotEmpty)
                          Wrap(
                            spacing: 4,
                            runSpacing: 4,
                            children: [
                              if (product.tags.contains('deal'))
                                const DealTag(type: DealTagType.best),
                              if (product.tags.contains('bestseller'))
                                const DealTag(type: DealTagType.quality),
                              if (product.tags.contains('trending'))
                                const DealTag(type: DealTagType.worth),
                            ],
                          ),
                        const SizedBox(height: 4),
                        Text(
                          product.brand.toUpperCase(),
                          style: const TextStyle(
                            color: AppColors.teal,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          product.name,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          product.description,
                          style: const TextStyle(
                              color: AppColors.textMuted, fontSize: 11),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Text(
                              formatPrice(bestPrice),
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(width: 6),
                            if (product.discountPercent > 0)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.greenDim,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '${product.discountPercent}% off',
                                  style: const TextStyle(
                                    color: AppColors.green,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Watchlist
                  GestureDetector(
                    onTap: () => state.toggleWatchlist(product.id),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        inWatchlist ? Icons.favorite : Icons.favorite_border,
                        color: inWatchlist ? AppColors.red : AppColors.textMuted,
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Platform Chips ─────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 10),
              child: Row(
                children: sortedPlatforms.map((p) {
                  final isBest = p.price == bestPrice;
                  final inRange = (p.price - bestPrice) <= margin;
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 6),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isBest
                            ? AppColors.tealDim
                            : inRange
                                ? AppColors.amberDim
                                : AppColors.surfaceElevated,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isBest
                              ? AppColors.teal.withOpacity(0.4)
                              : inRange
                                  ? AppColors.amber.withOpacity(0.3)
                                  : AppColors.border,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p.name,
                            style: TextStyle(
                              color: p.color,
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            formatPrice(p.price),
                            style: TextStyle(
                              color: isBest
                                  ? AppColors.teal
                                  : AppColors.textPrimary,
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 2),
                          RatingStars(rating: p.rating, size: 9),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // ── Footer ─────────────────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: const BoxDecoration(
                color: AppColors.surfaceElevated,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(16)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$withinMarginCount platform${withinMarginCount != 1 ? 's' : ''} within margin',
                    style: const TextStyle(
                        color: AppColors.textMuted, fontSize: 11),
                  ),
                  Row(
                    children: [
                      Text(
                        'Best: ${product.bestPlatform.name}',
                        style: const TextStyle(
                            color: AppColors.teal,
                            fontSize: 11,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.chevron_right,
                          color: AppColors.teal, size: 16),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
