import 'package:flutter/material.dart';

import '../screens/login_screen.dart';
import '../widgets/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() {
    return _OnboardingScreenState();
  }
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController pageController = PageController();

  
  int currentPage = 0;

  final List<Map<String, String>> pages = [
    {
      'image': 'assets/images/Aprenda a organizar suas finanças.jpg',
      'title': 'Know Where Your Money Goes',
      'description':
          'Track your income and expenses in one place. See how much you spend and understand your spending habits.',
    },
    {
      'image': 'assets/images/Como ganhar dinheiro fácil e rápido em casa!!.jpg',
      'title': 'Take Control of Your Budget',
      'description':
          'Set monthly budgets and spending limits so you can stay on track and avoid unnecessary spending.',
    },
    {
      'image': 'assets/images/Financial Wins Look Like This.jpg',
      'title': 'Achieve Your Financial Goals',
      'description':
          'Set monthly budgets and spending limits so you can stay on track and avoid unnecessary spending.',
    },
  ];


  void openLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  
  void nextPage() {
    if (currentPage < pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      
      openLogin();
    }
  }

  // Skip onboarding -> Login
  void skipOnboarding() {
    openLogin();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [

  

            Align(
              alignment: Alignment.topRight,

              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  right: 25,
                ),

                child: GestureDetector(
                  onTap: skipOnboarding,

                  child: Row(
                    mainAxisSize: MainAxisSize.min,

                    children: const [
                      Text(
                        'skip',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),

                      SizedBox(width: 8),

                      Icon(
                        Icons.arrow_forward,
                        size: 25,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),

       
            Expanded(
              child: PageView.builder(
                controller: pageController,

                itemCount: pages.length,

                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },

                itemBuilder: (context, index) {
                  return OnboardingPage(
                    image: pages[index]['image']!,
                    title: pages[index]['title']!,
                    description: pages[index]['description']!,
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 40,
                right: 55,
                bottom: 45,
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [

              

                  Row(
                    children: List.generate(
                      pages.length,
                      (index) {
                        return Container(
                          margin: const EdgeInsets.only(
                            right: 6,
                          ),

                          width: 12,
                          height: 12,

                          decoration: BoxDecoration(
                            shape: BoxShape.circle,

                            color: currentPage == index
                                ? Colors.black
                                : Colors.grey.shade400,
                          ),
                        );
                      },
                    ),
                  ),

       

                  SizedBox(
                    width: 94,
                    height: 40,

                    child: ElevatedButton(
                      onPressed: nextPage,

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0B4D08),
                        foregroundColor: Colors.white,

                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),

                        elevation: 0,
                      ),

                      child: Text(
                        currentPage == pages.length - 1
                            ? 'START'
                            : 'NEXT',

                        style: const TextStyle(
                          fontSize: 13,
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
    );
  }
}