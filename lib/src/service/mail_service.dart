import 'dart:async' show Future;
import 'package:angular2/core.dart';
import 'package:onboarding_models/src/service/service_base.dart';

@Injectable()
class MailService extends ServiceBase
{
  MailService();

  Future put(String to, String subject, String body) async
  {
    await httpPUT("mail", {"to":to, "subject":subject, "body":body});
  }
}