import 'package:myapp/ListHorseInfo.dart';

class HorseInfo {
  const HorseInfo({this.name});

  final String name;
}

class Race extends HorseInfoListable{
  const Race({name}): super(name: name);
}
class Nationality extends HorseInfoListable {
  const Nationality({name}): super(name: name);
}
