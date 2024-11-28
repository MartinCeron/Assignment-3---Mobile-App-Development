import 'package:flutter/material.dart';

class OrderPlanScreen extends StatefulWidget {
  @override
  _OrderPlanScreenState createState() => _OrderPlanScreenState();
}

class _OrderPlanScreenState extends State<OrderPlanScreen> {
  DateTime? selectedDate;
  List<Map<String, dynamic>> orderPlan = []; // Example order plan

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Plan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select a date to view the order plan:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    selectedDate == null
                        ? 'No date selected'
                        : 'Selected Date: ${selectedDate!.toLocal()}'.split(' ')[0],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2100),
                    ).then((date) {
                      setState(() {
                        selectedDate = date;
                        if (selectedDate != null) {
                          // Example: Fetch order plan for the selected date from database
                          fetchOrderPlan();
                        }
                      });
                    });
                  },
                  child: Text('Pick Date'),
                ),
              ],
            ),
            SizedBox(height: 16),
            if (selectedDate != null && orderPlan.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: orderPlan.length,
                  itemBuilder: (context, index) {
                    final item = orderPlan[index];
                    return ListTile(
                      title: Text(item['foodName']),
                      trailing: Text('\$${item['cost']}'),
                    );
                  },
                ),
              )
            else if (selectedDate != null)
              Center(
                child: Text('No order plan found for the selected date.'),
              ),
          ],
        ),
      ),
    );
  }

  // Dummy function to simulate fetching data
  void fetchOrderPlan() {
    setState(() {
      orderPlan = [
        {'foodName': 'Pizza', 'cost': 10.0},
        {'foodName': 'Burger', 'cost': 8.5},
      ];
    });
  }
}
