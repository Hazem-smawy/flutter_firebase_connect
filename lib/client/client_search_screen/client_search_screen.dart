import 'package:flutter/material.dart';
import 'package:flutter_fire_base/client/products_list/client_show_all_products.dart';

class ClientSearchScreen extends StatefulWidget {
  const ClientSearchScreen({super.key});

  @override
  State<ClientSearchScreen> createState() => _ClientSearchScreenState();
}

class _ClientSearchScreenState extends State<ClientSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return ClientShowAllProductsInShop();
  }
}
