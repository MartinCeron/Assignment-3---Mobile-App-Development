import 'package:flutter/material.dart';
import 'order_plan_screen.dart';
import 'manage_food_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> foodPlaces = [
    {'name': 'Pizza Paradise', 'image': 'assets/pizza.jpg'},
    {'name': 'Sushi Spot', 'image': 'assets/sushi.jpg'},
    {'name': 'Burger Haven', 'image': 'assets/burger.jpg'},
    {'name': 'Taco Town', 'image': 'assets/taco.jpg'},
    {'name': 'Pasta Palace', 'image': 'assets/pasta.jpg'},
    {'name': 'Dessert Delights', 'image': 'assets/dessert.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    print('ManageFoodScreen Loaded');
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Ordering App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: foodPlaces.length,
              itemBuilder: (context, index) {
                final place = foodPlaces[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        place['image']!,
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 8),
                      Text(
                        place['name']!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OrderPlanScreen()),
                    );
                  },
                  child: Text('Order Plan'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ManageFoodScreen()),
                    );
                  },
                  child: Text('Manage Food'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
