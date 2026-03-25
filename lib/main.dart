import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

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

// ═══════════════════════════════════════════
// COLORS
// ═══════════════════════════════════════════
class C {
  static const accent = Color(0xFFFF6B2C);
  static const accentDark = Color(0xFFFF4500);
  static const text = Color(0xFF111111);
  static const textSub = Color(0xFF999999);
  static const textMuted = Color(0xFFBBBBBB);
  static const surface = Color(0xFFF5F5F5);
  static const accentLight = Color(0xFFFFF4EF);
  static const green = Color(0xFF22C55E);
  static const purple = Color(0xFF7C3AED);
  static const sky = Color(0xFF0EA5E9);
  static const red = Color(0xFFDC2626);
  static const teal = Color(0xFF0891B2);
  static const yellow = Color(0xFFEAB308);
}

// ═══════════════════════════════════════════
// SHARED DATA
// ═══════════════════════════════════════════
class AppData {
  static String userName = '';
  static String userEmail = '';
  static String userRole = 'client';

  static final List<Map<String, dynamic>> trainers = [
    {
      'name': 'Alex Morrison',
      'sport': 'Personal Training',
      'rating': 4.9,
      'reviews': 128,
      'price': 60,
      'tag': 'TOP',
      'color': C.accent,
      'exp': '8 years',
      'clients': 340,
      'specs': ['Weight Loss', 'Muscle Building', 'HIIT'],
      'bio': 'NASM-certified personal trainer specializing in body transformation. Former collegiate athlete with a passion for helping clients unlock their full potential through science-based training programs.',
      'certs': ['NASM-CPT', 'CrossFit L2', 'Precision Nutrition'],
    },
    {
      'name': 'Sofia Chen',
      'sport': 'Yoga & Pilates',
      'rating': 4.8,
      'reviews': 94,
      'price': 45,
      'tag': 'NEW',
      'color': C.purple,
      'exp': '5 years',
      'clients': 210,
      'specs': ['Hatha Yoga', 'Vinyasa', 'Pilates Mat'],
      'bio': 'RYT-500 certified yoga instructor bringing mindfulness and strength together. Trained in Bali and India, offering sessions that balance physical challenge with deep relaxation.',
      'certs': ['RYT-500', 'Pilates Certification', 'Meditation Coach'],
    },
    {
      'name': 'Marcus Hill',
      'sport': 'Basketball',
      'rating': 4.7,
      'reviews': 76,
      'price': 55,
      'tag': null,
      'color': C.sky,
      'exp': '6 years',
      'clients': 180,
      'specs': ['Shooting', 'Ball Handling', 'Defense'],
      'bio': 'Former semi-pro player turned elite skills coach. Specializes in guard development and has trained multiple players who went on to compete at the collegiate level.',
      'certs': ['USA Basketball Coach', 'NSCA-CSCS'],
    },
    {
      'name': 'Elena Voss',
      'sport': 'Tennis',
      'rating': 5.0,
      'reviews': 210,
      'price': 75,
      'tag': 'TOP',
      'color': C.accent,
      'exp': '12 years',
      'clients': 520,
      'specs': ['Serve & Volley', 'Footwork', 'Strategy'],
      'bio': 'ITF-certified coach and former WTA-ranked player. Known for transforming recreational players into competitive athletes through technical precision and mental toughness training.',
      'certs': ['ITF Coach', 'PTR Professional', 'Sports Psychology'],
    },
    {
      'name': 'James Park',
      'sport': 'Boxing',
      'rating': 4.6,
      'reviews': 53,
      'price': 50,
      'tag': null,
      'color': C.red,
      'exp': '7 years',
      'clients': 150,
      'specs': ['Technique', 'Cardio Boxing', 'Self-defense'],
      'bio': 'Professional boxing coach with amateur fighting background. Makes boxing accessible and fun while building incredible fitness, coordination, and confidence.',
      'certs': ['USA Boxing Coach', 'First Aid Certified'],
    },
    {
      'name': 'Nina Russo',
      'sport': 'Swimming',
      'rating': 4.8,
      'reviews': 87,
      'price': 65,
      'tag': 'NEW',
      'color': C.teal,
      'exp': '9 years',
      'clients': 290,
      'specs': ['Freestyle', 'Backstroke', 'Triathlon Prep'],
      'bio': 'ASCA Level 3 swim coach and former national team member. Specializes in stroke correction and open water preparation for triathletes and competitive swimmers.',
      'certs': ['ASCA Level 3', 'Lifeguard Instructor', 'Triathlon Coach'],
    },
  ];

  static final List<Map<String, dynamic>> myBookings = [];

  static final List<Map<String, dynamic>> reviews = [
    {'name': 'Sarah M.', 'stars': 5, 'text': 'Amazing trainer! Helped me reach my goals in just 3 months. Highly recommend to anyone serious about fitness.', 'ago': '2 days ago'},
    {'name': 'David K.', 'stars': 5, 'text': 'Very professional and motivating. The personalized program made all the difference.', 'ago': '1 week ago'},
    {'name': 'Anna L.', 'stars': 4, 'text': 'Great sessions, always on time. Pushes you just the right amount. Would love more flexibility in scheduling.', 'ago': '2 weeks ago'},
    {'name': 'Mark J.', 'stars': 5, 'text': 'Best investment in my health! Incredible knowledge and always keeps things fun.', 'ago': '3 weeks ago'},
  ];
}

// ═══════════════════════════════════════════
// APP
// ═══════════════════════════════════════════
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

// ═══════════════════════════════════════════
// SHARED WIDGETS
// ═══════════════════════════════════════════
Widget gradBtn(String label, VoidCallback? onTap, {bool enabled = true}) => GestureDetector(
  onTap: enabled ? onTap : null,
  child: AnimatedContainer(
    duration: const Duration(milliseconds: 200),
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      gradient: LinearGradient(
        colors: enabled ? [C.accent, C.accentDark] : [C.textMuted, C.textMuted],
      ),
      boxShadow: enabled ? [BoxShadow(color: C.accent.withOpacity(0.35),
          offset: const Offset(0, 6), blurRadius: 20)] : null,
    ),
    child: Center(child: Text(label, style: const TextStyle(
        fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white))),
  ),
);

Widget backBtn(BuildContext context) => GestureDetector(
  onTap: () => Navigator.pop(context),
  child: Container(
    width: 40, height: 40,
    decoration: BoxDecoration(
      color: C.surface,
      borderRadius: BorderRadius.circular(12),
    ),
    child: const Icon(Icons.arrow_back_ios_new_rounded, size: 16, color: C.textSub),
  ),
);

Widget sectionLabel(String t) => Text(t, style: const TextStyle(
    fontSize: 10, color: C.textMuted, letterSpacing: 1.5, fontWeight: FontWeight.w700));

Widget inputField(String hint, TextEditingController ctrl, {String? error, TextInputType? keyboardType, bool obscure = false, Widget? suffix}) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Container(
      decoration: BoxDecoration(
        color: C.surface,
        borderRadius: BorderRadius.circular(14),
        border: error != null ? Border.all(color: C.red.withOpacity(0.5), width: 1.5) : null,
      ),
      child: TextField(
        controller: ctrl,
        keyboardType: keyboardType,
        obscureText: obscure,
        style: const TextStyle(fontSize: 14, color: C.text),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: C.textMuted),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: InputBorder.none,
          suffixIcon: suffix,
        ),
      ),
    ),
    if (error != null)
      Padding(
        padding: const EdgeInsets.only(top: 6, left: 4),
        child: Text(error, style: const TextStyle(fontSize: 11, color: C.red)),
      ),
  ],
);

