class Address {
  String id;
  String name;
  String cep;
  String road;
  String city;
  String state;
  String number;
  String complement;
  bool main;

  Address(this.id, this.name, this.cep, this.road, this.city, this.state, this.number, this.complement, this.main);
  Address.build({required this.id, required this.name, required this.cep, required this.road, required this.city, required this.state, required this.number, required this.complement, required this.main});
  Address.empty([this.id = "", this.name = "", this.cep = "", this.road = "", this.city = "", this.state = "", this.number = "", this.complement = "", this.main = false]);
  
  static Address fromJson(dynamic json) {
    return Address.build(
      id: json["_id"], 
      name: json["name"], 
      cep: json["cep"], 
      road: json["road"], 
      city: json["city"], 
      state: json["state"], 
      number: json["number"], 
      complement: json["complement"], 
      main: json["main"]
    );
  }

  static List<Address> fromJsonList(dynamic json) {
    try { return (json as List).map((address) => Address.fromJson(address)).toList(); } 
    catch (e) { return []; }
  }

  @override
  String toString() {
    return "$road, $number, $city, $state - $cep";
  }

  Map toJson() {
    return {
      'name': name,
      'cep': cep,
      'road': road,
      'city': city,
      'state': state,
      'number': number,
      'complement': complement,
      'main': main
    };
  }

  static Address clone(Address source) {
    return Address.build(
      id: source.id, 
      name: source.name, 
      cep: source.cep, 
      road: source.road, 
      city: source.city, 
      state: source.state, 
      number: source.number, 
      complement: source.complement, 
      main: source.main
    );
  }
}