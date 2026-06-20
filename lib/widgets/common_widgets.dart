import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../utils/theme.dart';
import '../models/product.dart';

// ── Platform Badge ──────────────────────────────────────────────
class PlatformBadge extends StatelessWidget {
  final PlatformData platform;
  final bool small;
  const PlatformBadge({super.key, required this.platform, this.small = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: small ? 7 : 10, vertical: small ? 2 : 4),
      decoration: BoxDecoration(
        color: platform.color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: platform.color.withOpacity(0.35)),
      ),
      child: Text(
        platform.name,
        style: TextStyle(
          color: platform.color,
          fontSize: small ? 9 : 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

// ── Deal Tag ────────────────────────────────────────────────────
enum DealTagType { best, margin, quality, risky, worth }

class DealTag extends StatelessWidget {
  final DealTagType type;
  const DealTag({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final configs = {
      DealTagType.best: ('BEST PRICE', AppColors.tealDim, AppColors.teal),
      DealTagType.margin: ('IN YOUR RANGE', AppColors.amberDim, AppColors.amber),
      DealTagType.quality: ('TOP RATED', AppColors.greenDim, AppColors.green),
      DealTagType.risky: ('LOW RATING', AppColors.redDim, AppColors.red),
      DealTagType.worth: ('WORTH IT', AppColors.purpleDim, AppColors.purple),
    };
    final (label, bg, fg) = configs[type]!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: fg.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: fg,
          fontSize: 9,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

// ── Score Ring ──────────────────────────────────────────────────
class ScoreRing extends StatelessWidget {
  final int score;
  const ScoreRing({super.key, required this.score});

  Color get _color => score >= 80
      ? AppColors.teal
      : score >= 60
          ? AppColors.amber
          : AppColors.red;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: _color, width: 2),
      ),
      child: Center(
        child: Text(
          '$score',
          style: TextStyle(
            color: _color,
            fontSize: 13,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

// ── Price Display ───────────────────────────────────────────────
class PriceDisplay extends StatelessWidget {
  final double price;
  final double? originalPrice;
  final double fontSize;
  const PriceDisplay(
      {super.key, required this.price, this.originalPrice, this.fontSize = 22});

  String _fmt(double p) =>
      '₹${p.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{2})+\d$)'), (m) => '${m[1]},')}';

  @override
  Widget build(BuildContext context) {
    final discount = originalPrice != null
        ? ((originalPrice! - price) / originalPrice! * 100).round()
        : 0;
    return Row(
      children: [
        Text(
          _fmt(price),
          style: TextStyle(
            color: AppColors.teal,
            fontSize: fontSize,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        if (discount > 0) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.greenDim,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '$discount% OFF',
              style: const TextStyle(
                color: AppColors.green,
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// ── Rating Stars ────────────────────────────────────────────────
class RatingStars extends StatelessWidget {
  final double rating;
  final double size;
  const RatingStars({super.key, required this.rating, this.size = 12});

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      itemBuilder: (_, __) =>
          const Icon(Icons.star_rounded, color: AppColors.amber),
      itemCount: 5,
      itemSize: size,
      unratedColor: AppColors.border,
    );
  }
}

// ── Section Header ──────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ── Spec Chip ───────────────────────────────────────────────────
class SpecChip extends StatelessWidget {
  final String label;
  const SpecChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// ── Format price helper ─────────────────────────────────────────
String formatPrice(double price) {
  final str = price.toStringAsFixed(0);
  final result = StringBuffer();
  final len = str.length;
  for (int i = 0; i < len; i++) {
    if (i == len - 3 && len > 3) result.write(',');
    if (i > 3 && (len - i) % 2 == 0 && i != len - 3) result.write(',');
    result.write(str[i]);
  }
  return '₹$result';
}

int dealScore(PlatformData p, double bestPrice, double margin) {
  final inRange = (p.price - bestPrice) <= margin;
  final ratingScore = p.rating / 5;
  final deliveryScore = p.delivery.contains('1')
      ? 1.0
      : p.delivery.contains('2')
          ? 0.9
          : p.delivery.contains('3')
              ? 0.75
              : 0.5;
  return ((ratingScore * 0.4 + (inRange ? 0.4 : 0.1) + deliveryScore * 0.2) *
          100)
      .round();
}
