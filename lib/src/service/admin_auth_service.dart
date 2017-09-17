import 'package:vi_auth_client/vi_auth_client.dart';

class AdminAuthClient extends ViAuthClient
{
  AdminAuthClient(String client) : super("https://api.introduktion.nu/viauth/index_admin.php/", "digicy_introduktion_admin_$client");
}