// Web wrapper — centers content like a phone frame on wide screens
class WebFrame extends StatelessWidget {
  final Widget child;
  const WebFrame({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: child,
      ),
    );
  }
}

// ═══════════════════════════════════════════
// ONBOARDING
// ═══════════════════════════════════════════
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late AnimationController _c1, _c2, _c3, _c4, _cText;
  late Animation<Offset> _a1, _a2, _a3, _a4, _aTextSlide;
  late Animation<double> _o1, _o2, _o3, _o4, _aTextOpacity;

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

    _a1 = Tween<Offset>(begin: const Offset(-1.2, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _c1, curve: curve));
    _o1 = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _c1, curve: Curves.easeOut));
    _a2 = Tween<Offset>(begin: const Offset(0, -1.2), end: Offset.zero)
        .animate(CurvedAnimation(parent: _c2, curve: curve));
    _o2 = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _c2, curve: Curves.easeOut));
    _a3 = Tween<Offset>(begin: const Offset(0, 1.2), end: Offset.zero)
        .animate(CurvedAnimation(parent: _c3, curve: curve));
    _o3 = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _c3, curve: Curves.easeOut));
    _a4 = Tween<Offset>(begin: const Offset(1.2, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _c4, curve: curve));
    _o4 = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _c4, curve: Curves.easeOut));
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

  Widget _photo(Animation<Offset> a, Animation<double> o, String asset) =>
    Expanded(
      child: SlideTransition(
        position: a,
        child: FadeTransition(
          opacity: o,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.asset(asset, fit: BoxFit.cover, height: double.infinity),
          ),
        ),
      ),
    );

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;
    final botPad = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(children: [
              Expanded(child: Row(children: [
                _photo(_a1, _o1, 'assets/images/sport1.jpg'),
                const SizedBox(width: 3),
                _photo(_a2, _o2, 'assets/images/sport2.jpg'),
              ])),
              const SizedBox(height: 3),
              Expanded(child: Row(children: [
                _photo(_a3, _o3, 'assets/images/sport3.jpg'),
                const SizedBox(width: 3),
                _photo(_a4, _o4, 'assets/images/sport4.jpg'),
              ])),
            ]),
          ),
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter, end: Alignment.bottomCenter,
                  stops: [0.0, 0.15, 0.45, 0.7, 1.0],
                  colors: [Color(0x99000000), Color(0x22000000), Color(0x44000000), Color(0xCC000000), Color(0xFF000000)],
                ),
              ),
            ),
          ),
          // Logo
          Positioned(
            top: topPad + 16, left: 24,
            child: FadeTransition(
              opacity: _aTextOpacity,
              child: Row(children: [
                Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(colors: [C.accent, C.accentDark]),
                  ),
                  child: const Icon(Icons.local_fire_department_rounded, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 10),
                const Text('FITBOOK', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: 2.5)),
              ]),
            ),
          ),
          // Bottom
          Positioned(
            left: 0, right: 0, bottom: 0,
            child: SlideTransition(
              position: _aTextSlide,
              child: FadeTransition(
                opacity: _aTextOpacity,
                child: Container(
                  padding: EdgeInsets.only(left: 24, right: 24, top: 24, bottom: botPad + 28),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black], stops: [0, 0.3]),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(color: C.accent, borderRadius: BorderRadius.circular(20)),
                        child: const Text('FIND YOUR TRAINER', style: TextStyle(fontSize: 10, letterSpacing: 1.5, fontWeight: FontWeight.w700, color: Colors.white)),
                      ),
                      const SizedBox(height: 12),
                      const Text('Book top sports\ncoaches instantly', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: Colors.white, height: 1.2)),
                      const SizedBox(height: 10),
                      Text('Tennis, basketball, yoga and more — find\ncertified trainers near you in seconds.',
                        style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.6), height: 1.6)),
                      const SizedBox(height: 28),
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen())),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: const LinearGradient(colors: [C.accent, C.accentDark]),
                            boxShadow: [BoxShadow(color: C.accent.withOpacity(0.45), offset: const Offset(0, 8), blurRadius: 24)],
                          ),
                          child: const Center(child: Text('Get started  →', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white))),
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen())),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white.withOpacity(0.08)),
                          child: const Center(child: Text('I already have an account', style: TextStyle(fontSize: 14, color: Colors.white54, fontWeight: FontWeight.w500))),
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

