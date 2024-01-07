import 'dart:math';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoadingScreen(),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  final List colors = [
    Colors.purple,
    Colors.green,
    Colors.red,
    Colors.blue,
  ];

  int circleCount = 1;
  bool _isLoading = false;
  double _angle = 0;
  double _radius = 0;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      upperBound: 2.0,
      duration: const Duration(seconds: 1, milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                onPressed: () => setState(() {
                  if (circleCount > 0) circleCount--;
                }),
                child: const Icon(Icons.remove),
              ),
              SizedBox(
                width: 10,
              ),
              FloatingActionButton(
                onPressed: () => setState(() => circleCount++),
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ),
        body:
            (_isLoading) ? _loadingIndicator(context) : _startButton(context));
  }

  Widget _startButton(BuildContext context) {
    return Center(
      child: FilledButton(
          onPressed: () {
            setState(() => _isLoading = true);
            _controller.repeat();
          },
          child: const Text('Start')),
    );
  }

  Widget _loadingIndicator(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                final String loadingText;
                if (_controller.value <= 0.66) {
                  loadingText = 'Loading.';
                } else if (_controller.value <= 1.33) {
                  loadingText = 'Loading..';
                } else {
                  loadingText = 'Loading...';
                }
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(alignment: Alignment.center, children: [
                      for (int i = 0; i < circleCount; i++)
                        _buildAnimation(i / circleCount * pi * 2,
                            Circle(color: colors[i % colors.length])),
                    ]),
                    const SizedBox(
                      height: 80,
                    ),
                    Text(loadingText),
                  ],
                );
              })
        ],
      ),
    );
  }

  Widget _buildAnimation(double rotationOffset, Widget child) {
    if (_controller.value <= 0.5) {
      _angle = 0;
      _radius = 60 * _controller.value * 2;
    } else if (_controller.value <= 1.5) {
      _angle = (_controller.value - 0.5) * pi;
      _radius = 60;
    } else {
      _angle = pi;
      _radius = 60 * (2 - _controller.value) * 2;
    }

    return Transform.translate(
      offset: Offset(_radius * cos(_angle + rotationOffset),
          _radius * sin(_angle + rotationOffset)),
      child: child,
    );
  }
}

class Circle extends StatelessWidget {
  const Circle({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
