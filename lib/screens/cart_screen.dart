import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/providers/cart_provider.dart';
import 'package:myapp/screens/order_success_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: cart.items.isEmpty
                ? const Center(
                    child: Text(
                      'Your cart is empty.',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final cartItem = cart.items[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          children: [
                            const SizedBox(width: 100, height: 100, child: Placeholder()),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(cartItem.name, style: theme.textTheme.titleLarge?.copyWith(fontSize: 18)),
                                  const SizedBox(height: 4),
                                  Text(
                                    '₱${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}',
                                    style: theme.textTheme.bodyLarge?.copyWith(fontSize: 16, color: theme.colorScheme.primary),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () => cart.removeSingleItem(cartItem.id),
                            ),
                            Text('${cartItem.quantity}', style: theme.textTheme.bodyLarge),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () => cart.addItem(cartItem.id, cartItem.name, cartItem.price),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          
          Card(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total:', style: theme.textTheme.titleLarge?.copyWith(fontSize: 20)),
                      Text(
                        '₱${cart.totalPrice.toStringAsFixed(2)}',
                        style: theme.textTheme.displayLarge?.copyWith(fontSize: 22),
                      ),
                    ],
                  ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: (_isLoading || cart.items.isEmpty) ? null : () async {
                setState(() {
                  _isLoading = true;
                });

                try {
                  final cartProvider = Provider.of<CartProvider>(context, listen: false);
                  
                  await cartProvider.placeOrder();
                  await cartProvider.clearCart();
                  
                  if(mounted) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const OrderSuccessScreen()),
                      (route) => false,
                    );
                  }

                } catch (e) {
                  if(mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to place order: $e')),
                    );
                  }
                } finally {
                  if (mounted) {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                }
              },
              child: _isLoading 
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : const Text('Place Order'),
            ),
          ),
        ],
      ),
    );
  }
}
