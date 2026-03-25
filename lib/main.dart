import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const FitBookApp());
}

// ─────────────────────────────────────────
// COLORS
// ─────────────────────────────────────────
class C {
  static const bg = Color(0xFFF2F3F7);
  static const bgLight = Color(0xFFF8F9FC);
  static const card = Color(0xFFFFFFFF);
  static const accent = Color(0xFF5DCAA5);
  static const accentDark = Color(0xFF2a8a65);
  static const accentLight = Color(0xFFEEF9F5);
  static const text = Color(0xFF1a1c2e);
  static const textSub = Color(0xFF8890A8);
  static const textMuted = Color(0xFFB8BDD0);
  static const divider = Color(0xFFE8ECF4);
  static const neuBg = Color(0xFFEAEDF5);
  static const shell = Color(0xFF1a1a24);
}

// ─────────────────────────────────────────
// APP
// ─────────────────────────────────────────
class FitBookApp extends StatelessWidget {
  const FitBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitBook',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: C.bg,
        fontFamily: 'SF Pro Display',
        colorScheme: ColorScheme.light(
          primary: C.accent,
          surface: C.card,
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      home: const OnboardingScreen(),
    );
  }
}

// ─────────────────────────────────────────
// WIDGETS
// ─────────────────────────────────────────

// Neumorphic container (raised)
class NeuCard extends StatelessWidget {
  final Widget child;
  final double radius;
  final EdgeInsets padding;
  final Color? color;

  const NeuCard({
    super.key,
    required this.child,
    this.radius = 20,
    this.padding = const EdgeInsets.all(16),
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? C.card,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB4BEDc).withOpacity(0.45),
            offset: const Offset(5, 5),
            blurRadius: 14,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.9),
            offset: const Offset(-2, -2),
            blurRadius: 6,
          ),
        ],
      ),
      child: child,
    );
  }
}

// Neumorphic container (inset / pressed)
class NeuInset extends StatelessWidget {
  final Widget child;
  final double radius;
  final EdgeInsets padding;

  const NeuInset({
    super.key,
    required this.child,
    this.radius = 16,
    this.padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: C.neuBg,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB4BEDC).withOpacity(0.4),
            offset: const Offset(2, 2),
            blurRadius: 5,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.8),
            offset: const Offset(-1, -1),
            blurRadius: 3,
          ),
        ],
      ),
      child: child,
    );
  }
}

