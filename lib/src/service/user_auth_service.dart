import 'package:angular2/angular2.dart';
import 'package:vi_auth_client/vi_auth_client.dart';

@Injectable()
class UserAuthService extends ViAuthClient
{
  UserAuthService(String client)
      : super("https://api.introduktion.nu/viauth/index.php/", "digicy_introduktion_client_" + client);
}