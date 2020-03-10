import 'package:preg_care/model/read.dart';

import 'app.dart';



void main() {
  final harness = Harness()..install();

  setUp(() async{
     final readQuery = Query<Read>(harness.application.channel.context)
     ..values.firstName ='Brooke'
     ..values.lastName ='Stanley'
     ..values.temp=25
     ..values.pulse=75
     ..values.bp=115
     ..values.gps='123.145.234';
     await readQuery.insert();
  });

  test('GET /reads a 200 OK', () async{
    final response = await harness.agent.get('/reads');
    expectResponse(response, 200, body: everyElement(partial({
        'id':greaterThan(0),
        'firstName': isString,
        'lastName': isString,
        'temp': isInteger,
        'pulse':isInteger,
        'bp':isInteger,
        'gps':isString
    })));
  });

  test('GET /read/:id returns a single read', () async{
    final response = await harness.agent.get('/reads');
    expectResponse(response, 200, body:everyElement(partial({
      'id':1,
        'firstName': 'Brooke',
        'lastName': 'Stanley',
        'temp': 25,
        'pulse':75,
        'bp': 115,
        'gps': '123.145.234'
    })));
  });

  test('POST /reads creates a new read', () async{
     final response = harness.agent.post('/reads', body:{
        'firstName': 'Agina',
        'lastName': 'Stanley',
        'temp': 25,
        'pulse':75,
        'bp': 115,
        'gps': '123.145.234'
     });
    
  });

}