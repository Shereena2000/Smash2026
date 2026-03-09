import 'package:hive_flutter/hive_flutter.dart';
part 'data_model.g.dart';

@HiveType(typeId: 0)
class Music extends HiveObject {

  @HiveField(0,defaultValue: 0)
  final int id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late String? album;

  @HiveField(3)
  late String path;

@HiveField(4)
  late String? artist;

  Music({required this.id, required this.path, required this.title, this.album, this.artist});         

}
