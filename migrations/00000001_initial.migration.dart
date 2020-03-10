import 'dart:async';
import 'package:aqueduct/aqueduct.dart';   

class Migration1 extends Migration { 
  @override
  Future upgrade() async {
   		database.createTable(SchemaTable("_Read", [
         SchemaColumn("id", ManagedPropertyType.bigInteger, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),
         SchemaColumn("firstName", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: true),
         SchemaColumn("lastName", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: true),
         SchemaColumn("temp", ManagedPropertyType.integer, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
         SchemaColumn("pulse", ManagedPropertyType.integer, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
         SchemaColumn("bp", ManagedPropertyType.integer, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
         SchemaColumn("gps", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: true)]));
  }
  
  @override
  Future downgrade() async {}
  
  @override
  Future seed() async {

    final List<Map>reads =[
      {
         'firstName':'Brooke',
         'lastName':'Stanley',
         'temp':25,
         'pulse':75,
         'bp':115,
         'gps':'123.145.234'
      }
    ];
    for (final read in reads){
      await database.store.execute('INSERT INTO _Read(firstName, lastName, temp, pulse, bp, gps) VALUES (@firstName, @lastName, @temp, @pulse, @bp, @gps)',
       substitutionValues: {
         'firstName':read['firstName'],
         'lastName':read['lastName'],
         'temp':read['temp'],
         'pulse':read['pulse'],
         'bp':read['bp'],
         'gps':read['gps']
       }
      );
    }
  }
}
    