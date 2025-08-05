import 'package:drag_test/main.dart';
import 'package:drag_test/src/draw_container.dart';
import 'package:flutter/material.dart';
import 'package:treeview_draggable/treeview_draggable.dart';

class DepositContainer extends StatefulWidget {
  const DepositContainer({super.key});

  @override
  State<DepositContainer> createState() => _DepositContainerState();
}

class _DepositContainerState extends State<DepositContainer> {
  List<StockItem> items = [];

  @override
  Widget build(BuildContext context) {
    return DragTarget<Object>(
      onAcceptWithDetails: (details) {
        if (details.data is TreeNode) {
          final node = details.data as TreeNode;
          final item = node.data as StockItem;
          items.add(item);
          controller.remove(node);
        }
        if (details.data is StockItem) {
          items.add(details.data as StockItem);
        }
        setState(() {});
      },

      builder: (context, candidateData, rejectedData) {
        return Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: context.colorScheme().surfaceContainer,
            borderRadius: BorderRadius.circular(8),
            border:
                candidateData.isEmpty
                    ? null
                    : Border.all(
                      color: context.colorScheme().primary,
                      width: 2.0,
                    ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'On Shipment',
                  style: context.textTheme().titleMedium,
                ),
              ),
              SizedBox(height: 7),
              Divider(color: context.colorScheme().outline, height: 1),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder:
                      (context, index) => ListTile(
                        title: Text(items[index].name),
                        subtitle: Text(items[index].manufacturer),
                        trailing: IconButton(
                          onPressed: () {
                            items.remove(items[index]);
                            setState(() {});
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
