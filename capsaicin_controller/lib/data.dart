import 'package:flutter/cupertino.dart';

class Server {
  const Server({
    required this.name,
    required this.version,
    required this.players,
    required this.disk_usage,
    required this.memory_usage,
    required this.id,
    required this.thumbnail,
  });

  final String name;
  final String version;
  final String players;
  final double disk_usage;
  final double memory_usage;
  final int id;
  final NetworkImage thumbnail;
}

final List<Server> servers = [
  const Server(
    name: 'A Modded Minecraft Server',
    version: 'Fabric 1.20',
    players: '0/20',
    disk_usage: 3.44,
    memory_usage: 1.20,
    id: 0,
    thumbnail: NetworkImage('https://static.wikia.nocookie.net/minecraft_gamepedia/images/3/3f/Beta.png/revision/latest?cb=20191215152001'),
  ),
  const Server(
    name: 'Slipping Slime',
    version: 'Velocity',
    players: '0/100',
    disk_usage: 10.12,
    memory_usage: 3.20,
    id: 1,
    thumbnail: NetworkImage('https://static.wikia.nocookie.net/minecraft_gamepedia/images/3/3f/Beta.png/revision/latest?cb=20191215152001'),
  ),
];