// Primary gradient button
class GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final double height;

  const GradientButton({
    super.key,
    required this.label,
    required this.onTap,
    this.height = 54,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(
            colors: [C.accent, C.accentDark],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: C.accent.withOpacity(0.35),
              offset: const Offset(0, 6),
              blurRadius: 20,
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

// Ghost button
class GhostButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const GhostButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: NeuInset(
        radius: 18,
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: C.textSub,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

// Trainer avatar
class TrainerAvatar extends StatelessWidget {
  final String initials;
  final List<Color> colors;
  final double size;

  const TrainerAvatar({
    super.key,
    required this.initials,
    required this.colors,
    this.size = 46,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.33),
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.first.withOpacity(0.35),
            offset: const Offset(3, 3),
            blurRadius: 10,
          ),
        ],
      ),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            fontSize: size * 0.3,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
// ONBOARDING SCREEN
// ─────────────────────────────────────────
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  int _active = 0;
  late AnimationController _ctrl;
  late Animation<double> _fade;

  final _slides = [
    {'icon': '✓', 'title': 'Book', 'desc': 'Pick any open slot'},
    {'icon': '+', 'title': 'Train', 'desc': 'Top coaches nearby'},
    {'icon': '↑', 'title': 'Grow', 'desc': 'Track your progress'},
  ];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.bgLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: FadeTransition(
            opacity: _fade,
            child: Column(
              children: [
                const SizedBox(height: 32),

                // Logo
                NeuCard(
                  radius: 22,
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: 32,
                    height: 32,
                    child: CustomPaint(painter: _LogoPainter()),
                  ),
                ),

                const SizedBox(height: 16),

                // Brand
                Text(
                  'FITBOOK',
                  style: TextStyle(
                    fontSize: 10,
                    letterSpacing: 4,
                    color: C.accent,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 12),

                // Title
                const Text(
                  'Book your trainer\nin seconds',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: C.text,
                    height: 1.25,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Find the right coach, pick a time,\nand get moving — no back-and-forth',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: C.textSub,
                    height: 1.65,
                  ),
                ),

                const SizedBox(height: 30),

                // Slide cards
                Row(
                  children: List.generate(_slides.length, (i) {
                    final isActive = i == _active;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _active = i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOut,
                          margin: EdgeInsets.only(right: i < 2 ? 8 : 0),
                          padding: const EdgeInsets.all(13),
                          decoration: BoxDecoration(
                            color: isActive ? C.card : C.neuBg,
                            borderRadius: BorderRadius.circular(18),
                            border: isActive
                                ? Border.all(
                                    color: C.accent.withOpacity(0.3),
                                    width: 1.5,
                                  )
                                : null,
                            boxShadow: isActive
                                ? [
                                    BoxShadow(
                                      color: const Color(0xFFB4BEDC)
                                          .withOpacity(0.45),
                                      offset: const Offset(5, 5),
                                      blurRadius: 12,
                                    ),
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.9),
                                      offset: const Offset(-2, -2),
                                      blurRadius: 6,
                                    ),
                                  ]
                                : [
                                    BoxShadow(
                                      color: const Color(0xFFB4BEDC)
                                          .withOpacity(0.3),
                                      offset: const Offset(2, 2),
                                      blurRadius: 5,
                                    ),
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.8),
                                      offset: const Offset(-1, -1),
                                      blurRadius: 3,
                                    ),
                                  ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? C.accentLight
                                      : const Color(0xFFE0E4F0),
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                child: Center(
                                  child: Text(
                                    _slides[i]['icon']!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isActive
                                          ? C.accentDark
                                          : C.textMuted,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                _slides[i]['title']!,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: isActive ? C.accentDark : C.textSub,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                _slides[i]['desc']!,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: C.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 22),

                // Dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (i) {
                    final isActive = i == _active;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: isActive ? 20 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        gradient: isActive
                            ? const LinearGradient(
                                colors: [C.accent, C.accentDark],
                              )
                            : null,
                        color: isActive ? null : C.neuBg,
                      ),
                    );
                  }),
                ),

                const Spacer(),

                GradientButton(
                  label: 'Get started',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RegisterScreen(),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                GhostButton(
                  label: 'I already have an account',
                  onTap: () {},
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
// REGISTER SCREEN
// ─────────────────────────────────────────
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _role = 'trainer';
  final _name = TextEditingController(text: 'Alex Johnson');
  final _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.bgLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              // Progress bar
              Row(
                children: List.generate(4, (i) {
                  return Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 4,
                      margin: EdgeInsets.only(right: i < 3 ? 4 : 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        gradient: i < 2
                            ? const LinearGradient(
                                colors: [C.accent, C.accentDark],
                              )
                            : null,
                        color: i < 2 ? null : C.neuBg,
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 20),

              // Back
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: NeuCard(
                  radius: 12,
                  padding: const EdgeInsets.all(10),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 14,
                    color: C.textSub,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'STEP 1 OF 3',
                style: TextStyle(
                  fontSize: 10,
                  color: C.accent,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Who are you?',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: C.text,
                ),
              ),

              const SizedBox(height: 4),

              const Text(
                'Choose your role — it shapes your\nentire experience',
                style: TextStyle(
                  fontSize: 13,
                  color: C.textSub,
                  height: 1.55,
                ),
              ),

              const SizedBox(height: 20),

              // Role cards
              Row(
                children: [
                  _RoleCard(
                    title: 'Trainer',
                    desc: 'I manage my\nschedule & clients',
                    icon: Icons.fitness_center_rounded,
                    selected: _role == 'trainer',
                    onTap: () => setState(() => _role = 'trainer'),
                  ),
                  const SizedBox(width: 12),
                  _RoleCard(
                    title: 'Client',
                    desc: 'I\'m looking\nfor a coach',
                    icon: Icons.person_rounded,
                    selected: _role == 'client',
                    onTap: () => setState(() => _role = 'client'),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Fields
              _FieldLabel('FULL NAME'),
              const SizedBox(height: 6),
              _InputField(controller: _name, hint: 'Your full name', filled: true),
              const SizedBox(height: 14),
              _FieldLabel('EMAIL'),
              const SizedBox(height: 6),
              _InputField(controller: _email, hint: 'example@gmail.com'),

              const SizedBox(height: 16),

              // Divider
              Row(
                children: [
                  Expanded(child: Container(height: 1, color: C.divider)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'or',
                      style: TextStyle(fontSize: 12, color: C.textMuted),
                    ),
                  ),
                  Expanded(child: Container(height: 1, color: C.divider)),
                ],
              ),

              const SizedBox(height: 16),

              // Google
              GhostButton(
                label: 'Continue with Google',
                onTap: () {},
              ),

              const SizedBox(height: 14),

              GradientButton(
                label: 'Continue',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CatalogScreen()),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String title;
  final String desc;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _RoleCard({
    required this.title,
    required this.desc,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: selected ? C.accentLight : C.neuBg,
            borderRadius: BorderRadius.circular(20),
            border: selected
                ? Border.all(color: C.accent.withOpacity(0.4), width: 1.5)
                : null,
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: C.accent.withOpacity(0.15),
                      offset: const Offset(0, 4),
                      blurRadius: 16,
                    ),
                    BoxShadow(
                      color: const Color(0xFFB4BEDC).withOpacity(0.4),
                      offset: const Offset(4, 4),
                      blurRadius: 10,
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(0.9),
                      offset: const Offset(-2, -2),
                      blurRadius: 6,
                    ),
                  ]
                : [
                    BoxShadow(
                      color: const Color(0xFFB4BEDC).withOpacity(0.3),
                      offset: const Offset(2, 2),
                      blurRadius: 5,
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(0.8),
                      offset: const Offset(-1, -1),
                      blurRadius: 3,
                    ),
                  ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: selected ? C.accent.withOpacity(0.15) : C.divider,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 18,
                  color: selected ? C.accentDark : C.textMuted,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: selected ? C.accentDark : C.text,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                desc,
                style: const TextStyle(
                  fontSize: 10,
                  color: C.textSub,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 10,
        color: C.textMuted,
        letterSpacing: 1.5,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool filled;

  const _InputField({
    required this.controller,
    required this.hint,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: filled ? C.card : C.neuBg,
        borderRadius: BorderRadius.circular(14),
        border: filled ? Border.all(color: C.accent.withOpacity(0.3)) : null,
        boxShadow: filled
            ? [
                BoxShadow(
                  color: const Color(0xFFB4BEDC).withOpacity(0.4),
                  offset: const Offset(4, 4),
                  blurRadius: 10,
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.9),
                  offset: const Offset(-2, -2),
                  blurRadius: 6,
                ),
              ]
            : [
                BoxShadow(
                  color: const Color(0xFFB4BEDC).withOpacity(0.3),
                  offset: const Offset(2, 2),
                  blurRadius: 5,
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.8),
                  offset: const Offset(-1, -1),
                  blurRadius: 3,
                ),
              ],
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 13, color: C.text),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: C.textMuted, fontSize: 13),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
// CATALOG SCREEN
// ─────────────────────────────────────────
class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  int _tab = 0;
  int _filter = 0;

  final _filters = ['All', 'Strength', 'Cardio', 'Yoga'];

  final _trainers = [
    {
      'initials': 'AS',
      'name': 'Artem Smirnov',
      'spec': 'Strength · Functional training',
      'rating': '4.9',
      'sessions': '128',
      'price': '\$40/h',
      'colors': [Color(0xFF5DCAA5), Color(0xFF2a8a65)],
      'slots': [true, false, true, true, false, true],
    },
    {
      'initials': 'MK',
      'name': 'Maria Kozlova',
      'spec': 'Yoga · Stretching · Pilates',
      'rating': '5.0',
      'sessions': '204',
      'price': '\$35/h',
      'colors': [Color(0xFF7F77DD), Color(0xFF534AB7)],
      'slots': [true, true, true, false, true, false],
    },
    {
      'initials': 'DV',
      'name': 'Dmitry Volkov',
      'spec': 'Cardio · Running · CrossFit',
      'rating': '4.8',
      'sessions': '87',
      'price': '\$30/h',
      'colors': [Color(0xFFEF9F27), Color(0xFFBA7517)],
      'slots': [false, true, false, false, true, true],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.bg,
      body: Column(
        children: [
          // Header
          Container(
            color: C.bgLight,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 12,
              left: 20,
              right: 20,
              bottom: 14,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Good morning',
                  style: TextStyle(fontSize: 12, color: C.textMuted),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Find a trainer',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: C.text,
                  ),
                ),
                const SizedBox(height: 12),
                // Search
                NeuInset(
                  radius: 16,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search_rounded,
                        size: 18,
                        color: C.textMuted,
                      ),
                      const SizedBox(width: 9),
                      const Text(
                        'Search by name or specialty...',
                        style: TextStyle(fontSize: 13, color: C.textMuted),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Filters
          SizedBox(
            height: 46,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
              itemCount: _filters.length,
              itemBuilder: (_, i) {
                final isOn = i == _filter;
                return GestureDetector(
                  onTap: () => setState(() => _filter = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: isOn
                          ? const LinearGradient(
                              colors: [C.accent, C.accentDark],
                            )
                          : null,
                      color: isOn ? null : C.neuBg,
                      boxShadow: isOn
                          ? [
                              BoxShadow(
                                color: C.accent.withOpacity(0.3),
                                offset: const Offset(0, 3),
                                blurRadius: 10,
                              ),
                            ]
                          : [
                              BoxShadow(
                                color: const Color(0xFFB4BEDC).withOpacity(0.3),
                                offset: const Offset(2, 2),
                                blurRadius: 4,
                              ),
                              BoxShadow(
                                color: Colors.white.withOpacity(0.8),
                                offset: const Offset(-1, -1),
                                blurRadius: 3,
                              ),
                            ],
                    ),
                    child: Center(
                      child: Text(
                        _filters[i],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isOn ? Colors.white : C.textSub,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Trainer cards
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
              itemCount: _trainers.length,
              itemBuilder: (_, i) {
                final t = _trainers[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProfileScreen(trainer: t),
                      ),
                    ),
                    child: NeuCard(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TrainerAvatar(
                            initials: t['initials'] as String,
                            colors: t['colors'] as List<Color>,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  t['name'] as String,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: C.text,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  t['spec'] as String,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: C.textSub,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Text(
                                      '★ ${t['rating']}',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Color(0xFFF0A500),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${t['sessions']} sessions',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: C.textMuted,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      t['price'] as String,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: C.accent,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: List.generate(6, (j) {
                                    final free =
                                        (t['slots'] as List<bool>)[j];
                                    return Container(
                                      width: 7,
                                      height: 7,
                                      margin: const EdgeInsets.only(right: 4),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: free
                                            ? C.accent
                                            : C.neuBg,
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Tab bar
          Container(
            decoration: BoxDecoration(
              color: C.card,
              border: Border(top: BorderSide(color: C.divider)),
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  _TabItem(
                    icon: Icons.grid_view_rounded,
                    label: 'Trainers',
                    active: _tab == 0,
                    onTap: () => setState(() => _tab = 0),
                  ),
                  _TabItem(
                    icon: Icons.calendar_today_rounded,
                    label: 'Schedule',
                    active: _tab == 1,
                    onTap: () => setState(() => _tab = 1),
                  ),
                  _TabItem(
                    icon: Icons.person_rounded,
                    label: 'Profile',
                    active: _tab == 2,
                    onTap: () => setState(() => _tab = 2),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _TabItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: active ? C.text : C.neuBg,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Icon(
                  icon,
                  size: 13,
                  color: active ? Colors.white : C.textMuted,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w400,
                  color: active ? C.text : C.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
// PROFILE SCREEN
// ─────────────────────────────────────────
class ProfileScreen extends StatefulWidget {
  final Map<String, dynamic> trainer;

  const ProfileScreen({super.key, required this.trainer});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedSlot = 2;

  final _slots = ['09:00', '10:00', '11:00', '14:00', '15:00', '17:00'];
  final _slotAvail = [true, false, true, true, false, true];

  @override
  Widget build(BuildContext context) {
    final t = widget.trainer;

    return Scaffold(
      backgroundColor: C.bg,
      body: Column(
        children: [
          // Hero
          Container(
            color: C.bgLight,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 10,
              left: 20,
              right: 20,
              bottom: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: NeuCard(
                    radius: 11,
                    padding: const EdgeInsets.all(10),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 13,
                      color: C.textSub,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TrainerAvatar(
                  initials: t['initials'] as String,
                  colors: t['colors'] as List<Color>,
                  size: 64,
                ),
                const SizedBox(height: 12),
                Text(
                  t['name'] as String,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: C.text,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  t['spec'] as String,
                  style: const TextStyle(
                    fontSize: 12,
                    color: C.accent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    _Stat(value: t['rating'] as String, label: 'Rating'),
                    const SizedBox(width: 20),
                    _Stat(value: t['sessions'] as String, label: 'Sessions'),
                    const SizedBox(width: 20),
                    const _Stat(value: '3 yrs', label: 'Experience'),
                  ],
                ),
              ],
            ),
          ),

          // Body
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionLabel('ABOUT'),
                  const SizedBox(height: 8),
                  NeuCard(
                    padding: const EdgeInsets.all(14),
                    child: const Text(
                      'Specializing in strength and functional movement. '
                      'I help clients reach their goals in 3 months with a '
                      'structured, science-backed approach.',
                      style: TextStyle(
                        fontSize: 13,
                        color: C.textSub,
                        height: 1.65,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  _SectionLabel('SPECIALTIES'),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: ['Strength', 'Functional', 'Weight loss', 'Muscle gain']
                        .map((tag) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: C.accentLight,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                tag,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: C.accentDark,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ))
                        .toList(),
                  ),

                  const SizedBox(height: 16),
                  _SectionLabel('AVAILABLE TODAY'),
                  const SizedBox(height: 8),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 2.8,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: _slots.length,
                    itemBuilder: (_, i) {
                      final isSelected = i == _selectedSlot;
                      final isAvail = _slotAvail[i];

                      return GestureDetector(
                        onTap: isAvail
                            ? () => setState(() => _selectedSlot = i)
                            : null,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            gradient: isSelected
                                ? const LinearGradient(
                                    colors: [C.accent, C.accentDark],
                                  )
                                : null,
                            color: isSelected
                                ? null
                                : isAvail
                                    ? C.accentLight
                                    : C.neuBg,
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: C.accent.withOpacity(0.3),
                                      offset: const Offset(0, 3),
                                      blurRadius: 10,
                                    ),
                                  ]
                                : isAvail
                                    ? null
                                    : [
                                        BoxShadow(
                                          color: const Color(0xFFB4BEDC)
                                              .withOpacity(0.3),
                                          offset: const Offset(2, 2),
                                          blurRadius: 5,
                                        ),
                                        BoxShadow(
                                          color:
                                              Colors.white.withOpacity(0.8),
                                          offset: const Offset(-1, -1),
                                          blurRadius: 3,
                                        ),
                                      ],
                          ),
                          child: Center(
                            child: Text(
                              _slots[i],
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: isSelected
                                    ? Colors.white
                                    : isAvail
                                        ? C.accentDark
                                        : C.textMuted,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  GradientButton(
                    label: 'Book — ${_slots[_selectedSlot]}',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ConfirmScreen(
                          trainer: t,
                          time: _slots[_selectedSlot],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  GhostButton(
                    label: 'Message trainer',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatScreen(trainer: t),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String value;
  final String label;

  const _Stat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: C.text,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: C.textMuted),
        ),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 10,
        color: C.textMuted,
        letterSpacing: 2,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

// ─────────────────────────────────────────
// CONFIRM SCREEN
// ─────────────────────────────────────────
class ConfirmScreen extends StatelessWidget {
  final Map<String, dynamic> trainer;
  final String time;

  const ConfirmScreen({
    super.key,
    required this.trainer,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.bgLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: NeuCard(
                    radius: 11,
                    padding: const EdgeInsets.all(10),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 13,
                      color: C.textSub,
                    ),
                  ),
                ),
              ),
              const Spacer(),

              // Check icon
              NeuCard(
                radius: 30,
                padding: const EdgeInsets.all(24),
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [C.accent, C.accentDark],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: C.accent.withOpacity(0.35),
                        offset: const Offset(0, 6),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'Booking confirmed!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: C.text,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              Text(
                'Your session with ${trainer['name']} has been booked.\nYou\'ll get a reminder 30 min before.',
                style: const TextStyle(
                  fontSize: 13,
                  color: C.textSub,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 28),

              // Details card
              NeuCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    _ConfirmRow('Trainer', trainer['name'] as String),
                    _ConfirmRow('Date', 'Today, Mar 25'),
                    _ConfirmRow('Time', time, highlight: true),
                    _ConfirmRow('Duration', '60 min'),
                    _ConfirmRow('Price', trainer['price'] as String),
                  ],
                ),
              ),

              const Spacer(),

              GradientButton(
                label: 'Message trainer',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatScreen(trainer: trainer),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              GhostButton(
                label: 'Back to catalog',
                onTap: () => Navigator.popUntil(
                  context,
                  (r) => r.isFirst,
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _ConfirmRow extends StatelessWidget {
  final String label;
  final String value;
  final bool highlight;

  const _ConfirmRow(this.label, this.value, {this.highlight = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: C.textSub)),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: highlight ? C.accent : C.text,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
// CHAT SCREEN
// ─────────────────────────────────────────
class ChatScreen extends StatefulWidget {
  final Map<String, dynamic> trainer;

  const ChatScreen({super.key, required this.trainer});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _ctrl = TextEditingController();
  final _scroll = ScrollController();

  final _messages = [
    {'text': 'Hi! Looking forward to our session 💪', 'mine': false},
    {'text': 'Me too! Should I bring any equipment?', 'mine': true},
    {'text': 'Just comfortable clothes and water. I\'ll bring resistance bands.', 'mine': false},
    {'text': 'Perfect, see you at 11:00!', 'mine': true},
    {'text': 'See you! Studio 3, 2nd floor.', 'mine': false},
  ];

  void _send() {
    if (_ctrl.text.trim().isEmpty) return;
    setState(() {
      _messages.add({'text': _ctrl.text.trim(), 'mine': true});
      _ctrl.clear();
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      _scroll.animateTo(
        _scroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.trainer;
    return Scaffold(
      backgroundColor: C.bg,
      body: Column(
        children: [
          // Header
          Container(
            color: C.bgLight,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 10,
              left: 20,
              right: 20,
              bottom: 16,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: NeuCard(
                    radius: 11,
                    padding: const EdgeInsets.all(10),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 13,
                      color: C.textSub,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                TrainerAvatar(
                  initials: t['initials'] as String,
                  colors: t['colors'] as List<Color>,
                  size: 38,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t['name'] as String,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: C.text,
                        ),
                      ),
                      const Text(
                        'Online',
                        style: TextStyle(
                          fontSize: 11,
                          color: C.accent,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Messages
          Expanded(
            child: ListView.builder(
              controller: _scroll,
              padding: const EdgeInsets.all(20),
              itemCount: _messages.length,
              itemBuilder: (_, i) {
                final m = _messages[i];
                final isMine = m['mine'] as bool;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: isMine
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          gradient: isMine
                              ? const LinearGradient(
                                  colors: [C.accent, C.accentDark],
                                )
                              : null,
                          color: isMine ? null : C.card,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(16),
                            topRight: const Radius.circular(16),
                            bottomLeft: Radius.circular(isMine ? 16 : 4),
                            bottomRight: Radius.circular(isMine ? 4 : 16),
                          ),
                          boxShadow: isMine
                              ? [
                                  BoxShadow(
                                    color: C.accent.withOpacity(0.25),
                                    offset: const Offset(0, 3),
                                    blurRadius: 10,
                                  ),
                                ]
                              : [
                                  BoxShadow(
                                    color: const Color(0xFFB4BEDC)
                                        .withOpacity(0.3),
                                    offset: const Offset(3, 3),
                                    blurRadius: 8,
                                  ),
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.8),
                                    offset: const Offset(-1, -1),
                                    blurRadius: 4,
                                  ),
                                ],
                        ),
                        child: Text(
                          m['text'] as String,
                          style: TextStyle(
                            fontSize: 13,
                            color: isMine ? Colors.white : C.text,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Input
          Container(
            color: C.bgLight,
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 12,
              bottom: MediaQuery.of(context).padding.bottom + 12,
            ),
            child: Row(
              children: [
                Expanded(
                  child: NeuInset(
                    radius: 20,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: TextField(
                      controller: _ctrl,
                      style: const TextStyle(fontSize: 13, color: C.text),
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: TextStyle(color: C.textMuted, fontSize: 13),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                      onSubmitted: (_) => _send(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: _send,
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      gradient: const LinearGradient(
                        colors: [C.accent, C.accentDark],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: C.accent.withOpacity(0.35),
                          offset: const Offset(0, 4),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 18,
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
}

// ─────────────────────────────────────────
// PAINTERS
// ─────────────────────────────────────────
class _LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF5DCAA5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path()
      ..addOval(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width * 0.42,
      ));
    canvas.drawPath(path, paint);

    final check = Path()
      ..moveTo(size.width * 0.28, size.height * 0.5)
      ..lineTo(size.width * 0.45, size.height * 0.67)
      ..lineTo(size.width * 0.72, size.height * 0.35);
    canvas.drawPath(check, paint);
  }

  @override
  bool shouldRepaint(_) => false;
}
