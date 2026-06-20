import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/product.dart';
import '../services/app_state.dart';
import '../utils/theme.dart';
import '../widgets/common_widgets.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final product = widget.product;
    final bestPrice = product.bestPrice;
    final margin = state.effectiveMargin(bestPrice);
    final inWatchlist = state.inWatchlist(product.id);

    final sortedPlatforms = [...product.platforms]
      ..sort((a, b) => a.price.compareTo(b.price));

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            backgroundColor: AppColors.background,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: AppColors.teal, size: 16),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () => state.toggleWatchlist(product.id),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Icon(
                    inWatchlist ? Icons.favorite : Icons.favorite_border,
                    color: inWatchlist ? AppColors.red : AppColors.textMuted,
                    size: 20,
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: product.image,
                    fit: BoxFit.cover,
                    placeholder: (_, __) =>
                        Container(color: AppColors.surfaceElevated),
                    errorWidget: (_, __, ___) =>
                        Container(color: AppColors.surfaceElevated),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          AppColors.background.withOpacity(0.95),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.brand.toUpperCase(),
                          style: const TextStyle(
                              color: AppColors.teal,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          product.name,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.tealDim,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: AppColors.teal.withOpacity(0.3)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'BEST PRICE',
                                    style: TextStyle(
                                      color: AppColors.teal,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  Text(
                                    formatPrice(bestPrice),
                                    style: const TextStyle(
                                      color: AppColors.teal,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 12),
                              if (product.discountPercent > 0)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: AppColors.greenDim,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '${product.discountPercent}%\nOFF',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: AppColors.green,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800,
                                      height: 1.2,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottom: TabBar(
              controller: _tabs,
              indicatorColor: AppColors.teal,
              labelColor: AppColors.teal,
              unselectedLabelColor: AppColors.textMuted,
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle:
                  const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
              tabs: const [
                Tab(text: 'Compare'),
                Tab(text: 'History'),
                Tab(text: 'Details'),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabs,
          children: [
            // ── Compare Tab ───────────────────────────────────
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Margin info bar
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.amberDim,
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(color: AppColors.amber.withOpacity(0.25)),
                  ),
                  child: Text(
                    '🎯  Your margin: within ${formatPrice(margin)} of best price',
                    style: const TextStyle(
                        color: AppColors.amber,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 12),

                ...sortedPlatforms.map((p) {
                  final isBest = p.price == bestPrice;
                  final priceDiff = p.price - bestPrice;
                  final inRange = priceDiff <= margin;
                  final score = dealScore(p, bestPrice, margin);

                  DealTagType? tagType;
                  if (isBest) {
                    tagType = DealTagType.best;
                  } else if (inRange && p.rating >= 4.2) {
                    tagType = DealTagType.worth;
                  } else if (inRange) {
                    tagType = DealTagType.margin;
                  } else if (p.rating < 3.8) {
                    tagType = DealTagType.risky;
                  }

                  return GestureDetector(
                    onTap: () async {
                      if (p.inStock) {
                        final uri = Uri.parse(p.url);
                        if (await canLaunchUrl(uri)) launchUrl(uri);
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isBest
                            ? AppColors.tealDim
                            : inRange
                                ? AppColors.amberDim
                                : AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isBest
                              ? AppColors.teal.withOpacity(0.4)
                              : inRange
                                  ? AppColors.amber.withOpacity(0.3)
                                  : AppColors.border,
                        ),
                      ),
                      child: Row(
                        children: [
                          // Platform info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: p.color,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      p.name,
                                      style: TextStyle(
                                        color: p.color,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    if (tagType != null) ...[
                                      const SizedBox(width: 6),
                                      DealTag(type: tagType),
                                    ],
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Text(
                                      formatPrice(p.price),
                                      style: TextStyle(
                                        color: isBest
                                            ? AppColors.teal
                                            : AppColors.textPrimary,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    if (priceDiff > 0) ...[
                                      const SizedBox(width: 6),
                                      Text(
                                        '+${formatPrice(priceDiff)}',
                                        style: const TextStyle(
                                            color: AppColors.red,
                                            fontSize: 11),
                                      ),
                                    ],
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    RatingStars(
                                        rating: p.rating, size: 12),
                                    const SizedBox(width: 4),
                                    Text(
                                      '(${p.reviews})',
                                      style: const TextStyle(
                                          color: AppColors.textMuted,
                                          fontSize: 10),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '🚚 ${p.delivery}',
                                      style: const TextStyle(
                                          color: AppColors.textSecondary,
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                                if (!p.inStock)
                                  const Padding(
                                    padding: EdgeInsets.only(top: 4),
                                    child: Text(
                                      'Out of stock',
                                      style: TextStyle(
                                          color: AppColors.red,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          // Score + CTA
                          Column(
                            children: [
                              ScoreRing(score: score),
                              const SizedBox(height: 6),
                              Text(
                                p.inStock ? 'Buy →' : 'N/A',
                                style: TextStyle(
                                  color: p.inStock
                                      ? AppColors.teal
                                      : AppColors.textMuted,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),

                // Score legend
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceElevated,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'SCORE FORMULA',
                        style: TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Rating (40%) + Price rank (40%) + Delivery speed (20%)',
                        style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                            height: 1.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // ── History Tab ───────────────────────────────────
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const SectionHeader(title: 'Price History'),
                _buildChart(product),
                const SizedBox(height: 16),
                _buildPriceStats(product, bestPrice),
              ],
            ),

            // ── Details Tab ───────────────────────────────────
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const SectionHeader(title: 'Specifications'),
                ...product.specs.map(
                  (spec) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.teal),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          spec,
                          style: const TextStyle(
                              color: AppColors.textSecondary, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const SectionHeader(title: 'Description'),
                Text(
                  product.description,
                  style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                      height: 1.6),
                ),
                const SizedBox(height: 20),
                const SectionHeader(title: 'Specs Tags'),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children:
                      product.specs.map((s) => SpecChip(label: s)).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChart(Product product) {
    final history = product.priceHistory;
    final prices = history.map((h) => h.price).toList();
    final minP = prices.reduce((a, b) => a < b ? a : b);
    final maxP = prices.reduce((a, b) => a > b ? a : b);

    return Container(
      height: 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: LineChart(
        LineChartData(
          minY: minP * 0.95,
          maxY: maxP * 1.05,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (_) => FlLine(
              color: AppColors.border,
              strokeWidth: 1,
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 60,
                getTitlesWidget: (val, _) => Text(
                  '₹${(val / 1000).toStringAsFixed(0)}k',
                  style: const TextStyle(
                      color: AppColors.textMuted, fontSize: 10),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (val, _) {
                  final i = val.toInt();
                  if (i < 0 || i >= history.length) return const SizedBox();
                  final d = history[i].date;
                  return Text(
                    '${_monthName(d.month)} ${d.day}',
                    style: const TextStyle(
                        color: AppColors.textMuted, fontSize: 8),
                  );
                },
              ),
            ),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: history
                  .asMap()
                  .entries
                  .map((e) => FlSpot(e.key.toDouble(), e.value.price))
                  .toList(),
              isCurved: true,
              color: AppColors.teal,
              barWidth: 2.5,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, _, __, ___) => FlDotCirclePainter(
                  radius: 3,
                  color: spot.y == minP ? AppColors.teal : AppColors.surface,
                  strokeWidth: 2,
                  strokeColor: AppColors.teal,
                ),
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.teal.withOpacity(0.2),
                    AppColors.teal.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceStats(Product product, double bestPrice) {
    final stats = [
      ('ALL-TIME LOW', formatPrice(product.allTimeLow), AppColors.teal),
      ('ALL-TIME HIGH', formatPrice(product.allTimeHigh), AppColors.red),
      ('YOU SAVE', formatPrice(product.allTimeHigh - bestPrice), AppColors.green),
    ];
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: stats.asMap().entries.map((e) {
          final (label, value, color) = e.value;
          return Expanded(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                border: Border(
                  right: e.key < stats.length - 1
                      ? const BorderSide(color: AppColors.border)
                      : BorderSide.none,
                ),
              ),
              child: Column(
                children: [
                  Text(label,
                      style: const TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8)),
                  const SizedBox(height: 4),
                  Text(value,
                      style: TextStyle(
                          color: color,
                          fontSize: 13,
                          fontWeight: FontWeight.w800)),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  String _monthName(int m) {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[m];
  }
}