// ═══════════════════════════════════════════
// LOGIN SCREEN
// ═══════════════════════════════════════════
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _pass = TextEditingController();
  String? _emailErr, _passErr;
  bool _obscure = true;

  void _login() {
    setState(() {
      _emailErr = _email.text.trim().isEmpty ? 'Please enter your email'
          : !_email.text.contains('@') ? 'Invalid email format' : null;
      _passErr = _pass.text.isEmpty ? 'Please enter your password' : null;
    });
    if (_emailErr != null || _passErr != null) return;
    AppData.userEmail = _email.text.trim();
    AppData.userName = _email.text.split('@').first;
    AppData.userRole = 'client';
    Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (_) => const ClientShell()),
      (route) => false);
  }

  @override
  void dispose() { _email.dispose(); _pass.dispose(); super.dispose(); }

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
              backBtn(context),
              const SizedBox(height: 32),
              const Text('Welcome back!', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: C.text)),
              const SizedBox(height: 6),
              const Text('Sign in to continue booking trainers', style: TextStyle(fontSize: 14, color: C.textSub, height: 1.5)),
              const SizedBox(height: 32),
              sectionLabel('EMAIL'),
              const SizedBox(height: 8),
              inputField('example@gmail.com', _email, error: _emailErr, keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 16),
              sectionLabel('PASSWORD'),
              const SizedBox(height: 8),
              inputField('Your password', _pass, error: _passErr, obscure: _obscure,
                suffix: GestureDetector(
                  onTap: () => setState(() => _obscure = !_obscure),
                  child: Icon(_obscure ? Icons.visibility_off_rounded : Icons.visibility_rounded, color: C.textMuted, size: 20),
                )),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: const Text('Password reset link sent!'), backgroundColor: C.accent,
                      behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))),
                  child: const Text('Forgot password?', style: TextStyle(fontSize: 13, color: C.accent, fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(height: 28),
              gradBtn('Sign In  →', _login),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? ", style: TextStyle(fontSize: 13, color: C.textSub)),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const RegisterScreen())),
                    child: const Text('Sign up', style: TextStyle(fontSize: 13, color: C.accent, fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════
// REGISTER SCREEN
// ═══════════════════════════════════════════
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _role = 'client';
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  String? _nameErr, _emailErr, _phoneErr;

  void _continue() {
    setState(() {
      _nameErr = _name.text.trim().isEmpty ? 'Please enter your name' : null;
      _emailErr = _email.text.trim().isEmpty ? 'Please enter your email'
          : !_email.text.contains('@') ? 'Invalid email format' : null;
      _phoneErr = _phone.text.trim().isEmpty ? 'Please enter your phone number' : null;
    });
    if (_nameErr != null || _emailErr != null || _phoneErr != null) return;

    AppData.userName = _name.text.trim();
    AppData.userEmail = _email.text.trim();
    AppData.userRole = _role;

    Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (_) => _role == 'trainer'
        ? const TrainerShell() : const ClientShell()),
      (route) => false);
  }

  @override
  void dispose() { _name.dispose(); _email.dispose(); _phone.dispose(); super.dispose(); }

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
            border: Border.all(color: sel ? C.accent : Colors.transparent, width: 1.5),
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
                child: Icon(icon, size: 20, color: sel ? Colors.white : C.textMuted),
              ),
              const SizedBox(height: 12),
              Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: sel ? C.accentDark : C.text)),
              const SizedBox(height: 4),
              Text(desc, style: const TextStyle(fontSize: 11, color: C.textSub, height: 1.5)),
            ],
          ),
        ),
      ),
    );
  }

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
              // Progress bar
              Row(
                children: List.generate(4, (i) => Expanded(
                  child: Container(
                    height: 4,
                    margin: EdgeInsets.only(right: i < 3 ? 4 : 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      gradient: i < 2 ? const LinearGradient(colors: [C.accent, C.accentDark]) : null,
                      color: i < 2 ? null : C.surface,
                    ),
                  ),
                )),
              ),
              const SizedBox(height: 20),
              backBtn(context),
              const SizedBox(height: 20),
              const Text('STEP 1 OF 3', style: TextStyle(fontSize: 10, color: C.accent, letterSpacing: 2.5, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              const Text('Create your account', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: C.text)),
              const SizedBox(height: 6),
              const Text('Choose your role and fill in your details', style: TextStyle(fontSize: 14, color: C.textSub, height: 1.5)),
              const SizedBox(height: 24),
              Row(children: [
                _roleCard('Trainer', 'I manage my\nschedule', Icons.fitness_center_rounded, 'trainer'),
                const SizedBox(width: 12),
                _roleCard('Client', 'Looking\nfor a coach', Icons.person_rounded, 'client'),
              ]),
              const SizedBox(height: 24),
              sectionLabel('FULL NAME'),
              const SizedBox(height: 8),
              inputField('Your full name', _name, error: _nameErr),
              const SizedBox(height: 16),
              sectionLabel('EMAIL'),
              const SizedBox(height: 8),
              inputField('example@gmail.com', _email, error: _emailErr, keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 16),
              sectionLabel('PHONE NUMBER'),
              const SizedBox(height: 8),
              inputField('+1 (555) 000-0000', _phone, error: _phoneErr, keyboardType: TextInputType.phone),
              const SizedBox(height: 28),
              gradBtn('Continue  →', _continue),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account? ', style: TextStyle(fontSize: 13, color: C.textSub)),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen())),
                    child: const Text('Sign in', style: TextStyle(fontSize: 13, color: C.accent, fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════
// CLIENT SHELL — Bottom Navigation
// ═══════════════════════════════════════════
class ClientShell extends StatefulWidget {
  const ClientShell({super.key});
  @override
  State<ClientShell> createState() => _ClientShellState();
}

class _ClientShellState extends State<ClientShell> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _tab,
        children: const [
          CatalogScreen(),
          MyBookingsScreen(),
          ChatsListScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 16, offset: const Offset(0, -4))],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                _navItem(Icons.search_rounded, 'Explore', 0),
                _navItem(Icons.calendar_today_rounded, 'Bookings', 1),
                _navItem(Icons.chat_bubble_outline_rounded, 'Chats', 2),
                _navItem(Icons.person_outline_rounded, 'Profile', 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final sel = _tab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _tab = index),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: sel ? BoxDecoration(
            color: C.accentLight,
            borderRadius: BorderRadius.circular(14),
          ) : null,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 22, color: sel ? C.accent : C.textMuted),
              const SizedBox(height: 3),
              Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600,
                color: sel ? C.accent : C.textMuted)),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════
// TRAINER SHELL — Bottom Navigation
// ═══════════════════════════════════════════
class TrainerShell extends StatefulWidget {
  const TrainerShell({super.key});
  @override
  State<TrainerShell> createState() => _TrainerShellState();
}

class _TrainerShellState extends State<TrainerShell> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _tab,
        children: const [
          TrainerDashboardScreen(),
          TrainerClientsScreen(),
          ChatsListScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 16, offset: const Offset(0, -4))],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                _navItem(Icons.calendar_today_rounded, 'Schedule', 0),
                _navItem(Icons.people_outline_rounded, 'Clients', 1),
                _navItem(Icons.chat_bubble_outline_rounded, 'Chats', 2),
                _navItem(Icons.person_outline_rounded, 'Profile', 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final sel = _tab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _tab = index),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: sel ? BoxDecoration(
            color: C.accentLight,
            borderRadius: BorderRadius.circular(14),
          ) : null,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 22, color: sel ? C.accent : C.textMuted),
              const SizedBox(height: 3),
              Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600,
                color: sel ? C.accent : C.textMuted)),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════
// CATALOG SCREEN — with working search
// ═══════════════════════════════════════════
class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});
  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final _search = TextEditingController();
  final List<String> _filters = ['All', 'Training', 'Yoga', 'Tennis', 'Boxing', 'Swimming'];
  int _selectedFilter = 0;

  @override
  void initState() {
    super.initState();
    _search.addListener(() => setState(() {}));
  }

  @override
  void dispose() { _search.dispose(); super.dispose(); }

  List<Map<String, dynamic>> get _filtered {
    var list = AppData.trainers;
    if (_selectedFilter > 0) {
      final kw = _filters[_selectedFilter].toLowerCase();
      list = list.where((t) => (t['sport'] as String).toLowerCase().contains(kw)).toList();
    }
    if (_search.text.trim().isNotEmpty) {
      final q = _search.text.trim().toLowerCase();
      list = list.where((t) =>
        (t['name'] as String).toLowerCase().contains(q) ||
        (t['sport'] as String).toLowerCase().contains(q)
      ).toList();
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hello, ${AppData.userName.split(' ').first.isEmpty ? 'there' : AppData.userName.split(' ').first}! 👋',
                          style: const TextStyle(fontSize: 14, color: C.textSub)),
                        const SizedBox(height: 4),
                        const Text('Find a Trainer', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: C.text)),
                      ],
                    )),
                    GestureDetector(
                      onTap: () => _showFilterSheet(),
                      child: Container(
                        width: 44, height: 44,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [C.accent, C.accentDark]),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.tune_rounded, size: 20, color: Colors.white),
                      ),
                    ),
                  ]),
                  const SizedBox(height: 16),
                  // Real search bar
                  Container(
                    decoration: BoxDecoration(color: C.surface, borderRadius: BorderRadius.circular(14)),
                    child: TextField(
                      controller: _search,
                      style: const TextStyle(fontSize: 14, color: C.text),
                      decoration: InputDecoration(
                        hintText: 'Search trainers by name or sport...',
                        hintStyle: TextStyle(color: C.textMuted.withOpacity(0.8)),
                        prefixIcon: const Icon(Icons.search_rounded, color: C.textMuted, size: 20),
                        suffixIcon: _search.text.isNotEmpty
                          ? GestureDetector(
                              onTap: () => _search.clear(),
                              child: const Icon(Icons.close_rounded, color: C.textMuted, size: 18))
                          : null,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      ),
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
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                            decoration: BoxDecoration(
                              gradient: sel ? const LinearGradient(colors: [C.accent, C.accentDark]) : null,
                              color: sel ? null : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: sel ? Colors.transparent : C.surface, width: 1.5),
                            ),
                            child: Text(_filters[i], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600,
                              color: sel ? Colors.white : C.textSub)),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Expanded(
              child: _filtered.isEmpty
                ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.search_off_rounded, size: 56, color: C.textMuted),
                    const SizedBox(height: 12),
                    const Text('No trainers found', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: C.textSub)),
                    const SizedBox(height: 6),
                    const Text('Try a different search or filter', style: TextStyle(fontSize: 13, color: C.textMuted)),
                  ]))
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                    itemCount: _filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, i) => _trainerCard(_filtered[i]),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(width: 40, height: 4,
              decoration: BoxDecoration(color: C.surface, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 20),
            const Text('Filter Trainers', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: C.text)),
            const SizedBox(height: 16),
            sectionLabel('SPORT'),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8, runSpacing: 8,
              children: List.generate(_filters.length, (i) {
                final sel = _selectedFilter == i;
                return GestureDetector(
                  onTap: () { setState(() => _selectedFilter = i); Navigator.pop(context); },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      gradient: sel ? const LinearGradient(colors: [C.accent, C.accentDark]) : null,
                      color: sel ? null : C.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(_filters[i], style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600,
                      color: sel ? Colors.white : C.textSub)),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _trainerCard(Map<String, dynamic> t) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
        MaterialPageRoute(builder: (_) => TrainerProfileScreen(trainer: t))),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12, offset: const Offset(0, 4))],
        ),
        child: Row(children: [
          Hero(
            tag: 'avatar_${t['name']}',
            child: Container(
              width: 60, height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [(t['color'] as Color).withOpacity(0.15), (t['color'] as Color).withOpacity(0.3)],
                  begin: Alignment.topLeft, end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(Icons.person_rounded, size: 30, color: t['color'] as Color),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Flexible(child: Text(t['name'], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: C.text),
                  overflow: TextOverflow.ellipsis)),
                if (t['tag'] != null) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [C.accent, C.accentDark]),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(t['tag'], style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: 1)),
                  ),
                ],
              ]),
              const SizedBox(height: 3),
              Text(t['sport'], style: const TextStyle(fontSize: 12, color: C.textSub)),
              const SizedBox(height: 6),
              Row(children: [
                const Icon(Icons.star_rounded, size: 14, color: C.accent),
                const SizedBox(width: 3),
                Text('${t['rating']}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: C.text)),
                const SizedBox(width: 4),
                Text('(${t['reviews']})', style: const TextStyle(fontSize: 11, color: C.textMuted)),
              ]),
            ],
          )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('\$${t['price']}/h', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: C.accent)),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => BookingScreen(trainer: t))),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [C.accent, C.accentDark]),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text('Book', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white)),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

