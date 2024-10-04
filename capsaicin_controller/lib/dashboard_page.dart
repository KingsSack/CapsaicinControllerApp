import 'package:flutter/material.dart';

import 'data.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ServerListView();
  }
}

class ServerListView extends StatelessWidget {
  const ServerListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
          childAspectRatio: 1.2,
        ),
        itemCount: servers.length,
        itemBuilder: (context, index) {
          return ServerWidget(
            server: servers[index]
          );
        },
      ),
      /* child: ListView(
        children: [
          const SizedBox(height: 8),
          for (final server in servers)
            ServerWidget(
              server: server,
            ),
        ],
      ), */
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
        child: SizedBox(
          height: 190,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image(
                  image: widget.server.thumbnail,
                  fit: BoxFit.cover,
                  height: 80,
                  width: double.infinity,
                ),
              ),
              Padding(
              padding: const EdgeInsets.all(4.0),
                child: ClipRect(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          widget.server.name,
                          style: Theme.of(context).textTheme.headlineSmall,
                          overflow: TextOverflow.ellipsis,
                      ),
                      Text('Disk Usage: ${widget.server.disk_usage} GB', style: Theme.of(context).textTheme.bodySmall),
                      Text('Memory Usage: ${widget.server.memory_usage} GB', style: Theme.of(context).textTheme.bodySmall),
                      Text(widget.server.version, style: Theme.of(context).textTheme.labelMedium),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
