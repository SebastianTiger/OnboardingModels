import 'dart:async' show Future;
import 'package:angular2/core.dart';
import 'package:onboarding_models/src/service/service_base.dart';

@Injectable()
class SmsService extends ServiceBase
{
  SmsService();

  Future put(String to, String body) async
  {
    if (to == null || body == null || to.isEmpty || body.isEmpty) return;
    await httpPUT("sms", {"to":to, "body":body});
  }
}