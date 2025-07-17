import 'package:flutter/material.dart';
import '../../domain/entity/transaction_entity.dart';

class EditTransactionForm extends StatefulWidget {
  final TransactionEntity transaction;
  final Function(TransactionEntity) onSave;

  const EditTransactionForm({
    super.key,
    required this.transaction,
    required this.onSave,
  });

  @override
  State<EditTransactionForm> createState() => _EditTransactionFormState();
}

class _EditTransactionFormState extends State<EditTransactionForm> {
  late TextEditingController _titleController;
  late TextEditingController _valueController;
  late DateTime _selectedDate;
  late TransactionType _type;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.transaction.title);
    _valueController = TextEditingController(text: widget.transaction.amount.toString());
    _selectedDate = widget.transaction.date;
    _type = widget.transaction.type;
  }

  void _submitForm() {
    final title = _titleController.text.trim();
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) return;

    final updatedTransaction = widget.transaction.copyWith(
      title: title,
      amount: value,
      date: _selectedDate,
      type: _type,
    );

    widget.onSave(updatedTransaction);
    Navigator.of(context).pop();
  }

  void _openDatePicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Editar Transação',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Valor (R\$)'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Data: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
                TextButton(
                  onPressed: _openDatePicker,
                  child: const Text('Alterar Data'),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('Receita'),
                    leading: Radio<TransactionType>(
                      value: TransactionType.income,
                      groupValue: _type,
                      onChanged: (value) {
                        setState(() {
                          _type = value!;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Despesa'),
                    leading: Radio<TransactionType>(
                      value: TransactionType.expense,
                      groupValue: _type,
                      onChanged: (value) {
                        setState(() {
                          _type = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }
}
