import 'package:contextmenu/contextmenu.dart';
import 'package:flutter/material.dart';

class ContextMenu extends StatefulWidget {
  const ContextMenu({super.key});

  @override
  State<ContextMenu> createState() => _ContextMenuState();
}

class _ContextMenuState extends State<ContextMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Context Menu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: ContextMenuArea(
          builder: (context) => [
            ListTile(
              title: Text('Option 1'),
              onTap: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Whatever'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.model_training),
              title: Text('Option 2'),
              onTap: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Foo!'),
                  ),
                );
              },
            )
          ],
          child: Card(
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Text(
                'Press somewhere for context menu.',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}