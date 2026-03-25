import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const FitBookApp());
}

class C {
  static const accent = Color(0xFFFF6B2C);
  static const accentDark = Color(0xFFFF4500);
  static const text = Color(0xFF111111);
  static const textSub = Color(0xFF999999);
  static const textMuted = Color(0xFFBBBBBB);
  static const surface = Color(0xFFF5F5F5);
  static const accentLight = Color(0xFFFFF4EF);
}

class FitBookApp extends StatelessWidget {
  const FitBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitBook',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(primary: C.accent),
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
// ONBOARDING — ANIMATED COLLAGE
// ─────────────────────────────────────────
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {

  // Controllers for each photo
  late AnimationController _c1, _c2, _c3, _c4;
  // Controller for text
  late AnimationController _cText;

  // Slide animations
  late Animation<Offset> _a1, _a2, _a3, _a4;
  // Opacity
  late Animation<double> _o1, _o2, _o3, _o4;
  // Text
  late Animation<double> _aTextOpacity;
  late Animation<Offset> _aTextSlide;

  @override
  void initState() {
    super.initState();
    final dur = const Duration(milliseconds: 800);
    final curve = Curves.easeOutCubic;

    _c1 = AnimationController(vsync: this, duration: dur);
    _c2 = AnimationController(vsync: this, duration: dur);
    _c3 = AnimationController(vsync: this, duration: dur);
    _c4 = AnimationController(vsync: this, duration: dur);
    _cText = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

    // Photo 1 — from left
    _a1 = Tween<Offset>(begin: const Offset(-1.2, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _c1, curve: curve));
    _o1 = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _c1, curve: Curves.easeOut));

