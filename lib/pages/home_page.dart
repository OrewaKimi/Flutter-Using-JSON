import 'package:flutter/material.dart';
import '../models/item.dart';
import '../services/item_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  IconData getIcon(String title) {
    title = title.toLowerCase();
    if (title.contains('laptop')) {
      return Icons.laptop_mac;
    } else if (title.contains('smartphone')) {
      return Icons.smartphone;
    } else if (title.contains('headphone')) {
      return Icons.headphones;
    } else {
      return Icons.category; // default
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daftar Produk Gen Z',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: FutureBuilder<List<Item>>(
        future: ItemService.loadItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.deepPurple));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada data.'));
          } else {
            final items = snapshot.data!;
            return ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Colors.deepPurple, Colors.purpleAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Icon(
                        getIcon(item.title),
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    title: Text(
                      item.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.deepPurple,
                      ),
                    ),
                    subtitle: Text(
                      item.description,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.deepPurple,
                      size: 20,
                    ),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Kamu memilih ${item.title}')),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
