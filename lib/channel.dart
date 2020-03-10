

import 'controller/reads_controller.dart';
import 'preg_care.dart';

/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://aqueduct.io/docs/http/channel/.
class PregCareChannel extends ApplicationChannel {
  ManagedContext context;
  /// Initialize services in this method.
  ///
  /// Implement this method to initialize services, read values from [options]
  /// and any other initialization required before constructing [entryPoint].
  ///
  /// This method is invoked prior to [entryPoint] being accessed.
  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
        
    
    final config = ReadConfig(options.configurationFilePath);
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistentStore = PostgreSQLPersistentStore.fromConnectionInfo(
       config.database.username,
       config.database.password, 
       config.database.host, 
       config.database.port, 
       config.database.databaseName
      );
      context = ManagedContext(dataModel, persistentStore);
  }

  /// Construct the request channel.
  ///
  /// Return an instance of some [Controller] that will be the initial receiver
  /// of all [Request]s.
  ///
  /// This method is invoked after [prepare].
  @override
  Controller get entryPoint => Router()

    ..route('/reads/[:id]').link(() => ReadsController(context))

    //
    ..route('/').linkFunction((request) => 
      Response.ok('Hello, world')..contentType = ContentType.html);

    
}

class ReadConfig extends Configuration{
  ReadConfig(String path): super.fromFile(File(path));

  DatabaseConfiguration database;
}