// ═══════════════════════════════════════════
// TRAINER PROFILE SCREEN — Enhanced
// ═══════════════════════════════════════════
class TrainerProfileScreen extends StatelessWidget {
  final Map<String, dynamic> trainer;
  const TrainerProfileScreen({super.key, required this.trainer});

  @override
  Widget build(BuildContext context) {
    final color = trainer['color'] as Color;
    final specs = trainer['specs'] as List<String>? ?? [];
    final certs = trainer['certs'] as List<String>? ?? [];
    final bio = trainer['bio'] as String? ?? 'Experienced trainer dedicated to helping you achieve your fitness goals.';

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            backgroundColor: Colors.white,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.9), borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.arrow_back_ios_new_rounded, size: 16, color: C.text),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color.withOpacity(0.15), color.withOpacity(0.35)],
                    begin: Alignment.topLeft, end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    Hero(
                      tag: 'avatar_${trainer['name']}',
                      child: Container(
                        width: 100, height: 100,
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [BoxShadow(color: color.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 8))],
                        ),
                        child: Icon(Icons.person_rounded, size: 55, color: color),
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (trainer['tag'] != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [C.accent, C.accentDark]),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(trainer['tag'], style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: 1)),
                      ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(trainer['name'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: C.text)),
                  const SizedBox(height: 4),
                  Text(trainer['sport'], style: const TextStyle(fontSize: 14, color: C.textSub)),
                  const SizedBox(height: 20),
                  // Stats
                  Row(children: [
                    _stat(Icons.star_rounded, '${trainer['rating']}', 'Rating'),
                    const SizedBox(width: 10),
                    _stat(Icons.chat_bubble_rounded, '${trainer['reviews']}', 'Reviews'),
                    const SizedBox(width: 10),
                    _stat(Icons.schedule_rounded, trainer['exp'] ?? '5 yrs', 'Experience'),
                    const SizedBox(width: 10),
                    _stat(Icons.people_rounded, '${trainer['clients'] ?? 100}', 'Clients'),
                  ]),
                  const SizedBox(height: 28),

                  // About
                  const Text('About', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: C.text)),
                  const SizedBox(height: 10),
                  Text(bio, style: const TextStyle(fontSize: 14, color: C.textSub, height: 1.7)),
                  const SizedBox(height: 24),

                  // Specializations
                  if (specs.isNotEmpty) ...[
                    const Text('Specializations', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: C.text)),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8, runSpacing: 8,
                      children: specs.map((s) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(color: C.accentLight, borderRadius: BorderRadius.circular(10)),
                        child: Text(s, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: C.accent)),
                      )).toList(),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Certifications
                  if (certs.isNotEmpty) ...[
                    const Text('Certifications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: C.text)),
                    const SizedBox(height: 12),
                    ...certs.map((c) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(children: [
                        Container(
                          width: 32, height: 32,
                          decoration: BoxDecoration(color: C.green.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                          child: const Icon(Icons.verified_rounded, size: 16, color: C.green),
                        ),
                        const SizedBox(width: 10),
                        Text(c, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: C.text)),
                      ]),
                    )),
                    const SizedBox(height: 20),
                  ],

                  // Reviews
                  Row(children: [
                    const Text('Reviews', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: C.text)),
                    const Spacer(),
                    Text('${trainer['reviews']} total', style: const TextStyle(fontSize: 12, color: C.textMuted)),
                  ]),
                  const SizedBox(height: 14),
                  ...AppData.reviews.map((r) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _reviewCard(r['name'], r['stars'], r['text'], r['ago']),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 16, offset: const Offset(0, -4))],
        ),
        child: Row(children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Price', style: TextStyle(fontSize: 11, color: C.textMuted)),
              Text('\$${trainer['price']}/h', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: C.accent)),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => BookingScreen(trainer: trainer))),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(colors: [C.accent, C.accentDark]),
                  boxShadow: [BoxShadow(color: C.accent.withOpacity(0.35), offset: const Offset(0, 6), blurRadius: 20)],
                ),
                child: const Center(child: Text('Book Session  →', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white))),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _stat(IconData icon, String value, String label) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(color: C.surface, borderRadius: BorderRadius.circular(14)),
      child: Column(children: [
        Icon(icon, size: 18, color: C.accent),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: C.text)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 9, color: C.textMuted)),
      ]),
    ),
  );

  Widget _reviewCard(String name, int stars, String text, String ago) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: C.surface, borderRadius: BorderRadius.circular(16)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(color: C.accent.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
            child: Center(child: Text(name[0], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: C.accent))),
          ),
          const SizedBox(width: 10),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: C.text)),
              Text(ago, style: const TextStyle(fontSize: 10, color: C.textMuted)),
            ],
          )),
          Row(children: List.generate(5, (i) => Icon(Icons.star_rounded, size: 14,
            color: i < stars ? C.accent : C.surface))),
        ]),
        const SizedBox(height: 10),
        Text(text, style: const TextStyle(fontSize: 13, color: C.textSub, height: 1.5)),
      ],
    ),
  );
}

// ═══════════════════════════════════════════
// BOOKING SCREEN
// ═══════════════════════════════════════════
class BookingScreen extends StatefulWidget {
  final Map<String, dynamic> trainer;
  const BookingScreen({super.key, required this.trainer});
  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String _type = 'Individual';
  int _selectedDate = 0;
  int _selectedTime = -1;
  final List<String> _times = ['09:00', '10:00', '11:00', '14:00', '15:00', '16:00', '17:00', '18:00'];

