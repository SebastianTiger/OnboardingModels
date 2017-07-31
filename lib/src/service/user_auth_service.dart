import 'package:angular2/angular2.dart';
import 'package:vi_auth_client/vi_auth_client.dart';
import 'package:onboarding_models/onboarding_models.dart' show ConfigService;

@Injectable()
class UserAuthService extends ViAuthClient
{
  UserAuthService(ConfigService cfg)
      : super("https://api.introduktion.nu/viauth/index.php/", "digicy_introduktion_client_" + cfg.model.subdomain);
}