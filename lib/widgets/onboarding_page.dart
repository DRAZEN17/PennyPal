import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        const SizedBox(height: 25),

      
        Expanded(
          flex: 6,

          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
            ),

            child: Image.asset(
              image,
              fit: BoxFit.contain,
            ),
          ),
        ),

        const SizedBox(height: 15),

        
        Text(
          title,

          textAlign: TextAlign.center,

          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),

        const SizedBox(height: 22),

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 45,
          ),

          child: Text(
            description,

            textAlign: TextAlign.center,

            style: const TextStyle(
              fontSize: 15,
              height: 1.35,
              color: Colors.black,
            ),
          ),
        ),

        const SizedBox(height: 10),
      ],
    );
  }
}