import 'dart:async' show Future;
import 'package:angular2/core.dart';
import '../util/dig_query.dart';

@Injectable()
class SmsService
{
  SmsService();

  Future put(String to, String body, bool reset_user_password) async
  {
    if (to == null || body == null || to.isEmpty || body.isEmpty) return;

    try
    {
      _loading = true;
      await _dq.put("/sms", {"to":to, "body":body, "reset_user_password":reset_user_password});
      _loading = false;
    }
    catch (e)
    {
      _loading = false;
      throw new Exception(e.target.responseText);
    }
  }

  bool get isLoading => _loading;

  final DigQuery _dq = new DigQuery();
  bool _loading = false;
}