import 'dart:async';
import 'dart:convert' show JSON;
import 'package:angular2/angular2.dart';
import 'package:onboarding_models/src/service/service_base.dart';

@Injectable()
class AdminService extends ServiceBase
{
  AdminService()
  {
  }

  Future<bool> login(String username, String password) async
  {
    Map<String, dynamic> response = await httpPOST("admin/login_with_username_password", {"username":username, "password":password});
    return response['status'] == 200;
  }

  String clientName;
}