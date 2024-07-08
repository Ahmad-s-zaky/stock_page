import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/stock.dart';
import '../services/stock_service.dart';

class EditStockDialog extends StatefulWidget {
  final int index;
  final Stock stock;

  EditStockDialog({required this.index, required this.stock});

  @override
  _EditStockDialogState createState() => _EditStockDialogState();
}

class _EditStockDialogState extends State<EditStockDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _name = widget.stock.name;
    _quantity = widget.stock.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Stock'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: _name,
              decoration: InputDecoration(labelText: 'Name'),
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
              initialValue: _quantity.toString(),
              decoration: InputDecoration(labelText: 'Quantity'),
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
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              Provider.of<StockService>(context, listen: false)
                  .updateStock(widget.index, Stock(name: _name, quantity: _quantity));
              Navigator.of(context).pop();
            }
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
