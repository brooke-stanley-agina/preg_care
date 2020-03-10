import 'package:preg_care/preg_care.dart';

class Read extends ManagedObject<_Read> implements _Read{
  @Serialize()
   String get detail => '$firstName by $lastName by $gps';

}

class _Read{
  @primaryKey
  int id;

  @Column(unique: true)
  String firstName;

  @Column(unique: true)
  String lastName;

  @Column()
  int temp;

   @Column()
  int pulse;

   @Column()
  int bp;

  @Column(unique: true)
  String gps;
}