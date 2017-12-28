import 'package:myapp/ListHorseInfo.dart';

/// Information on cares, should be create and return by API/Database.
class CareInfo {
  const CareInfo(this.type, [this.cares = const <String>[]]);
  final String type;
  final List<String> cares;
}

/// Information on horses, should be create and return by API/Database.
class HorseInfo {
  HorseInfo(this.name, [this.nextCare = const CareInfo("Next"), this.previousCare = const CareInfo("Previous")]);
  final String name;
  final CareInfo nextCare;
  final CareInfo previousCare;
}

class Race extends HorseInfoListable{
  const Race({name}): super(name: name);
}
class Nationality extends HorseInfoListable {
  const Nationality({name}): super(name: name);
}
