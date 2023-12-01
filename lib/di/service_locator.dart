import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:printer_app/db/database.connection.dart';
import 'package:printer_app/db/local.service.dart';
import 'package:printer_app/db/repository.dart';
import 'package:printer_app/misc/printer_service.dart';

final locator = GetIt.instance;

Future<void> setup() async {
  locator.registerSingleton(const FlutterSecureStorage());
  /*locator.registerSingleton(TokenStorageService(locator<FlutterSecureStorage>()));
  locator.registerSingleton(Dio());
  locator.registerSingleton(AuthService(locator<TokenStorageService>()));
  locator.registerSingleton(DioClient(locator<Dio>()));
  locator.registerSingleton(ApiService(locator<DioClient>()));*/
  locator.registerSingleton(DatabaseConnection());
  locator.registerSingleton(Repository(locator<DatabaseConnection>()));
  locator.registerSingleton(LocalService(locator<Repository>()));
  locator.registerSingleton(PrinterService());
}
