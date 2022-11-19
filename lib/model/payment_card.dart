class PaymentCard {
  String id;
  String number;
  String expirationDate;
  String cvv;
  String cardholder;
  String cpf;
  String nameCard;
  bool main;

  PaymentCard(this.id, this.number, this.expirationDate, this.cvv, this.cardholder, this.cpf, this.nameCard, this.main);
  PaymentCard.build({required this.id, required this.number, required this.expirationDate, required this.cvv, required this.cardholder, required this.cpf, required this.nameCard, required this.main});
  PaymentCard.empty([this.id = "", this.number = "", this.expirationDate = "", this.cvv = "", this.cardholder = "", this.cpf = "", this.nameCard = "", this.main = false]);

  static PaymentCard fromJson(dynamic json) {
    return PaymentCard.build(
      id: json["_id"], 
      number: json["number"], 
      expirationDate: json["expiration_date"], 
      cvv: json["cvv"], 
      cardholder: json["cardholder"], 
      cpf: json["cpf"], 
      nameCard: json["name_card"], 
      main: json["main"]
    );
  }

  static List<PaymentCard> fromJsonList(dynamic json) {
    try { return (json as List).map((paymentCard) => PaymentCard.fromJson(paymentCard)).toList(); } 
    catch (e) { return []; }
  }

  @override
  String toString() {
    try {
      return "$cardholder - terminado em ${number.substring(number.length - 4)}";
    } catch (e) {    
      return "-";
    }
  }

  static PaymentCard clone(PaymentCard source) {
    return PaymentCard.build(
      id: source.id, 
      number: source.number, 
      expirationDate: source.expirationDate, 
      cvv: source.cvv, 
      cardholder: source.cardholder, 
      cpf: source.cpf, 
      nameCard: source.nameCard, 
      main: source.main
    );
  }
}