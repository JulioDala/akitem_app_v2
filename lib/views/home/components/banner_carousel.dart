import 'package:akitem/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  _BannerCarouselState createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final PageController _bannerController = PageController();
  int _currentBannerPage = 0;

  final List<Map<String, String>> banners = [
    {
      'image': 'assets/images/imagem2.png',
      'text': 'Se encontrares mais barato, igualamos o preço.',
    },
    {
      'image': 'assets/images/imagem2.png',
      'text': 'Promoções nos produtos assinalados de 16 a 24 Dez',
    },
    {
      'image': 'assets/images/imagem2.png',
      'text': 'Grandes descontos em tecnologia',
    },
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _autoScrollBanner();
      }
    });
  }

  void _autoScrollBanner() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        if (_currentBannerPage < banners.length - 1) {
          _currentBannerPage++;
        } else {
          _currentBannerPage = 0;
        }
        _bannerController.animateToPage(
          _currentBannerPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        _autoScrollBanner();
      }
    });
  }

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          height: 200,
          child: Stack(
            children: [
              PageView.builder(
                controller: _bannerController,
                onPageChanged: (index) {
                  setState(() {
                    _currentBannerPage = index;
                  });
                },
                itemCount: banners.length,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      banners[index]['image']!,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 20,
                left: 15,
                right: 15,
                child: Text(
                  banners[_currentBannerPage]['text']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(1, 1),
                        blurRadius: 3,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            banners.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              height: 4,
              width: _currentBannerPage == index ? 65 : 50,
              decoration: BoxDecoration(
                color: _currentBannerPage == index
                    ? AppColors.secundary
                    : const Color(0xFFCACACA),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