  @override
  Widget build(BuildContext context) {
    final t = widget.trainer;
    final now = DateTime.now();
    final days = List.generate(14, (i) => now.add(Duration(days: i)));
    final dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
            child: Row(children: [
              backBtn(context),
              const SizedBox(width: 12),
              const Text('Book Session', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: C.text)),
            ]),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Trainer mini card
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: C.surface, borderRadius: BorderRadius.circular(16)),
                    child: Row(children: [
                      Container(
                        width: 44, height: 44,
                        decoration: BoxDecoration(
                          color: (t['color'] as Color).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.person_rounded, size: 24, color: t['color'] as Color),
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(t['name'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: C.text)),
                          Text(t['sport'], style: const TextStyle(fontSize: 12, color: C.textSub)),
                        ],
                      )),
                      Text('\$${t['price']}/h', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: C.accent)),
                    ]),
                  ),
                  const SizedBox(height: 24),

                  sectionLabel('SESSION TYPE'),
                  const SizedBox(height: 10),
                  Row(children: [
                    _typeCard('Individual', Icons.person_rounded),
                    const SizedBox(width: 12),
                    _typeCard('Group', Icons.group_rounded),
                  ]),
                  const SizedBox(height: 24),

                  sectionLabel('SELECT DATE'),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 80,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 14,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (_, i) {
                        final sel = _selectedDate == i;
                        final isToday = i == 0;
                        return GestureDetector(
                          onTap: () => setState(() { _selectedDate = i; _selectedTime = -1; }),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            width: 60,
                            decoration: BoxDecoration(
                              gradient: sel ? const LinearGradient(colors: [C.accent, C.accentDark]) : null,
                              color: sel ? null : C.surface,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(isToday ? 'Today' : dayNames[(days[i].weekday - 1) % 7],
                                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600,
                                    color: sel ? Colors.white70 : C.textMuted)),
                                const SizedBox(height: 4),
                                Text('${days[i].day}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800,
                                  color: sel ? Colors.white : C.text)),
                                Text(monthNames[days[i].month - 1], style: TextStyle(fontSize: 9,
                                  color: sel ? Colors.white54 : C.textMuted)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  sectionLabel('SELECT TIME'),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10, runSpacing: 10,
                    children: List.generate(_times.length, (i) {
                      final sel = _selectedTime == i;
                      // Simulate some slots being taken
                      final taken = (_selectedDate + i) % 5 == 0;
                      return GestureDetector(
                        onTap: taken ? null : () => setState(() => _selectedTime = i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                          decoration: BoxDecoration(
                            gradient: sel ? const LinearGradient(colors: [C.accent, C.accentDark]) : null,
                            color: sel ? null : taken ? const Color(0xFFEEEEEE) : C.surface,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(_times[i], style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,
                            color: sel ? Colors.white : taken ? C.textMuted : C.textSub,
                            decoration: taken ? TextDecoration.lineThrough : null)),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 28),

                  // Summary
                  if (_selectedTime >= 0)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: C.accentLight,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: C.accent.withOpacity(0.2)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Booking Summary', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: C.text)),
                          const SizedBox(height: 10),
                          _summaryRow('Trainer', t['name']),
                          _summaryRow('Type', _type),
                          _summaryRow('Date', '${dayNames[(days[_selectedDate].weekday - 1) % 7]}, ${days[_selectedDate].day} ${monthNames[days[_selectedDate].month - 1]}'),
                          _summaryRow('Time', '${_times[_selectedTime]} — ${_selectedTime < _times.length - 1 ? _times[_selectedTime + 1] : '19:00'}'),
                          const Divider(height: 20),
                          _summaryRow('Total', '\$${t['price']}', bold: true),
                        ],
                      ),
                    ),
                  const SizedBox(height: 20),

                  gradBtn('Confirm Booking  →', _selectedTime < 0 ? null : () {
                    // Add to bookings
                    AppData.myBookings.insert(0, {
                      'trainer': t['name'],
                      'sport': t['sport'],
                      'type': _type,
                      'date': '${dayNames[(days[_selectedDate].weekday - 1) % 7]}, ${days[_selectedDate].day} ${monthNames[days[_selectedDate].month - 1]}',
                      'time': '${_times[_selectedTime]} — ${_selectedTime < _times.length - 1 ? _times[_selectedTime + 1] : '19:00'}',
                      'price': t['price'],
                      'status': 'confirmed',
                      'color': t['color'],
                      'trainerData': t,
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(children: [
                          const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
                          const SizedBox(width: 8),
                          const Text('Booking confirmed!'),
                        ]),
                        backgroundColor: C.green,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    );
                    Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(trainer: t)));
                  }, enabled: _selectedTime >= 0),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _typeCard(String label, IconData icon) {
    final sel = _type == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _type = label),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: sel ? C.accentLight : C.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: sel ? C.accent : Colors.transparent, width: 1.5),
          ),
          child: Column(children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color: sel ? C.accent : const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 20, color: sel ? Colors.white : C.textMuted),
            ),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: sel ? C.accentDark : C.text)),
          ]),
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool bold = false}) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: bold ? C.text : C.textSub, fontWeight: bold ? FontWeight.w700 : null)),
        Text(value, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: bold ? C.accent : C.text)),
      ],
    ),
  );
}

