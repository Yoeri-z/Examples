import 'package:drag_test/src/deposit_container.dart';
import 'package:drag_test/src/draw_container.dart';
import 'package:flutter/material.dart';
import 'package:treeview_draggable/treeview_draggable.dart';

void main() {
  runApp(const MyApp());
}

final controller = TreeController(
  initialNodes: [
    TreeNode(
      1,
      StockItem(name: 'Part A', manufacturer: 'Manufacturer D'),
      children: [
        TreeNode(2, StockItem(name: 'Part C', manufacturer: 'Manufacturer F')),
        TreeNode(3, StockItem(name: 'Part D', manufacturer: 'Manufacturer E')),
      ],
    ),
    TreeNode(
      4,
      StockItem(name: 'Part B', manufacturer: 'Manufacturer D'),
      children: [
        TreeNode(5, StockItem(name: 'Part E', manufacturer: 'Manufacturer F')),
        TreeNode(6, StockItem(name: 'Part F', manufacturer: 'Manufacturer E')),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Part Drag test for issues and shipments',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Part Drag test for issues and shipments'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          spacing: 8,
          children: [
            Expanded(
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: context.colorScheme().surfaceContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DrawContainer(),
              ),
            ),
            Expanded(
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: context.colorScheme().surfaceContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DepositContainer(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension ThemeContext on BuildContext {
  ColorScheme colorScheme() {
    return Theme.of(this).colorScheme;
  }

  TextTheme textTheme() {
    return Theme.of(this).textTheme;
  }
}
