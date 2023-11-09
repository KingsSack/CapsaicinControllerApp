import 'package:capsaicin_controller/dashboard_page.dart';
import 'package:capsaicin_controller/resources_pages.dart';
import 'package:capsaicin_controller/settings_page.dart';
import 'package:flutter/material.dart';

import 'animations.dart';
import 'widgets/disappearing_bottom_navigation_bar.dart';
import 'widgets/disappearing_navigation_rail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Capsaicin Controller',
      theme: ThemeData.dark(useMaterial3: true),
      home: const Controller(title: 'Dashboard'),
    );
  }
}

class Controller extends StatefulWidget {
  const Controller({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<Controller> createState() => _ControllerState();
}

class _ControllerState extends State<Controller> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      reverseDuration: const Duration(milliseconds: 1250),
      value: 0,
      vsync: this,
  );
  late final _railAnimation = RailAnimation(parent: _controller);
  late final _barAnimation = BarAnimation(parent: _controller);

  int selectedIndex = 0;
  bool controllerInitialized = false;

  static const List<Widget> pages = [
    DashboardPage(),
    ResourcesPage(),
    SettingsPage(),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final double width = MediaQuery.of(context).size.width;
    final AnimationStatus status = _controller.status;
    if (width > 600) {
      if (status != AnimationStatus.forward &&
          status != AnimationStatus.completed) {
        _controller.forward();
      }
    } else {
      if (status != AnimationStatus.reverse &&
          status != AnimationStatus.dismissed) {
        _controller.reverse();
      }
    }
    if (!controllerInitialized) {
      controllerInitialized = true;
      _controller.value = width > 600 ? 1 : 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _createServer() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {},
              ),
            ],
          ),
          body: Row(
            children: [
              DisappearingNavigationRail(
                railAnimation: _railAnimation,
                selectedIndex: selectedIndex,
                onDestinationSelected: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
              Expanded(
                child: pages[selectedIndex],
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _createServer,
            tooltip: 'Create Server',
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: DisappearingBottomNavigationBar(
            barAnimation: _barAnimation,
            selectedIndex: selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        );
      },
    );
  }
}