// ═══════════════════════════════════════════
// MY BOOKINGS SCREEN (Client)
// ═══════════════════════════════════════════
class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});
  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final upcoming = AppData.myBookings.where((b) => b['status'] == 'confirmed').toList();
    final past = AppData.myBookings.where((b) => b['status'] == 'completed').toList();
    final list = _tab == 0 ? upcoming : past;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('My Bookings', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: C.text)),
                  const SizedBox(height: 16),
                  Row(children: [
                    _tabChip('Upcoming', 0),
                    const SizedBox(width: 8),
                    _tabChip('Past', 1),
                  ]),
                ],
              ),
            ),
            Expanded(
              child: list.isEmpty
                ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(_tab == 0 ? Icons.calendar_today_rounded : Icons.history_rounded,
                      size: 56, color: C.textMuted),
                    const SizedBox(height: 12),
                    Text(_tab == 0 ? 'No upcoming bookings' : 'No past sessions',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: C.textSub)),
                    const SizedBox(height: 6),
                    Text(_tab == 0 ? 'Book a session to get started!' : 'Your completed sessions will appear here',
                      style: const TextStyle(fontSize: 13, color: C.textMuted)),
                  ]))
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, i) => _bookingCard(list[i]),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabChip(String label, int index) {
    final sel = _tab == index;
    return GestureDetector(
      onTap: () => setState(() => _tab = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          gradient: sel ? const LinearGradient(colors: [C.accent, C.accentDark]) : null,
          color: sel ? null : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: sel ? Colors.transparent : C.surface, width: 1.5),
        ),
        child: Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: sel ? Colors.white : C.textSub)),
      ),
    );
  }

  Widget _bookingCard(Map<String, dynamic> b) {
    final color = b['color'] as Color? ?? C.accent;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          Row(children: [
            Container(
              width: 48, height: 48,
              decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(14)),
              child: Icon(Icons.person_rounded, size: 26, color: color),
            ),
            const SizedBox(width: 14),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(b['trainer'] ?? '', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: C.text)),
                Text('${b['sport']} · ${b['type']}', style: const TextStyle(fontSize: 12, color: C.textSub)),
              ],
            )),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: b['status'] == 'confirmed' ? C.green.withOpacity(0.1) : C.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                b['status'] == 'confirmed' ? 'Confirmed' : 'Completed',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700,
                  color: b['status'] == 'confirmed' ? C.green : C.textSub),
              ),
            ),
          ]),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: C.surface, borderRadius: BorderRadius.circular(12)),
            child: Row(children: [
              const Icon(Icons.calendar_today_rounded, size: 14, color: C.textSub),
              const SizedBox(width: 6),
              Text(b['date'] ?? '', style: const TextStyle(fontSize: 12, color: C.text, fontWeight: FontWeight.w600)),
              const SizedBox(width: 16),
              const Icon(Icons.access_time_rounded, size: 14, color: C.textSub),
              const SizedBox(width: 6),
              Expanded(child: Text(b['time'] ?? '', style: const TextStyle(fontSize: 12, color: C.text, fontWeight: FontWeight.w600))),
              Text('\$${b['price']}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: C.accent)),
            ]),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              final trainerData = b['trainerData'] as Map<String, dynamic>?;
              if (trainerData != null) {
                Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(trainer: trainerData)));
              }
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [C.accent, C.accentDark]),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(child: Text('Message Trainer', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white))),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
// CHATS LIST SCREEN
// ═══════════════════════════════════════════
class ChatsListScreen extends StatelessWidget {
  const ChatsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Generate chats from trainers
    final chats = AppData.trainers.take(4).map((t) => {
      'name': t['name'],
      'sport': t['sport'],
      'color': t['color'],
      'lastMsg': 'Looking forward to our session!',
      'time': '10:${(10 + AppData.trainers.indexOf(t) * 5).toString().padLeft(2, '0')}',
      'unread': AppData.trainers.indexOf(t) < 2 ? 1 : 0,
      'trainerData': t,
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
              child: const Text('Messages', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: C.text)),
            ),
            Expanded(
              child: chats.isEmpty
                ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.chat_bubble_outline_rounded, size: 56, color: C.textMuted),
                    const SizedBox(height: 12),
                    const Text('No messages yet', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: C.textSub)),
                  ]))
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 24),
                    itemCount: chats.length,
                    separatorBuilder: (_, __) => Divider(height: 1, indent: 86, color: C.surface),
                    itemBuilder: (_, i) {
                      final c = chats[i];
                      final color = c['color'] as Color;
                      return GestureDetector(
                        onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => ChatScreen(trainer: c['trainerData'] as Map<String, dynamic>))),
                        behavior: HitTestBehavior.opaque,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          child: Row(children: [
                            Container(
                              width: 50, height: 50,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [color.withOpacity(0.2), color.withOpacity(0.4)]),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Stack(children: [
                                Center(child: Icon(Icons.person_rounded, size: 26, color: color)),
                                Positioned(right: 2, bottom: 2, child: Container(
                                  width: 10, height: 10,
                                  decoration: BoxDecoration(color: C.green, shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 2)),
                                )),
                              ]),
                            ),
                            const SizedBox(width: 14),
                            Expanded(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(c['name'] as String, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: C.text)),
                                const SizedBox(height: 3),
                                Text(c['lastMsg'] as String, style: const TextStyle(fontSize: 13, color: C.textSub),
                                  maxLines: 1, overflow: TextOverflow.ellipsis),
                              ],
                            )),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(c['time'] as String, style: const TextStyle(fontSize: 11, color: C.textMuted)),
                                const SizedBox(height: 4),
                                if ((c['unread'] as int) > 0)
                                  Container(
                                    width: 20, height: 20,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(colors: [C.accent, C.accentDark]),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(child: Text('${c['unread']}', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white))),
                                  ),
                              ],
                            ),
                          ]),
                        ),
                      );
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════
// CHAT SCREEN
// ═══════════════════════════════════════════
class ChatScreen extends StatefulWidget {
  final Map<String, dynamic> trainer;
  const ChatScreen({super.key, required this.trainer});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  late final List<Map<String, dynamic>> _messages;
  bool _typing = false;

  final _replies = [
    'Got it! See you at the session! 💪',
    'Sounds great! Can\'t wait to work together!',
    'Perfect, I\'ll prepare the program for you!',
    'Awesome! Remember to bring water and a towel 😊',
    'Thanks for the message! Let me know if you have any questions.',
    'Sure thing! We\'ll have a great workout!',
  ];

  @override
  void initState() {
    super.initState();
    final sport = widget.trainer['sport'].toString().toLowerCase();
    _messages = [
      {'text': 'Hi! Thanks for booking a session with me! 🎉', 'isMe': false, 'time': '10:00'},
      {'text': 'Looking forward to our $sport session!', 'isMe': false, 'time': '10:01'},
      {'text': 'Can\'t wait! What should I bring?', 'isMe': true, 'time': '10:02'},
      {'text': 'Just comfortable clothes and a water bottle. I\'ll handle the rest! 💪', 'isMe': false, 'time': '10:03'},
    ];
  }

  @override
  void dispose() { _controller.dispose(); _scrollController.dispose(); super.dispose(); }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    final now = TimeOfDay.now();
    final time = '${now.hour}:${now.minute.toString().padLeft(2, '0')}';
    setState(() {
      _messages.add({'text': text, 'isMe': true, 'time': time});
      _controller.clear();
    });
    _scrollToBottom();

    // Typing indicator
    setState(() => _typing = true);
    _scrollToBottom();

    Future.delayed(Duration(milliseconds: 800 + Random().nextInt(1200)), () {
      if (mounted) {
        final rNow = TimeOfDay.now();
        setState(() {
          _typing = false;
          _messages.add({
            'text': _replies[Random().nextInt(_replies.length)],
            'isMe': false,
            'time': '${rNow.hour}:${rNow.minute.toString().padLeft(2, '0')}',
          });
        });
        _scrollToBottom();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.trainer;
    final color = t['color'] as Color;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(children: [
          // Header
          Container(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
            ),
            child: Row(children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(color: C.surface, borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.arrow_back_ios_new_rounded, size: 16, color: C.textSub),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 42, height: 42,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [color.withOpacity(0.3), color.withOpacity(0.5)]),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(Icons.person_rounded, size: 22, color: color),
              ),
              const SizedBox(width: 12),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(t['name'], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: C.text)),
                  Row(children: [
                    Container(width: 7, height: 7,
                      decoration: const BoxDecoration(color: C.green, shape: BoxShape.circle)),
                    const SizedBox(width: 5),
                    const Text('Online', style: TextStyle(fontSize: 11, color: C.textSub)),
                  ]),
                ],
              )),
              GestureDetector(
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: const Text('Voice call coming soon!'), backgroundColor: C.accent,
                    behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))),
                child: Container(
                  width: 38, height: 38,
                  decoration: BoxDecoration(color: C.surface, borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.phone_rounded, size: 18, color: C.textSub),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: const Text('Video call coming soon!'), backgroundColor: C.accent,
                    behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))),
                child: Container(
                  width: 38, height: 38,
                  decoration: BoxDecoration(color: C.surface, borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.videocam_rounded, size: 18, color: C.textSub),
                ),
              ),
            ]),
          ),

          // Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
              itemCount: _messages.length + (_typing ? 1 : 0),
              itemBuilder: (_, i) {
                if (i == _messages.length && _typing) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(color: C.surface, borderRadius: BorderRadius.circular(16)),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        _dot(0), const SizedBox(width: 4),
                        _dot(1), const SizedBox(width: 4),
                        _dot(2),
                      ]),
                    ),
                  );
                }
                final m = _messages[i];
                final isMe = m['isMe'] as bool;
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.72),
                    decoration: BoxDecoration(
                      gradient: isMe ? const LinearGradient(colors: [C.accent, C.accentDark]) : null,
                      color: isMe ? null : C.surface,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16), topRight: const Radius.circular(16),
                        bottomLeft: Radius.circular(isMe ? 16 : 4),
                        bottomRight: Radius.circular(isMe ? 4 : 16),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(m['text'], style: TextStyle(fontSize: 14, color: isMe ? Colors.white : C.text, height: 1.4)),
                        const SizedBox(height: 3),
                        Row(mainAxisSize: MainAxisSize.min, children: [
                          Text(m['time'], style: TextStyle(fontSize: 10, color: isMe ? Colors.white54 : C.textMuted)),
                          if (isMe) ...[
                            const SizedBox(width: 4),
                            Icon(Icons.done_all_rounded, size: 14, color: Colors.white.withOpacity(0.6)),
                          ],
                        ]),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Input
          Container(
            padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, -2))],
            ),
            child: Row(children: [
              GestureDetector(
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: const Text('Attachments coming soon!'), backgroundColor: C.accent,
                    behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))),
                child: Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(color: C.surface, borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.add_rounded, size: 20, color: C.textSub),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(color: C.surface, borderRadius: BorderRadius.circular(24)),
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (_) => _send(),
                    style: const TextStyle(fontSize: 14, color: C.text),
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: TextStyle(color: C.textMuted),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: _send,
                child: Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [C.accent, C.accentDark]),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [BoxShadow(color: C.accent.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))],
                  ),
                  child: const Icon(Icons.send_rounded, size: 20, color: Colors.white),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget _dot(int i) => TweenAnimationBuilder<double>(
    tween: Tween(begin: 0, end: 1),
    duration: Duration(milliseconds: 600 + i * 200),
    builder: (_, v, child) => Opacity(
      opacity: (sin(v * 3.14 * 2) + 1) / 2 * 0.6 + 0.4,
      child: child,
    ),
    child: Container(width: 8, height: 8,
      decoration: BoxDecoration(color: C.textMuted, shape: BoxShape.circle)),
  );
}

