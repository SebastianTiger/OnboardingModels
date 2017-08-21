import 'dart:async' show Future;
import 'package:angular2/core.dart';
import 'package:onboarding_models/src/service/service_base.dart';
import 'package:onboarding_models/onboarding_models.dart' show Config, ConfigService;
import 'package:fo_components/fo_components.dart';

@Injectable()
class MailService extends ServiceBase
{
  MailService(this._configService, this._phraseService);

  Future put(String to, String subject, String body, bool embedded) async
  {
    if (embedded)
    {
      if (_configService.model == null) await _configService.fetchModel();

      Config cfg = _configService.model;
      
      String embeddedBody =
      """
        <table align="center" border="0" cellpadding="10" cellspacing="0" width="600" style="border-collapse: collapse;">
          <tr>
            <td>
              <img src='https://introduktion.nu/repositories/${cfg.client}/logo.png' alt='logo' width='300' style='margin-left:145px'>
            </td>
          </tr>
          <tr>
            <td style='text-align: center;'>              
              $body
            </td>
          </tr>
          <tr>
            <td>
              <p style='text-align:center; font-size:10px; color:#888;'>
                ${_phraseService.get("email_template_footer")}
              </p>              
            </td>
          </tr>
       </table>
      """;

      await httpPUT("mail", {"to":to, "subject":subject, "body":embeddedBody});
    }
    else await httpPUT("mail", {"to":to, "subject":subject, "body":body});
  }

  final ConfigService _configService;
  final PhraseService _phraseService;
}