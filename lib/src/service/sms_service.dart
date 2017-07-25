import 'dart:async' show Future;
import 'package:angular2/core.dart';
import 'package:onboarding_models/src/service/service_base.dart';

@Injectable()
class SmsService extends ServiceBase
{
  SmsService();

  Future put(String to, String body, bool reset_user_password) async
  {
    if (to == null || body == null || to.isEmpty || body.isEmpty) return;
    try
    {
      await httpPUT("sms", {"to":to, "body":body});
    }
    catch (e)
    {
      throw new Exception(e.target.responseText);
    }
  }

  //bool get isLoading => _loading;

  //final DigQuery _dq = new DigQuery();
  //bool _loading = false;
}