// ═══════════════════════════════════════════
// TRAINER DASHBOARD
// ═══════════════════════════════════════════
class TrainerDashboardScreen extends StatefulWidget {
  const TrainerDashboardScreen({super.key});
  @override
  State<TrainerDashboardScreen> createState() => _TrainerDashboardScreenState();
}

class _TrainerDashboardScreenState extends State<TrainerDashboardScreen> {
  int _tab = 0;

  final List<Map<String, dynamic>> _bookings = [
    {'client': 'Sarah Mitchell', 'type': 'Individual', 'date': 'Today', 'time': '09:00 – 10:00', 'status': 'confirmed', 'color': C.accent, 'price': 60},
    {'client': 'David Kim', 'type': 'Group', 'date': 'Today', 'time': '14:00 – 15:00', 'status': 'confirmed', 'color': C.purple, 'price': 45},
    {'client': 'Anna Lopez', 'type': 'Individual', 'date': 'Tomorrow', 'time': '10:00 – 11:00', 'status': 'pending', 'color': C.sky, 'price': 60},
    {'client': 'Mark Johnson', 'type': 'Individual', 'date': 'Tomorrow', 'time': '16:00 – 17:00', 'status': 'confirmed', 'color': C.teal, 'price': 55},
    {'client': 'Emily Chen', 'type': 'Group', 'date': 'Mar 28', 'time': '11:00 – 12:00', 'status': 'pending', 'color': C.red, 'price': 45},
  ];

  List<Map<String, dynamic>> get _filtered {
    if (_tab == 0) return _bookings;
    if (_tab == 1) return _bookings.where((b) => b['status'] == 'confirmed').toList();
    return _bookings.where((b) => b['status'] == 'pending').toList();
  }

  @override
  Widget build(BuildContext context) {
    final confirmed = _bookings.where((b) => b['status'] == 'confirmed').length;
    final pending = _bookings.where((b) => b['status'] == 'pending').length;
    final earnings = _bookings.where((b) => b['status'] == 'confirmed').fold(0, (sum, b) => sum + (b['price'] as int));

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hello, ${AppData.userName.split(' ').first.isEmpty ? 'Coach' : AppData.userName.split(' ').first}! 🔥',
                          style: const TextStyle(fontSize: 14, color: C.textSub)),
                        const SizedBox(height: 4),
                        const Text('My Schedule', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: C.text)),
                      ],
                    )),
                    GestureDetector(
                      onTap: () => _showNotifications(),
                      child: Container(
                        width: 44, height: 44,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [C.accent, C.accentDark]),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Stack(children: [
                          const Center(child: Icon(Icons.notifications_rounded, size: 20, color: Colors.white)),
                          if (pending > 0) Positioned(right: 8, top: 8, child: Container(
                            width: 14, height: 14,
                            decoration: const BoxDecoration(color: C.red, shape: BoxShape.circle),
                            child: Center(child: Text('$pending', style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w700, color: Colors.white))),
                          )),
                        ]),
                      ),
                    ),
                  ]),
                  const SizedBox(height: 16),
                  // Earnings card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [C.accent, C.accentDark]),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(children: [
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('This week\'s earnings', style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.7))),
                          const SizedBox(height: 4),
                          Text('\$$earnings', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white)),
                        ],
                      )),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                        child: Row(children: [
                          const Icon(Icons.trending_up_rounded, size: 14, color: Colors.white),
                          const SizedBox(width: 4),
                          Text('+12%', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white)),
                        ]),
                      ),
                    ]),
                  ),
                  const SizedBox(height: 16),
                  Row(children: [
                    _statPill(Icons.check_circle_rounded, '$confirmed Confirmed', C.green),
                    const SizedBox(width: 10),
                    _statPill(Icons.schedule_rounded, '$pending Pending', C.yellow),
                    const SizedBox(width: 10),
                    _statPill(Icons.people_rounded, '${_bookings.length} Total', C.textSub),
                  ]),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 34,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _tabChip('All', 0), const SizedBox(width: 8),
                        _tabChip('Confirmed', 1), const SizedBox(width: 8),
                        _tabChip('Pending', 2),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Expanded(
              child: _filtered.isEmpty
                ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.calendar_today_rounded, size: 48, color: C.textMuted),
                    const SizedBox(height: 12),
                    const Text('No bookings yet', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: C.textSub)),
                  ]))
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                    itemCount: _filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, i) => _bookingCard(_filtered[i]),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNotifications() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(width: 40, height: 4,
              decoration: BoxDecoration(color: C.surface, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 20),
            const Text('Notifications', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: C.text)),
            const SizedBox(height: 16),
            _notifItem(Icons.person_add_rounded, 'New booking request from Anna Lopez', '5 min ago', C.sky),
            _notifItem(Icons.schedule_rounded, 'Reminder: Session with Sarah at 9:00', '1 hour ago', C.accent),
            _notifItem(Icons.star_rounded, 'David left you a 5-star review!', '3 hours ago', C.yellow),
            _notifItem(Icons.person_add_rounded, 'New booking request from Emily Chen', 'Yesterday', C.red),
          ],
        ),
      ),
    );
  }

  Widget _notifItem(IconData icon, String text, String time, Color color) => Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Row(children: [
      Container(
        width: 40, height: 40,
        decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, size: 18, color: color),
      ),
      const SizedBox(width: 12),
      Expanded(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text, style: const TextStyle(fontSize: 13, color: C.text, height: 1.4)),
          Text(time, style: const TextStyle(fontSize: 11, color: C.textMuted)),
        ],
      )),
    ]),
  );

  Widget _statPill(IconData icon, String label, Color color) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 5),
          Flexible(child: Text(label, overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: color))),
        ],
      ),
    ),
  );

  Widget _tabChip(String label, int index) {
    final sel = _tab == index;
    return GestureDetector(
      onTap: () => setState(() => _tab = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          gradient: sel ? const LinearGradient(colors: [C.accent, C.accentDark]) : null,
          color: sel ? null : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: sel ? Colors.transparent : C.surface, width: 1.5),
        ),
        child: Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: sel ? Colors.white : C.textSub)),
      ),
    );
  }

  Widget _bookingCard(Map<String, dynamic> b) {
    final isConfirmed = b['status'] == 'confirmed';
    final isPending = b['status'] == 'pending';
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Column(children: [
        Row(children: [
          Container(
            width: 50, height: 50,
            decoration: BoxDecoration(
              color: (b['color'] as Color).withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(Icons.person_rounded, size: 26, color: b['color'] as Color),
          ),
          const SizedBox(width: 14),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(b['client'], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: C.text)),
              const SizedBox(height: 3),
              Text('${b['type']} · ${b['date']}', style: const TextStyle(fontSize: 12, color: C.textSub)),
              const SizedBox(height: 4),
              Row(children: [
                const Icon(Icons.access_time_rounded, size: 13, color: C.textMuted),
                const SizedBox(width: 4),
                Text(b['time'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: C.text)),
              ]),
            ],
          )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isConfirmed ? C.green.withOpacity(0.1) : const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  isConfirmed ? 'Confirmed' : 'Pending',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700,
                    color: isConfirmed ? C.green : const Color(0xFFD97706)),
                ),
              ),
              const SizedBox(height: 4),
              Text('\$${b['price']}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: C.accent)),
            ],
          ),
        ]),
        const SizedBox(height: 12),
        if (isPending)
          Row(children: [
            Expanded(child: GestureDetector(
              onTap: () {
                setState(() => b['status'] = 'confirmed');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Booking with ${b['client']} confirmed!'), backgroundColor: C.green,
                    behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [C.green, Color(0xFF16A34A)]),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(child: Text('Accept', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white))),
              ),
            )),
            const SizedBox(width: 10),
            Expanded(child: GestureDetector(
              onTap: () {
                setState(() => _bookings.remove(b));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Booking with ${b['client']} declined'), backgroundColor: C.red,
                    behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: C.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(child: Text('Decline', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: C.red))),
              ),
            )),
          ])
        else
          GestureDetector(
            onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => ChatScreen(trainer: {
                'name': b['client'], 'sport': 'Session', 'color': b['color'],
              }))),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [C.accent, C.accentDark]),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(child: Text('Chat', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white))),
            ),
          ),
      ]),
    );
  }
}

