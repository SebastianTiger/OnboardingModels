import 'package:angular/angular.dart';
import 'package:vi_auth_client/vi_auth_client.dart';

@Injectable()
class AdminAuthService extends ViAuthClient
{
  AdminAuthService() : super("https://api.introduktion.nu/viauth/index_admin.php/", "digicy_introduktion_admin");
}