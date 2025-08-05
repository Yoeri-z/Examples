import 'package:drag_test/main.dart';
import 'package:flutter/material.dart';
import 'package:treeview_draggable/treeview_draggable.dart';

class DrawContainer extends StatefulWidget {
  const DrawContainer({super.key});

  @override
  State<DrawContainer> createState() => _DrawContainerState();
}

class _DrawContainerState extends State<DrawContainer>
    with SingleTickerProviderStateMixin {
  late final _contoller = TabController(length: 2, vsync: this);

  List<StockItem> get demoItems => [
    StockItem(name: 'Part A', manufacturer: 'Manufacturer C'),
    StockItem(name: 'Part C', manufacturer: 'Manufacturer G'),
    StockItem(name: 'Part F', manufacturer: 'Manufacturer C'),
    StockItem(name: 'Part B', manufacturer: 'Manufacturer A'),
    StockItem(name: 'Part T', manufacturer: 'Manufacturer C'),
    StockItem(name: 'Part C', manufacturer: 'Manufacturer L'),
    StockItem(name: 'Part H', manufacturer: 'Manufacturer C'),
    StockItem(name: 'Part B', manufacturer: 'Manufacturer T'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _contoller,
          tabs: [Tab(text: 'Stock'), Tab(text: 'Already deployed')],
        ),
        Expanded(
          child: TabBarView(
            controller: _contoller,
            children: [
              ListView.builder(
                itemCount: demoItems.length,
                itemBuilder:
                    (context, index) => Draggable(
                      data: demoItems[index],
                      feedback: Material(
                        child: SizedBox(
                          width: 500,
                          child: ListTile(
                            title: Text(demoItems[index].name),
                            subtitle: Text(demoItems[index].manufacturer),
                          ),
                        ),
                      ),
                      child: ListTile(
                        title: Text(demoItems[index].name),
                        subtitle: Text(demoItems[index].manufacturer),
                      ),
                    ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('System A', style: context.textTheme().titleMedium),
                  Expanded(
                    child: TreeView(
                      controller: controller,
                      itemBuilder: (context, node) {
                        final item = node.data as StockItem;
                        return Material(
                          color: context.colorScheme().primaryContainer,
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(item.name),
                                  if (node.isNode)
                                    IconButton(
                                      onPressed: node.toggle,
                                      icon:
                                          node.expanded
                                              ? Icon(Icons.arrow_drop_up)
                                              : Icon(Icons.arrow_drop_down),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class StockItem {
  const StockItem({required this.name, required this.manufacturer});

  final String name;
  final String manufacturer;
}
