import 'package:flutter/material.dart';
import 'package:myapp/screens/admin_add_product_screen.dart';
import 'package:myapp/screens/admin_order_screen.dart';
import 'package:myapp/screens/admin_product_list_screen.dart';

class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade800, Colors.blue.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16.0),
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        children: [
          _buildAdminCard(
            context,
            icon: Icons.add_shopping_cart,
            label: 'Add Product',
            color: Colors.green,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AdminAddProductScreen(),
              ));
            },
          ),
          _buildAdminCard(
            context,
            icon: Icons.edit_note,
            label: 'Manage Products',
            color: Colors.orange,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AdminProductListScreen(),
              ));
            },
          ),
          _buildAdminCard(
            context,
            icon: Icons.receipt_long,
            label: 'Manage Orders',
            color: Colors.blue,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AdminOrderScreen(),
              ));
            },
          ),
          _buildAdminCard(
            context,
            icon: Icons.person_search,
            label: 'Manage Users',
            color: Colors.purple,
            onTap: () {
              // TODO: Implement user management screen
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('User management coming soon!'),
              ));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAdminCard(BuildContext context, {required IconData icon, required String label, required Color color, required VoidCallback onTap}) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: color),
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
