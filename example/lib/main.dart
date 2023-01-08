import 'package:flex_animated_button_bar/animated_button_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AnimatedButtonBar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark),
      home: SampleView(),
    );
  }
}

class SampleView extends StatefulWidget {
  @override
  _SampleViewState createState() => _SampleViewState();
}

class _SampleViewState extends State<SampleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //inverted selection button bar
          FlexAnimatedButtonBar(
            radius: 8.0,
            padding: const EdgeInsets.all(16.0),
            invertedSelection: true,
            children: [
              ButtonBarEntry(
                  flex: 1,
                  onTap: () => print('First item tapped'),
                  child: (isActive) => Text('Day')),
              ButtonBarEntry(
                  flex: 1,
                  onTap: () => print('Second item tapped'),
                  child: (isActive) => Text('Week')),
              ButtonBarEntry(
                  flex: 1,
                  onTap: () => print('Third item tapped'),
                  child: (isActive) => Text('Month')),
              ButtonBarEntry(
                  flex: 1,
                  onTap: () => print('Fourth item tapped'),
                  child: (isActive) => Text('Year'))
            ],
          ),
          //You can populate it with different types of widgets like Icon
          FlexAnimatedButtonBar(
            radius: 32.0,
            padding: const EdgeInsets.all(16.0),
            backgroundColor: Colors.blueGrey.shade800,
            foregroundColor: Colors.blueGrey.shade300,
            elevation: 24,
            borderColor: Colors.white,
            borderWidth: 2,
            innerVerticalPadding: 16,
            children: [
              ButtonBarEntry(
                  flex: 1,
                  onTap: () => print('First item tapped'),
                  child: (isActive) => Icon(Icons.person)),
              ButtonBarEntry(
                  flex: 1,
                  onTap: () => print('Second item tapped'),
                  child: (isActive) => Icon(Icons.people)),
            ],
          ),
        ],
      ),
    );
  }
}
