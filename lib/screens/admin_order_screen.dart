import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AdminOrderScreen extends StatelessWidget {
  const AdminOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Orders'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('orders').orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong.'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No orders found.'));
          }

          final orders = snapshot.data!.docs;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              final orderId = order.id;
              // Safely access data
              final orderData = order.data() as Map<String, dynamic>? ?? {};
              final orderStatus = orderData['status'] ?? 'Pending';
              final orderTimestamp = orderData['createdAt'] as Timestamp?;
              final formattedDate = orderTimestamp != null 
                  ? DateFormat.yMMMd().add_jm().format(orderTimestamp.toDate())
                  : 'No date';

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text('Order ID: $orderId', style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Status: $orderStatus\n$formattedDate'),
                  isThreeLine: true,
                  trailing: DropdownButton<String>(
                    value: orderStatus,
                    items: <String>['Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        FirebaseFirestore.instance.collection('orders').doc(orderId).update({'status': newValue});
                      }
                    },
                  ),
                   onTap: () => _showOrderDetails(context, order),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showOrderDetails(BuildContext context, DocumentSnapshot order) {
    final orderData = order.data() as Map<String, dynamic>? ?? {};
    final items = orderData['items'] as List<dynamic>? ?? [];
    final total = (orderData['total'] ?? 0.0) as num;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Order Details (ID: ${order.id})'),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (items.isNotEmpty)
                ...items.map((item) {
                  final itemData = item as Map<String, dynamic>? ?? {};
                  return ListTile(
                    title: Text(itemData['name'] ?? 'N/A'),
                    subtitle: Text('Quantity: ${itemData['quantity'] ?? 0}'),
                    trailing: Text('\$${(itemData['price'] ?? 0.0).toStringAsFixed(2)}'),
                  );
                })
              else
                const Text('No items in this order.'),
              const Divider(),
              Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text('Total: \$${total.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}