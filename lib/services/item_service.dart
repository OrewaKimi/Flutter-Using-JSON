import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/item.dart';

class ItemService {
  static Future<List<Item>> loadItems() async {
    final data = await rootBundle.loadString('assets/items.json');
    final List<dynamic> jsonResult = json.decode(data);
    return jsonResult.map((json) => Item.fromJson(json)).toList();
  }
}
