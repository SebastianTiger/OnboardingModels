import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:onboarding_models/src/model/model_base.dart' show Config;
import 'package:onboarding_models/src/service/service_base.dart';

@Injectable()
class ConfigService extends ServiceBase
{
  ConfigService();

  Future<Config> fetchModel() async
  {
    Map<String, dynamic> response = await httpGET("config/1");
    _model = new Config.decode(response["body"]);
    return _model;
  }

  Future put() async
  {
    try
    {
      await httpPUT("config/1", model.encode());
    }
    on NoSuchMethodError catch (e)
    {
      throw new Exception(e);
    }
    catch (e)
    {
      throw new Exception(e.target.responseText);
    }
  }

  Config get model => _model;

  Config _model;
}
