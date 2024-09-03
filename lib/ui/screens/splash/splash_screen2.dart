import 'package:flutter/material.dart';
import 'package:recipe_app/ui/screens/auth/register/begin_register_screen.dart';

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({super.key});

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  final List<SplashPageData> _pages = const [
    SplashPageData(
      image: "assets/image/carrisa-gan.png",
      title: "Share Your Recipes",
      description: "Lorem ipsum dolor sit amet, consectetur elit.",
    ),
    SplashPageData(
      image: "assets/image/fathul.png",
      title: "Cook with Friends",
      description: "Share and enjoy recipes with friends.",
    ),
    SplashPageData(
      image: "assets/image/brooke.png",
      title: "Discover New Flavors",
      description: "Explore new recipes and cooking methods.",
    ),
  ];

  int _currentPage = 0;
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();
    _startPageTimer();
  }

  void _startPageTimer() {
    Future.delayed(const Duration(seconds: 3), () {
      _fadeOutAndNextPage();
    });
  }

  void _fadeOutAndNextPage() {
    setState(() => _opacity = 0.0);

    Future.delayed(const Duration(milliseconds: 500), () {
      if (_currentPage < _pages.length - 1) {
        setState(() {
          _currentPage++;
          _opacity = 1.0;
          _startPageTimer();
        });
      } else {
        _navigateToRegisterScreen();
      }
    });
  }

  void _navigateToRegisterScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const BeginRegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedOpacity(
            opacity: _opacity,
            duration: const Duration(milliseconds: 500),
            child: SplashPage(
              data: _pages[_currentPage],
            ),
          ),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: LinearProgressIndicator(
              value: (_currentPage + 1) / _pages.length,
              backgroundColor: Colors.grey[300],
              color: Colors.teal,
              minHeight: 5,
            ),
          ),
        ],
      ),
    );
  }
}

class SplashPageData {
  final String image;
  final String title;
  final String description;

  const SplashPageData({
    required this.image,
    required this.title,
    required this.description,
  });
}

class SplashPage extends StatelessWidget {
  final SplashPageData data;

  const SplashPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            data.image,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high, // Yaxshi sifatli tasvir
          ),
        ),
        Container(
          color: Colors.black54, // Yarim shaffof qoplama
        ),
        Positioned(
          top: MediaQuery.of(context).size.height *
              0.65, // Moslashtirilgan pozitsiya
          left: 20,
          right: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                data.description,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16, // Matnning katta o'lchami
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
