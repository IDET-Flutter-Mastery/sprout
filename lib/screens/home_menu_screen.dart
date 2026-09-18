import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../widgets/icon_badge.dart';
import '../widgets/staggered_fade_in.dart';
import 'counter_challenge_screen.dart';
import 'legacy_plant_screen.dart';
import 'plant_list_screen.dart';

/// -----------------------------------------------------------------------
/// HomeMenuScreen — DONE, no edits needed.
/// -----------------------------------------------------------------------
/// A simple menu so every checkpoint's screen is reachable independently
/// while you build them out one at a time.
/// -----------------------------------------------------------------------
class HomeMenuScreen extends StatelessWidget {
  const HomeMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: AppColors.background,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: AppSpacing.lg, bottom: AppSpacing.md),
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/sprout_logo.png', width: 28, height: 28),
                  const SizedBox(width: AppSpacing.sm),
                  Text('Sprout', style: AppTypography.headline),
                ],
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset('assets/images/garden_banner.png', fit: BoxFit.cover),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, AppColors.background.withOpacity(0.92)],
                        stops: const [0.4, 1],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.xl),
            sliver: SliverList.list(
              children: [
                Text(
                  'A little state-management lab, one checkpoint at a time.',
                  style: AppTypography.bodyMuted,
                ),
                const SizedBox(height: AppSpacing.lg),
                StaggeredFadeIn(
                  index: 0,
                  child: _MenuTile(
                    title: 'Classic (setState)',
                    subtitle: 'Sections 1–2 · CP1',
                    icon: Icons.history_rounded,
                    color: AppColors.clayDeep,
                    background: AppColors.claySoft,
                    onTap: () => Navigator.push(
                      context,
                      _buildRoute(const LegacyPlantScreen()),
                    ),
                  ),
                ),
                StaggeredFadeIn(
                  index: 1,
                  child: _MenuTile(
                    title: 'Sprout (Riverpod)',
                    subtitle: 'Section 3 · CP2–CP4',
                    icon: Icons.eco_rounded,
                    color: AppColors.leafDeep,
                    background: AppColors.leafSoft,
                    onTap: () => Navigator.push(
                      context,
                      _buildRoute(const PlantListScreen()),
                    ),
                  ),
                ),
                StaggeredFadeIn(
                  index: 2,
                  child: _MenuTile(
                    title: 'Quick Challenge · Counter',
                    subtitle: 'Section 3',
                    icon: Icons.exposure_plus_1_rounded,
                    color: AppColors.sunDeep,
                    background: AppColors.sunSoft,
                    onTap: () => Navigator.push(
                      context,
                      _buildRoute(const CounterChallengeScreen()),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Route _buildRoute(Widget screen) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 320),
      pageBuilder: (_, animation, __) => screen,
      transitionsBuilder: (_, animation, __, child) {
        final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween(begin: const Offset(0, 0.04), end: Offset.zero).animate(curved),
            child: child,
          ),
        );
      },
    );
  }
}

class _MenuTile extends StatefulWidget {
  const _MenuTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.background,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Color background;
  final VoidCallback onTap;

  @override
  State<_MenuTile> createState() => _MenuTileState();
}

class _MenuTileState extends State<_MenuTile> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: AnimatedScale(
        scale: _pressed ? 0.98 : 1,
        duration: const Duration(milliseconds: 120),
        child: Material(
          color: AppColors.lineSoft,
          borderRadius: BorderRadius.circular(18),
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTapDown: (_) => setState(() => _pressed = true),
            onTapCancel: () => setState(() => _pressed = false),
            onTapUp: (_) => setState(() => _pressed = false),
            onTap: widget.onTap,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  IconBadge(icon: widget.icon, color: widget.color, background: widget.background),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.title, style: AppTypography.title),
                        const SizedBox(height: 2),
                        Text(widget.subtitle, style: AppTypography.caption),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right_rounded, color: AppColors.faint),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