    // Photo 2 — from top
    _a2 = Tween<Offset>(begin: const Offset(0, -1.2), end: Offset.zero)
        .animate(CurvedAnimation(parent: _c2, curve: curve));
    _o2 = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _c2, curve: Curves.easeOut));

    // Photo 3 — from bottom
    _a3 = Tween<Offset>(begin: const Offset(0, 1.2), end: Offset.zero)
        .animate(CurvedAnimation(parent: _c3, curve: curve));
    _o3 = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _c3, curve: Curves.easeOut));

    // Photo 4 — from right
    _a4 = Tween<Offset>(begin: const Offset(1.2, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _c4, curve: curve));
    _o4 = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _c4, curve: Curves.easeOut));

    // Text — fade + slide up
    _aTextOpacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _cText, curve: Curves.easeOut));
    _aTextSlide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(CurvedAnimation(parent: _cText, curve: Curves.easeOut));

    _startAnimations();
  }

  Future<void> _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 100));
    _c1.forward();
    await Future.delayed(const Duration(milliseconds: 220));
    _c2.forward();
    await Future.delayed(const Duration(milliseconds: 220));
    _c3.forward();
    await Future.delayed(const Duration(milliseconds: 220));
    _c4.forward();
    await Future.delayed(const Duration(milliseconds: 500));
    _cText.forward();
  }

  @override
  void dispose() {
    _c1.dispose(); _c2.dispose(); _c3.dispose(); _c4.dispose();
    _cText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;
    final botPad = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [

          // ── PHOTO GRID ──
          Positioned.fill(
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      // Photo 1 — top left — from left
                      Expanded(
                        child: SlideTransition(
                          position: _a1,
                          child: FadeTransition(
                            opacity: _o1,
                            child: Image.asset(
                              'assets/images/sport1.jpg',
                              fit: BoxFit.cover,
                              height: double.infinity,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 3),
                      // Photo 2 — top right — from top
                      Expanded(
                        child: SlideTransition(
                          position: _a2,
                          child: FadeTransition(
                            opacity: _o2,
                            child: Image.asset(
                              'assets/images/sport2.jpg',
                              fit: BoxFit.cover,
                              height: double.infinity,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 3),
                Expanded(
                  child: Row(
                    children: [
                      // Photo 3 — bottom left — from bottom
                      Expanded(
                        child: SlideTransition(
                          position: _a3,
                          child: FadeTransition(
                            opacity: _o3,
                            child: Image.asset(
                              'assets/images/sport3.jpg',
                              fit: BoxFit.cover,
                              height: double.infinity,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 3),
                      // Photo 4 — bottom right — from right
                      Expanded(
                        child: SlideTransition(
                          position: _a4,
                          child: FadeTransition(
                            opacity: _o4,
                            child: Image.asset(
                              'assets/images/sport4.jpg',
                              fit: BoxFit.cover,
                              height: double.infinity,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── DARK OVERLAY ──
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.15, 0.45, 0.7, 1.0],
                  colors: [
                    Color(0x99000000),
                    Color(0x22000000),
                    Color(0x44000000),
                    Color(0xCC000000),
                    Color(0xFF000000),
                  ],
                ),
              ),
            ),
          ),

          // ── LOGO TOP LEFT ──
          Positioned(
            top: topPad + 16,
            left: 24,
            child: FadeTransition(
              opacity: _aTextOpacity,
              child: Row(
                children: [
                  Container(
                    width: 36, height: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        colors: [C.accent, C.accentDark],
                      ),
                    ),
                    child: const Icon(
                      Icons.check_circle_outline_rounded,
                      color: Colors.white, size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'FITBOOK',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 2.5,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── BOTTOM CONTENT ──
          Positioned(
            left: 0, right: 0, bottom: 0,
            child: SlideTransition(
              position: _aTextSlide,
              child: FadeTransition(
                opacity: _aTextOpacity,
                child: Container(
                  padding: EdgeInsets.only(
                    left: 24, right: 24,
                    top: 24,
                    bottom: botPad + 28,
                  ),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black],
                      stops: [0, 0.3],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Tag
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          color: C.accent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'FIND YOUR TRAINER',
                          style: TextStyle(
                            fontSize: 10, letterSpacing: 1.5,
                            fontWeight: FontWeight.w700, color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Book top sports\ncoaches instantly',
                        style: TextStyle(
                          fontSize: 30, fontWeight: FontWeight.w800,
                          color: Colors.white, height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Tennis, basketball, yoga and more — find\ncertified trainers near you in seconds.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.6),
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Get started button
                      GestureDetector(
                        onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const RegisterScreen())),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: const LinearGradient(
                              colors: [C.accent, C.accentDark],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: C.accent.withOpacity(0.45),
                                offset: const Offset(0, 8),
                                blurRadius: 24,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              'Get started  →',
                              style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Already have account
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white.withOpacity(0.08),
                          ),
                          child: const Center(
                            child: Text(
                              'I already have an account',
                              style: TextStyle(
                                fontSize: 14, color: Colors.white54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Row(
                children: List.generate(4, (i) => Expanded(
                  child: Container(
                    height: 4,
                    margin: EdgeInsets.only(right: i < 3 ? 4 : 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      gradient: i < 2 ? const LinearGradient(
                        colors: [C.accent, C.accentDark]) : null,
                      color: i < 2 ? null : C.surface,
                    ),
                  ),
                )),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(
                    color: C.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new_rounded,
                      size: 16, color: C.textSub),
                ),
              ),
              const SizedBox(height: 20),
              const Text('STEP 1 OF 3',
                style: TextStyle(fontSize: 10, color: C.accent,
                    letterSpacing: 2.5, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              const Text('Who are you?',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800,
                    color: C.text)),
              const SizedBox(height: 6),
              const Text('Choose your role — it shapes your entire experience',
                style: TextStyle(fontSize: 14, color: C.textSub, height: 1.5)),
              const SizedBox(height: 24),
              Row(children: [
                _roleCard('Trainer', 'I manage my\nschedule',
                    Icons.fitness_center_rounded, 'trainer'),
                const SizedBox(width: 12),
                _roleCard('Client', 'Looking\nfor a coach',
                    Icons.person_rounded, 'client'),
              ]),
              const SizedBox(height: 24),
              _label('FULL NAME'),
              const SizedBox(height: 8),
              _field('Your full name'),
              const SizedBox(height: 16),
              _label('EMAIL'),
              const SizedBox(height: 8),
              _field('example@gmail.com'),
              const SizedBox(height: 24),
              _gradBtn('Continue', () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const CatalogScreen()))),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _roleCard(String title, String desc, IconData icon, String role) {
    final sel = _role == role;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _role = role),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: sel ? C.accentLight : C.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: sel ? C.accent : Colors.transparent, width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                  color: sel ? C.accent : const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 20,
                    color: sel ? Colors.white : C.textMuted),
              ),
              const SizedBox(height: 12),
              Text(title, style: TextStyle(fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: sel ? C.accentDark : C.text)),
              const SizedBox(height: 4),
              Text(desc, style: const TextStyle(
                  fontSize: 11, color: C.textSub, height: 1.5)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String t) => Text(t, style: const TextStyle(
      fontSize: 10, color: C.textMuted,
      letterSpacing: 1.5, fontWeight: FontWeight.w700));

  Widget _field(String hint) => Container(
    decoration: BoxDecoration(color: C.surface,
        borderRadius: BorderRadius.circular(14)),
    child: TextField(
      style: const TextStyle(fontSize: 14, color: C.text),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: C.textMuted),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 14),
        border: InputBorder.none,
      ),
    ),
  );

  Widget _gradBtn(String label, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(colors: [C.accent, C.accentDark]),
        boxShadow: [BoxShadow(color: C.accent.withOpacity(0.35),
            offset: const Offset(0, 6), blurRadius: 20)],
      ),
      child: Center(child: Text(label, style: const TextStyle(
          fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white))),
    ),
  );
}

// ─────────────────────────────────────────
// CATALOG SCREEN — список тренеров
// ─────────────────────────────────────────
class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final List<Map<String, dynamic>> _trainers = [
    {
      'name': 'Alex Morrison',
      'sport': 'Personal Training',
      'rating': 4.9,
      'reviews': 128,
      'price': 60,
      'tag': 'TOP',
      'color': C.accent,
    },
    {
      'name': 'Sofia Chen',
      'sport': 'Yoga & Pilates',
      'rating': 4.8,
      'reviews': 94,
      'price': 45,
      'tag': 'NEW',
      'color': Color(0xFF7C3AED),
    },
    {
      'name': 'Marcus Hill',
      'sport': 'Basketball',
      'rating': 4.7,
      'reviews': 76,
      'price': 55,
      'tag': null,
      'color': Color(0xFF0EA5E9),
    },
    {
      'name': 'Elena Voss',
      'sport': 'Tennis',
      'rating': 5.0,
      'reviews': 210,
      'price': 75,
      'tag': 'TOP',
      'color': C.accent,
    },
    {
      'name': 'James Park',
      'sport': 'Boxing',
      'rating': 4.6,
      'reviews': 53,
      'price': 50,
      'tag': null,
      'color': Color(0xFFDC2626),
    },
    {
      'name': 'Nina Russo',
      'sport': 'Swimming',
      'rating': 4.8,
      'reviews': 87,
      'price': 65,
      'tag': 'NEW',
      'color': Color(0xFF0891B2),
    },
  ];

  final List<String> _filters = ['All', 'Training', 'Yoga', 'Tennis', 'Boxing', 'Swimming'];
  int _selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── HEADER ──
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 40, height: 40,
                          decoration: BoxDecoration(
                            color: C.surface,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.arrow_back_ios_new_rounded,
                              size: 16, color: C.textSub),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Find a Trainer',
                          style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w800,
                            color: C.text,
                          ),
                        ),
                      ),
                      Container(
                        width: 40, height: 40,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [C.accent, C.accentDark]),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.tune_rounded,
                            size: 18, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Search bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: C.surface,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search_rounded, color: C.textMuted, size: 20),
                        const SizedBox(width: 10),
                        Text('Search trainers...',
                            style: TextStyle(
                                fontSize: 14,
                                color: C.textMuted.withOpacity(0.8))),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  // Filter chips
                  SizedBox(
                    height: 34,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _filters.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (_, i) {
                        final sel = _selectedFilter == i;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedFilter = i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 6),
                            decoration: BoxDecoration(
                              gradient: sel
                                  ? const LinearGradient(
                                      colors: [C.accent, C.accentDark])
                                  : null,
                              color: sel ? null : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: sel ? Colors.transparent : C.surface,
                                width: 1.5,
                              ),
                            ),
                            child: Text(
                              _filters[i],
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: sel ? Colors.white : C.textSub,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),

            // ── TRAINER LIST ──
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                itemCount: _trainers.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) => _trainerCard(_trainers[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _trainerCard(Map<String, dynamic> t) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 60, height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [(t['color'] as Color).withOpacity(0.15),
                         (t['color'] as Color).withOpacity(0.3)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(Icons.person_rounded,
                size: 30, color: t['color'] as Color),
          ),
          const SizedBox(width: 14),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(t['name'],
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700,
                            color: C.text)),
                    if (t['tag'] != null) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [C.accent, C.accentDark]),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(t['tag'],
                            style: const TextStyle(
                                fontSize: 9, fontWeight: FontWeight.w800,
                                color: Colors.white, letterSpacing: 1)),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 3),
                Text(t['sport'],
                    style: const TextStyle(fontSize: 12, color: C.textSub)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.star_rounded,
                        size: 14, color: C.accent),
                    const SizedBox(width: 3),
                    Text('${t['rating']}',
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w700,
                            color: C.text)),
                    const SizedBox(width: 4),
                    Text('(${t['reviews']} reviews)',
                        style: const TextStyle(
                            fontSize: 11, color: C.textMuted)),
                  ],
                ),
              ],
            ),
          ),
          // Price + Book
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('\$${t['price']}/h',
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w800,
                      color: C.accent)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [C.accent, C.accentDark]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('Book',
                    style: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w700,
                        color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