// ═══════════════════════════════════════════
// TRAINER CLIENTS SCREEN
// ═══════════════════════════════════════════
class TrainerClientsScreen extends StatelessWidget {
  const TrainerClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final clients = [
      {'name': 'Sarah Mitchell', 'sessions': 12, 'since': 'Jan 2026', 'color': C.accent},
      {'name': 'David Kim', 'sessions': 8, 'since': 'Feb 2026', 'color': C.purple},
      {'name': 'Anna Lopez', 'sessions': 3, 'since': 'Mar 2026', 'color': C.sky},
      {'name': 'Mark Johnson', 'sessions': 15, 'since': 'Dec 2025', 'color': C.teal},
      {'name': 'Emily Chen', 'sessions': 5, 'since': 'Feb 2026', 'color': C.red},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('My Clients', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: C.text)),
                  const SizedBox(height: 4),
                  Text('${clients.length} active clients', style: const TextStyle(fontSize: 14, color: C.textSub)),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                itemCount: clients.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) {
                  final c = clients[i];
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12, offset: const Offset(0, 4))],
                    ),
                    child: Row(children: [
                      Container(
                        width: 50, height: 50,
                        decoration: BoxDecoration(
                          color: (c['color'] as Color).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(child: Text((c['name'] as String)[0],
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: c['color'] as Color))),
                      ),
                      const SizedBox(width: 14),
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(c['name'] as String, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: C.text)),
                          const SizedBox(height: 3),
                          Text('${c['sessions']} sessions · Since ${c['since']}', style: const TextStyle(fontSize: 12, color: C.textSub)),
                        ],
                      )),
                      GestureDetector(
                        onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => ChatScreen(trainer: {
                            'name': c['name'], 'sport': 'Client', 'color': c['color'],
                          }))),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [C.accent, C.accentDark]),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.chat_bubble_rounded, size: 16, color: Colors.white),
                        ),
                      ),
                    ]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════
// PROFILE SCREEN
// ═══════════════════════════════════════════
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
                child: Column(children: [
                  Container(
                    width: 80, height: 80,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [C.accent, C.accentDark]),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [BoxShadow(color: C.accent.withOpacity(0.3), blurRadius: 16, offset: const Offset(0, 6))],
                    ),
                    child: Center(child: Text(
                      AppData.userName.isNotEmpty ? AppData.userName[0].toUpperCase() : 'U',
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: Colors.white),
                    )),
                  ),
                  const SizedBox(height: 16),
                  Text(AppData.userName.isEmpty ? 'User' : AppData.userName,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: C.text)),
                  const SizedBox(height: 4),
                  Text(AppData.userEmail.isEmpty ? 'user@email.com' : AppData.userEmail,
                    style: const TextStyle(fontSize: 13, color: C.textSub)),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: C.accentLight,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(AppData.userRole == 'trainer' ? '🏋️ Trainer' : '👤 Client',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: C.accent)),
                  ),
                ]),
              ),
              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: Column(children: [
                  _settingsRow(Icons.person_outline_rounded, 'Edit Profile', () =>
                    ScaffoldMessenger.of(context).showSnackBar(_snack('Profile editing coming soon!'))),
                  _divider(),
                  _settingsRow(Icons.notifications_outlined, 'Notifications', () =>
                    ScaffoldMessenger.of(context).showSnackBar(_snack('Notification settings coming soon!'))),
                  _divider(),
                  _settingsRow(Icons.payment_outlined, 'Payment Methods', () =>
                    ScaffoldMessenger.of(context).showSnackBar(_snack('Payment settings coming soon!'))),
                  _divider(),
                  _settingsRow(Icons.help_outline_rounded, 'Help & Support', () =>
                    ScaffoldMessenger.of(context).showSnackBar(_snack('Help center coming soon!'))),
                  _divider(),
                  _settingsRow(Icons.info_outline_rounded, 'About FitBook', () =>
                    ScaffoldMessenger.of(context).showSnackBar(_snack('FitBook v1.0 — Find your perfect trainer!'))),
                ]),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GestureDetector(
                  onTap: () => Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (_) => const OnboardingScreen()), (route) => false),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: C.red.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(child: Text('Log Out',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: C.red))),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  SnackBar _snack(String msg) => SnackBar(
    content: Text(msg), backgroundColor: C.accent,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  );

  Widget _settingsRow(IconData icon, String label, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.opaque,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(children: [
        Container(
          width: 36, height: 36,
          decoration: BoxDecoration(color: C.surface, borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, size: 18, color: C.text),
        ),
        const SizedBox(width: 14),
        Expanded(child: Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: C.text))),
        const Icon(Icons.chevron_right_rounded, size: 20, color: C.textMuted),
      ]),
    ),
  );

  Widget _divider() => Divider(height: 1, indent: 70, color: C.surface);
}
