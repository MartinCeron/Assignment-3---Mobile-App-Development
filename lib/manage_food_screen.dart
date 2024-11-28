import 'package:flutter/material.dart';
import 'database_helper.dart';

class ManageFoodScreen extends StatefulWidget {
  @override
  _ManageFoodScreenState createState() => _ManageFoodScreenState();
}

class _ManageFoodScreenState extends State<ManageFoodScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> foodList = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController costController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchFoodItems();
  }

  Future<void> fetchFoodItems() async {
    final items = await _dbHelper.getFoodItems();
    setState(() {
      foodList = items;
    });
  }

  void addFoodItem() async {
    String name = nameController.text;
    double? cost = double.tryParse(costController.text);
    if (name.isNotEmpty && cost != null) {
      await _dbHelper.addFoodItem(name, cost);
      nameController.clear();
      costController.clear();
      fetchFoodItems();
    }
  }

  void deleteFoodItem(int id) async {
    await _dbHelper.deleteFoodItem(id);
    fetchFoodItems();
  }

  void updateFoodItem(int id) {
    nameController.text = foodList.firstWhere((item) => item['id'] == id)['name'];
    costController.text = foodList.firstWhere((item) => item['id'] == id)['cost'].toString();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Food Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Food Name'),
            ),
            TextField(
              controller: costController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Cost'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              String name = nameController.text;
              double? cost = double.tryParse(costController.text);
              if (name.isNotEmpty && cost != null) {
                await _dbHelper.updateFoodItem(id, name, cost);
                nameController.clear();
                costController.clear();
                Navigator.pop(context);
                fetchFoodItems();
              }
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Food'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Food Name'),
            ),
            TextField(
              controller: costController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Cost'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: addFoodItem,
              child: Text('Add Food Item'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: foodList.length,
                itemBuilder: (context, index) {
                  final item = foodList[index];
                  return ListTile(
                    title: Text(item['name']),
                    subtitle: Text('Cost: \$${item['cost']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => updateFoodItem(item['id']),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => deleteFoodItem(item['id']),
                        ),
                      ],
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
