import 'package:firebase_auth/firebase_auth.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:login/api/firebase_api.dart';

class loginPage extends StatefulWidget {
  Firebase_api firebaseApi = Firebase_api();

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  var fullNameInput = TextEditingController();
  var passwordInput = TextEditingController();

  static const Color background = Color(0xFF2C1B36);
  static const Color backgroundDeep = Color(0xFF1B0F22);
  static const Color gold = Color(0xFFD9A659);
  static const Color goldDeep = Color(0xFFC4894A);
  static const Color blush = Color(0xFFF3D9D0);
  static const Color cardColor = Color(0xFF3A2545);

  String? docID;
  bool _obscurePassword = true;
  bool _isLoggingIn = false;

  void snackBarMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundDeep,
        content: Text(
          message,
          style: const TextStyle(color: blush),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void login() async {
    String userEmail = fullNameInput.text.toString().trim();
    String userPassword = passwordInput.text.toString().trim();

    print(" ");
    print("3) clicked on login button: $docID");
    print(" ");

    if (userEmail == "" || userPassword == "") {
      snackBarMessage(context, 'Please input email and password.');
      return;
    } else if (userEmail == "") {
      snackBarMessage(context, 'Please input email');
      return;
    } else if (userPassword == "") {
      snackBarMessage(context, 'Please input password');
      return;
    } else {
      setState(() => _isLoggingIn = true);
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: userEmail, password: userPassword);
        if (userCredential.user != null) {
          User? currentUser = FirebaseAuth.instance.currentUser;
          String? ID = currentUser?.uid;
          docID = ID;

          print(" ");
          print(" ");
          print(" ");
          print("going to sadik's page");
          print(" ");
          print("3) clicked on login button: $docID");
          print(" ");
          print(" ");
          print(" ");
          Future.delayed(Duration(seconds: 2), () {
            if (!mounted) return;
            setState(() => _isLoggingIn = false);
            Navigator.pushNamed(
              context,
              '/mainPage',
              arguments: {
                'docID': docID,
              },
            );
          });
        }
      } on FirebaseAuthException catch (ex) {
        if (mounted) setState(() => _isLoggingIn = false);
        snackBarMessage(context, 'Invalid user credentials.');
        print(ex.code.toString());
        print(" ");
        print(" ");
        print(" ");
        print(" ");
        print("3) clicked on login button: $docID");
        print(" ");
        print(" ");
        print(" ");
        print(" ");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print(" ");
    print("1) docID before map: $docID");
    print(" ");

    final Map<String, dynamic>? args =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && args.containsKey('docID')) {
      docID = args['docID']!;
    }

    print(" ");
    print("2) docID after map: $docID");
    print(" ");

    return Scaffold(
      backgroundColor: backgroundDeep,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.4),
            radius: 1.3,
            colors: [background, backgroundDeep],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Ambient corner glows for soft depth
              Positioned(
                top: -70,
                right: -50,
                child: _GlowCircle(color: gold.withValues(alpha: 0.07), size: 220),
              ),
              Positioned(
                bottom: -90,
                left: -70,
                child: _GlowCircle(color: blush.withValues(alpha: 0.05), size: 260),
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 36),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(28, 8, 28, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              FadeInUp(
                                duration: const Duration(milliseconds: 700),
                                child: Text(
                                  'WELCOME BACK',
                                  style: TextStyle(
                                    color: blush.withValues(alpha: 0.7),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 3,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              FadeInUp(
                                duration: const Duration(milliseconds: 900),
                                child: ShaderMask(
                                  shaderCallback: (bounds) => LinearGradient(
                                    colors: [blush, gold],
                                  ).createShader(bounds),
                                  child: const Text(
                                    'Sign in',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          FadeInUp(
                            duration: const Duration(milliseconds: 900),
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: gold.withValues(alpha: 0.35),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: gold.withValues(alpha: 0.12),
                                    blurRadius: 24,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.favorite_rounded,
                                color: gold,
                                size: 26,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 36),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: FadeInUp(
                        duration: const Duration(milliseconds: 1100),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(22, 28, 22, 28),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.06),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.25),
                                blurRadius: 30,
                                offset: const Offset(0, 14),
                              ),
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              _PremiumField(
                                controller: fullNameInput,
                                hint: 'Email or phone number',
                                icon: Icons.alternate_email_rounded,
                                gold: gold,
                              ),
                              const SizedBox(height: 16),
                              _PremiumField(
                                controller: passwordInput,
                                hint: 'Password',
                                icon: Icons.lock_outline_rounded,
                                gold: gold,
                                obscure: _obscurePassword,
                                suffix: IconButton(
                                  splashRadius: 18,
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: blush.withValues(alpha: 0.5),
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: const Size(0, 0),
                                    tapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/forgotPass');
                                  },
                                  child: Text(
                                    'Forgot password?',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: gold.withValues(alpha: 0.85),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 28),
                              SizedBox(
                                width: double.infinity,
                                height: 52,
                                child: GestureDetector(
                                  onTap: _isLoggingIn ? null : login,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(28),
                                      gradient: const LinearGradient(
                                        colors: [gold, goldDeep],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: gold.withValues(alpha: 0.35),
                                          blurRadius: 18,
                                          offset: const Offset(0, 8),
                                        ),
                                      ],
                                    ),
                                    alignment: Alignment.center,
                                    child: _isLoggingIn
                                        ? const SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.4,
                                        valueColor:
                                        AlwaysStoppedAnimation<Color>(
                                            Colors.white),
                                      ),
                                    )
                                        : const Text(
                                      'LOG IN',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        letterSpacing: 2.5,
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
                    const SizedBox(height: 28),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1300),
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signUpPage');
                          },
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 14,
                                color: blush.withValues(alpha: 0.6),
                              ),
                              children: [
                                const TextSpan(text: 'New to Shanjeeban?  '),
                                TextSpan(
                                  text: 'Sign up',
                                  style: TextStyle(
                                    color: gold,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
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

class _PremiumField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final Color gold;
  final bool obscure;
  final Widget? suffix;

  const _PremiumField({
    required this.controller,
    required this.hint,
    required this.icon,
    required this.gold,
    this.obscure = false,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        obscuringCharacter: '•',
        style: const TextStyle(color: Colors.white, fontSize: 15),
        cursorColor: gold,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.35)),
          border: InputBorder.none,
          prefixIcon: Icon(icon, color: gold.withValues(alpha: 0.8), size: 20),
          suffixIcon: suffix,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}