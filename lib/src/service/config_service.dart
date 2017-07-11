import 'dart:async';
import 'dart:convert';
import 'package:angular2/angular2.dart';
import '../util/dig_query.dart';
import '../model/model_base.dart' show Config;

@Injectable()
class ConfigService
{
  ConfigService();

  Future<Config> fetchModel() async
  {
    _loading = true;
    _model = new Config.decode(JSON.decode(await _dq.get("/config/1")));
    _loading = false;
    return _model;
  }

  Future put() async
  {
    try
    {
      _loading = true;
      await _dq.put("/config/1", model.encode());
      _loading = false;
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

  bool get isLoading => _loading;
  Config get model => _model;

  Config _model;
  bool _loading = false;
  final DigQuery _dq = new DigQuery();
}
