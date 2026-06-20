import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/app_state.dart';
import '../utils/theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool _isPercent;
  late double _fixedMargin;
  late double _pctMargin;
  bool _notifications = true;
  bool _autoRefresh = true;

  final _fixedPresets = [500.0, 1000.0, 2000.0, 5000.0];
  final _pctPresets = [3.0, 5.0, 10.0, 15.0];

  @override
  void initState() {
    super.initState();
    final state = context.read<AppState>();
    _isPercent = state.isPercentage;
    _fixedMargin = state.margin;
    _pctMargin = state.marginPercent;
  }

  void _save() {
    context.read<AppState>().setMargin(
          _fixedMargin,
          isPercent: _isPercent,
          percent: _pctMargin,
        );
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Settings saved'),
        backgroundColor: AppColors.teal,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings',
            style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w700)),
        actions: [
          GestureDetector(
            onTap: _save,
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.teal,
                borderRadius: BorderRadius.circular(99),
              ),
              child: const Text(
                'Save',
                style: TextStyle(
                    color: AppColors.textInverse,
                    fontWeight: FontWeight.w700,
                    fontSize: 13),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Margin Section ──────────────────────────────────
          _sectionCard([
            _sectionLabel('PRICE MARGIN'),
            const SizedBox(height: 4),
            const Text(
              'Show platforms within this margin of the best price.',
              style: TextStyle(color: AppColors.textMuted, fontSize: 13),
            ),
            const SizedBox(height: 16),

            // Mode toggle
            Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  _modeBtn('Fixed (₹)', !_isPercent,
                      () => setState(() => _isPercent = false)),
                  _modeBtn('Percentage (%)', _isPercent,
                      () => setState(() => _isPercent = true)),
                ],
              ),
            ),
            const SizedBox(height: 16),

            if (!_isPercent) ...[
              const Text('Margin Amount',
                  style: TextStyle(
                      color: AppColors.textSecondary, fontSize: 12)),
              const SizedBox(height: 8),
              _valueDisplay('₹${_fixedMargin.toInt()}'),
              const SizedBox(height: 10),
              Slider(
                value: _fixedMargin,
                min: 100,
                max: 10000,
                divisions: 99,
                activeColor: AppColors.teal,
                inactiveColor: AppColors.border,
                onChanged: (v) => setState(() => _fixedMargin = v),
              ),
              Wrap(
                spacing: 8,
                children: _fixedPresets
                    .map((p) => _preset('₹${p.toInt()}',
                        _fixedMargin == p, () => setState(() => _fixedMargin = p)))
                    .toList(),
              ),
              const SizedBox(height: 12),
              _exampleBox(
                  'Best price ₹10,000 → Show platforms up to ₹${(10000 + _fixedMargin).toInt()}'),
            ] else ...[
              const Text('Margin Percentage',
                  style: TextStyle(
                      color: AppColors.textSecondary, fontSize: 12)),
              const SizedBox(height: 8),
              _valueDisplay('${_pctMargin.toStringAsFixed(0)}%'),
              const SizedBox(height: 10),
              Slider(
                value: _pctMargin,
                min: 1,
                max: 20,
                divisions: 19,
                activeColor: AppColors.teal,
                inactiveColor: AppColors.border,
                onChanged: (v) => setState(() => _pctMargin = v),
              ),
              Wrap(
                spacing: 8,
                children: _pctPresets
                    .map((p) => _preset('${p.toInt()}%', _pctMargin == p,
                        () => setState(() => _pctMargin = p)))
                    .toList(),
              ),
              const SizedBox(height: 12),
              _exampleBox(
                  'Best price ₹10,000 → Show platforms up to ₹${(10000 * (1 + _pctMargin / 100)).toInt()}'),
            ],
          ]),
          const SizedBox(height: 12),

          // ── Tag Legend ──────────────────────────────────────
          _sectionCard([
            _sectionLabel('HOW WE HIGHLIGHT'),
            const SizedBox(height: 12),
            ...[
              (AppColors.teal, 'BEST PRICE', 'Lowest price across all platforms'),
              (AppColors.amber, 'IN YOUR RANGE', 'Within your margin of best price'),
              (AppColors.purple, 'WORTH IT', 'Slightly higher but top rated + fast delivery'),
              (AppColors.green, 'TOP RATED', 'Highest rated product in its category'),
              (AppColors.red, 'LOW RATING', 'Rating below 3.8 — proceed with caution'),
            ].map((e) {
              final (color, label, desc) = e;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: color)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(label,
                              style: TextStyle(
                                  color: color,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.8)),
                          Text(desc,
                              style: const TextStyle(
                                  color: AppColors.textMuted,
                                  fontSize: 12,
                                  height: 1.4)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ]),
          const SizedBox(height: 12),

          // ── Preferences ─────────────────────────────────────
          _sectionCard([
            _sectionLabel('PREFERENCES'),
            const SizedBox(height: 12),
            _toggleRow('Price drop notifications',
                'Alert when watchlisted items drop', _notifications,
                (v) => setState(() => _notifications = v)),
            const Divider(color: AppColors.border, height: 20),
            _toggleRow('Auto-refresh prices',
                'Update prices every 15 minutes', _autoRefresh,
                (v) => setState(() => _autoRefresh = v)),
          ]),
          const SizedBox(height: 12),

          // ── About ────────────────────────────────────────────
          _sectionCard([
            _sectionLabel('ABOUT'),
            const SizedBox(height: 8),
            const Text('PriceRadar v1.0.0',
                style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            const Text(
              'Tracks prices across Amazon, Flipkart, Meesho, Snapdeal & Myntra.\n\nAffiliate disclosure: Links may earn a commission at no extra cost to you.',
              style: TextStyle(
                  color: AppColors.textMuted, fontSize: 13, height: 1.6),
            ),
          ]),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _sectionCard(List<Widget> children) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: children),
      );

  Widget _sectionLabel(String text) => Text(
        text,
        style: const TextStyle(
            color: AppColors.teal,
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2),
      );

  Widget _modeBtn(String label, bool active, VoidCallback onTap) =>
      Expanded(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: active ? AppColors.teal : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: active ? AppColors.textInverse : AppColors.textMuted,
                fontSize: 13,
                fontWeight: active ? FontWeight.w700 : FontWeight.w400,
              ),
            ),
          ),
        ),
      );

  Widget _valueDisplay(String val) => Center(
        child: Text(
          val,
          style: const TextStyle(
              color: AppColors.teal,
              fontSize: 32,
              fontWeight: FontWeight.w800,
              letterSpacing: -1),
        ),
      );

  Widget _preset(String label, bool active, VoidCallback onTap) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: active ? AppColors.tealDim : AppColors.surfaceElevated,
            borderRadius: BorderRadius.circular(99),
            border: Border.all(
                color: active
                    ? AppColors.teal.withOpacity(0.4)
                    : AppColors.border),
          ),
          child: Text(
            label,
            style: TextStyle(
                color: active ? AppColors.teal : AppColors.textSecondary,
                fontSize: 13,
                fontWeight: active ? FontWeight.w700 : FontWeight.w400),
          ),
        ),
      );

  Widget _exampleBox(String text) => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(8),
          border: const Border(
              left: BorderSide(color: AppColors.teal, width: 3)),
        ),
        child: Text(text,
            style: const TextStyle(
                color: AppColors.textSecondary, fontSize: 12, height: 1.5)),
      );

  Widget _toggleRow(
          String label, String desc, bool value, ValueChanged<bool> onChange) =>
      Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(desc,
                    style: const TextStyle(
                        color: AppColors.textMuted, fontSize: 12)),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChange,
            activeColor: AppColors.teal,
            activeTrackColor: AppColors.tealMid,
            inactiveTrackColor: AppColors.border,
            inactiveThumbColor: AppColors.textMuted,
          ),
        ],
      );
}
