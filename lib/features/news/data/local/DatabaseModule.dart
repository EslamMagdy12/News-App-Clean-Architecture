import 'package:injectable/injectable.dart';

import 'app_database.dart';

@module
abstract class DatabaseModule {
  @preResolve
  Future<AppDatabase> get appDatabase =>
      $FloorAppDatabase.databaseBuilder('app_database.db').build();
}
