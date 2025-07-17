import 'package:flutter/material.dart';
import 'package:financial_tracker/domain/entity/transaction_entity.dart';
import 'package:financial_tracker/common/patterns/command.dart';
import 'package:financial_tracker/common/errors/errors_classes.dart';

class TransactionForm extends StatefulWidget {
  final TransactionType type;
  final Color color;
  final Command1<void, Failure, TransactionEntity> submitCommand;
  final TransactionEntity? initialTransaction;

  const TransactionForm({
    super.key,
    required this.type,
    required this.color,
    required this.submitCommand,
    this.initialTransaction,
  });

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _amountController;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();

    // Inicializa os controladores com os dados da transação (se edição)
    _titleController = TextEditingController(
      text: widget.initialTransaction?.title ?? '',
    );
    _amountController = TextEditingController(
      text: widget.initialTransaction?.amount.toString() ?? '',
    );

    _selectedDate = widget.initialTransaction?.date ?? DateTime.now();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text;
      final amount = double.tryParse(_amountController.text) ?? 0;

      final newTransaction = TransactionEntity(
        id: widget.initialTransaction?.id ?? UniqueKey().toString(),
        title: title,
        amount: amount,
        date: _selectedDate,
        type: widget.type,
      );

      widget.submitCommand.execute(newTransaction);
      Navigator.of(context).pop(); // Fecha o bottom sheet
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Título'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Campo obrigatório' : null,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Valor'),
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value == null || double.tryParse(value) == null
                      ? 'Insira um número válido'
                      : null,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text('Data: ${_selectedDate.toLocal().toString().split(' ')[0]}'),
                const Spacer(),
                TextButton(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      setState(() {
                        _selectedDate = picked;
                      });
                    }
                  },
                  child: const Text('Escolher Data'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.color,
              ),
              onPressed: _submit,
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
