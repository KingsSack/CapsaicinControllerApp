import 'package:flutter/material.dart';

import 'animations.dart';
import 'data.dart';
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
  late final _railFabAnimation = RailFabAnimation(parent: _controller);
  late final _barAnimation = BarAnimation(parent: _controller);

  int selectedIndex = 0;
  bool controllerInitialized = false;

  static const List<Widget> pages = [
    ServerListView(),
    Center(child: Text('Information Page')),
    Center(child: Text('Settings Page')),
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
                railFabAnimation: _railFabAnimation,
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

class ServerListView extends StatelessWidget {
  const ServerListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        children: [
          const SizedBox(height: 8),
          ...List.generate(
            servers.length,
                (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ServerWidget(
                  server: servers[index]
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ServerWidget extends StatefulWidget {
  const ServerWidget({
    super.key,
    required this.server,
  });

  final Server server;

  @override
  State<ServerWidget> createState() => _ServerWidgetState();
}

class _ServerWidgetState extends State<ServerWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
      child: InkWell(
        onTap: () {},
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.server.version, style: Theme.of(context).textTheme.labelMedium),
                const SizedBox(height: 6),
                Text(widget.server.name, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 4),
                Text('Disk Usage: ${widget.server.disk_usage} GB', style: Theme.of(context).textTheme.bodySmall),
                Text('Memory Usage: ${widget.server.memory_usage} GB', style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
