import 'package:flutter/material.dart';
import '../models/stock.dart';

class StockService extends ChangeNotifier {
  final List<Stock> _stocks = [
    Stock(name: 'Stock1', quantity: 0),
    Stock(name: 'Stock1', quantity: 0),
    Stock(name: 'Stock1', quantity: 0),
    Stock(name: 'Stock1', quantity: 0),
  ];

  List<Stock> get stocks => _stocks;

  void addStock(Stock stock) {
    _stocks.add(stock);
    notifyListeners();
  }

  void updateStock(int index, Stock stock) {
    _stocks[index] = stock;
    notifyListeners();
  }

  void deleteStock(int index) {
    _stocks.removeAt(index);
    notifyListeners();
  }
}
