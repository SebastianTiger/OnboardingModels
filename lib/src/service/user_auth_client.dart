import 'package:vi_auth_client/vi_auth_client.dart';

class UserAuthClient extends ViAuthClient
{
  UserAuthClient(String client)
      : super("https://api.introduktion.nu/viauth/index.php/", "digicy_introduktion_client_$client");
}