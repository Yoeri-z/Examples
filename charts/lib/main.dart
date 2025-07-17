import 'package:charts/chart_widgets/bar_chart.dart';
import 'package:charts/chart_widgets/line_chart.dart';
import 'package:charts/chart_widgets/pie_chart.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late final tabController = TabController(length: 3, vsync: this);

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Charts made using fl chart'),
      ),
      body: Column(
        children: [
          TabBar(
            controller: tabController,
            tabs: [Tab(text: 'Line'), Tab(text: 'Bar'), Tab(text: 'Pie')],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TabBarView(
                controller: tabController,
                children: [
                  Column(
                    children: [
                      //sizedboxes to make sure the values on the graph are not cut off
                      SizedBox(height: 10),
                      Expanded(child: LineChartWidget()),
                      SizedBox(height: 10),
                    ],
                  ),
                  BarChartWidget(),
                  PieChartWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
