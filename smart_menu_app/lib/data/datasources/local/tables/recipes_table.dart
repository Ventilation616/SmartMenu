import 'package:drift/drift.dart';

class RecipeEntities extends Table {
  @override
  String get tableName => 'recipes';

  TextColumn get id => text()();

  TextColumn get name => text()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}
