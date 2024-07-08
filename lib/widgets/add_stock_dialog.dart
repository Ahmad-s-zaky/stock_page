import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/stock.dart';
import '../services/stock_service.dart';

// ignore: use_key_in_widget_constructors
class AddStockDialog extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _AddStockDialogState createState() => _AddStockDialogState();
}

class _AddStockDialogState extends State<AddStockDialog> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  int _quantity = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Stock'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
              onSaved: (value) {
                _name = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a quantity';
                }
                return null;
              },
              onSaved: (value) {
                _quantity = int.parse(value!);
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              Provider.of<StockService>(context, listen: false).addStock(Stock(name: _name, quantity: _quantity));
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
