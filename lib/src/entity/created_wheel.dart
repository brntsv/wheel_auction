import 'package:hive/hive.dart';

part 'created_wheel.g.dart';

@HiveType(typeId: 1)
class CreatedWheel {
  @HiveField(0)
  String name;

  CreatedWheel({
    required this.name,
    // required this.fields
  });

  // @HiveField(2)
  // List<ListOfFields> fields;

}
