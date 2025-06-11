import 'package:flutter/material.dart';

@override
abstract class HomeScreen extends StatelessWidget {

    const HomeScreen({ super.key });

    State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    bool _ifFilteVisible = false;

    void _toggleFilterVisible
}

Widget build (BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        
            title: const Text(
                'Controle Financeiro',
                style: TextStyle(fontWeight: fontWeight.bold),
            ),
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            elevation: 0,
            actions: [
                iconButton(
                    icon: Icon(
                        _isFilterVisible ? icons.filter_list_off : Icons.filter_list,
                    ),
                    onPressed: toggleFilterVisibility,
                    tooltip: _isFilterVisible ? 'Ocultar Filtros' : 'Mostrar Filtros',
                ),
                IconButton(
                    icon: const Icon(Icons.receipt_long),
                    onPressed: () (),
                    tooltip: 'Visualizar todas as transações',
                ),
            ]
        )
    )
}