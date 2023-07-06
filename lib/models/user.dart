import 'package:isar/isar.dart';

part 'user.g.dart';

@collection
class User {
  Id? id;
  String? firstName;
  String? lastName;
  int? age;

  createUser(String name, String lName, int ages) {
    firstName = name;
    lastName = lName;
    age = ages;
  }
}
 