import 'dart:math';

import 'package:liber/model/solicitation.dart';
import 'package:liber/services/ad_service.dart';
import 'package:liber/services/user_service.dart';

class SolicitationService {
  static int amount = 0;
  static final _random = Random();
  
  static Solicitation randomSolicitation() {
    amount++;
    return Solicitation.build(
      id: amount.toString(), 
      user: UserService.randomUser(), 
      ad: AdService.randomAd(), 
      userSolicitation: UserService.randomUser(), 
      adSolicitation: AdService.randomAd(), 
      status: ["em análise", "aceito", "negado", "concluido"][_random.nextInt(4)]
    );
  }
}