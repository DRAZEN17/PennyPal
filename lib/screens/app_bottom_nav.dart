import 'package:flutter/material.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTabTap,
    required this.onAddTap,
  });

  final int currentIndex;

  final void Function(int index) onTabTap;

  final VoidCallback onAddTap;

  static const Color primaryGreen = Color(0xFF154808);

  static const List<Map<String, dynamic>> _items = [
    {'icon': Icons.home_outlined, 'label': 'Home'},
    {'icon': Icons.description_outlined, 'label': 'Transactions'},
    {'icon': Icons.add, 'label': ''},
    {'icon': Icons.track_changes_outlined, 'label': 'Goals'},
    {'icon': Icons.grid_view_outlined, 'label': 'More'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE0E0E0))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_items.length, (i) {
          bool isCenter = i == 2;
          bool isSelected = currentIndex == i;

          if (isCenter) {
            return GestureDetector(
              onTap: onAddTap,
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: primaryGreen,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.add, color: Colors.white),
              ),
            );
          }

          return GestureDetector(
            onTap: () => onTabTap(i),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _items[i]['icon'] as IconData,
                  color: isSelected ? primaryGreen : Colors.black45,
                ),
                const SizedBox(height: 2),
                Text(
                  _items[i]['label'] as String,
                  style: TextStyle(
                    fontSize: 11,
                    color: isSelected ? primaryGreen : Colors.black45,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
