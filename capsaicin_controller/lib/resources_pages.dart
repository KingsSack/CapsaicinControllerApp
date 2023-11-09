import 'package:flutter/material.dart';

class ResourcesPage extends StatelessWidget {
  const ResourcesPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ResourcesListView();
  }
}

class ResourcesListView extends StatelessWidget {
  const ResourcesListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          ListView(
            children: const [
              SizedBox(height: 8),
            ],
          ),
        ],
      ),
    );
  }
}
