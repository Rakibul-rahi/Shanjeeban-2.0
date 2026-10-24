import 'package:flutter/material.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _logoFade;
  late final Animation<Offset> _logoSlide;
  late final Animation<double> _titleFade;
  late final Animation<double> _dividerScale;
  late final Animation<double> _taglineFade;
  late final Animation<double> _buttonsFade;
  late final Animation<Offset> _buttonsSlide;

  static const Color background = Color(0xFF2C1B36);
  static const Color backgroundDeep = Color(0xFF1B0F22);
  static const Color gold = Color(0xFFD9A659);
  static const Color blush = Color(0xFFF3D9D0);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _logoFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.45, curve: Curves.easeOut),
    );
    _logoSlide = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.45, curve: Curves.easeOutCubic),
    ));

    _titleFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.25, 0.6, curve: Curves.easeOut),
    );

    _dividerScale = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 0.7, curve: Curves.easeOutCubic),
    );

    _taglineFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.55, 0.85, curve: Curves.easeOut),
    );

    _buttonsFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.7, 1.0, curve: Curves.easeOut),
    );
    _buttonsSlide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.7, 1.0, curve: Curves.easeOutCubic),
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigate(String route) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.3),
            radius: 1.3,
            colors: [background, backgroundDeep],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Faint ambient corner glow for depth
              Positioned(
                top: -80,
                right: -60,
                child: _GlowCircle(color: gold.withValues(alpha: 0.06), size: 260),
              ),
              Positioned(
                bottom: -100,
                left: -80,
                child: _GlowCircle(color: blush.withValues(alpha: 0.05), size: 280),
              ),
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FadeTransition(
                        opacity: _logoFade,
                        child: SlideTransition(
                          position: _logoSlide,
                          child: Container(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: gold.withValues(alpha: 0.35),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: gold.withValues(alpha: 0.12),
                                  blurRadius: 30,
                                  spreadRadius: 4,
                                ),
                              ],
                            ),
                            child: Image.asset(
                              'assetsSadik/logo.png',
                              width: 86,
                              height: 86,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      FadeTransition(
                        opacity: _titleFade,
                        child: ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [blush, gold],
                          ).createShader(bounds),
                          child: const Text(
                            'SHANJEEBAN',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 32,
                              letterSpacing: 6,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      ScaleTransition(
                        scale: _dividerScale,
                        child: const _OrnamentDivider(
                          color: gold,
                        ),
                      ),
                      const SizedBox(height: 18),
                      FadeTransition(
                        opacity: _taglineFade,
                        child: Text(
                          'GIVE THE GIFT OF LIFE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: blush.withValues(alpha: 0.85),
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            letterSpacing: 3,
                          ),
                        ),
                      ),
                      const SizedBox(height: 64),
                      FadeTransition(
                        opacity: _buttonsFade,
                        child: SlideTransition(
                          position: _buttonsSlide,
                          child: Column(
                            children: [
                              _PremiumButton(
                                label: 'LOG IN',
                                filled: true,
                                gold: gold,
                                onTap: () => _navigate('/loginPage'),
                              ),
                              const SizedBox(height: 16),
                              _PremiumButton(
                                label: 'SIGN UP',
                                filled: false,
                                gold: gold,
                                onTap: () => _navigate('/signUpPage'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  final Color color;
  final double size;

  const _GlowCircle({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, color.withValues(alpha: 0)],
        ),
      ),
    );
  }
}

class _OrnamentDivider extends StatelessWidget {
  final Color color;

  const _OrnamentDivider({required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _line(color),
        const SizedBox(width: 10),
        Transform.rotate(
          angle: 0.785398, // 45 degrees
          child: Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(1.5),
            ),
          ),
        ),
        const SizedBox(width: 10),
        _line(color),
      ],
    );
  }

  Widget _line(Color color) {
    return Container(
      width: 56,
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0), color.withValues(alpha: 0.6)],
        ),
      ),
    );
  }
}

class _PremiumButton extends StatefulWidget {
  final String label;
  final bool filled;
  final Color gold;
  final VoidCallback onTap;

  const _PremiumButton({
    required this.label,
    required this.filled,
    required this.gold,
    required this.onTap,
  });

  @override
  State<_PremiumButton> createState() => _PremiumButtonState();
}

class _PremiumButtonState extends State<_PremiumButton> {
  bool _pressed = false;
  bool _loading = false;

  Future<void> _handleTap() async {
    if (_loading) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 650));
    if (!mounted) return;
    widget.onTap();
    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: _handleTap,
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: Container(
          width: 240,
          height: 52,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: widget.filled
                ? LinearGradient(
              colors: [widget.gold, const Color(0xFFC4894A)],
            )
                : null,
            border: widget.filled
                ? null
                : Border.all(color: widget.gold.withValues(alpha: 0.7), width: 1.2),
            color: widget.filled ? null : Colors.white.withValues(alpha: 0.03),
            boxShadow: widget.filled
                ? [
              BoxShadow(
                color: widget.gold.withValues(alpha: 0.35),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ]
                : null,
          ),
          child: _loading
              ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
              : Text(
            widget.label,
            style: TextStyle(
              color: widget.filled ? Colors.white : widget.gold,
              fontWeight: FontWeight.w600,
              fontSize: 14,
              letterSpacing: 2.5,
            ),
          ),
        ),
      ),
    );
  }
}