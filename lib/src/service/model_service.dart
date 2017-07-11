library model_service;

import 'dart:async';
import 'dart:convert' show JSON;
import 'package:angular2/core.dart';
import '../service/config_service.dart';
import '../model/model_base.dart';
import '../util/dig_query.dart';

part 'action_service.dart';
part 'course_service.dart';
part 'learning_content_service.dart';
part 'push_notification_service.dart';
part 'user_service.dart';

abstract class ModelService
{
  ModelService(this._source);

  Future<Map<String, ModelBase>> fetchAll({String where = null, buffer = true}) async
  {
    try
    {
      return _onDataFetched((where == null) ? await _dq.get("/$_source") : await _dq.get("/$_source?$where"), buffer);
    } catch(e)
    {
      print(e.target.responseText);
      return {};
    }
  }

  Future delete(ModelBase model) async
  {
    if (model != null && model.id != null)
    {
      try
      {
        await _dq.delete("/$_source/${model.id}");
        if (_data.containsKey(model.id)) _data.remove(model.id);

        _data = new Map.from(_data);
      }
      catch (e)
      {
        throw new Exception(e.target.responseText);
      }
    }
  }

  Future<String> put(ModelBase model) async
  {
    try
    {
      if (model.id == null) model.id = await _dq.put("/$_source", model.encode());
      else model.id = await _dq.put("/$_source/${model.id}", model.encode());
      _data[model.id] = model;
      _data = new Map.from(_data);
      return model.id;
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

  Future<ModelBase> fetchModel(String id) async
  {
    if (id == null || id.isEmpty) return null;
    String response = await _dq.get("/$_source/$id");
    if (response.isEmpty) return null;
    _data[id] = create(JSON.decode(response));
    return _data[id];
  }

  ModelBase getModel(String id);

  ModelBase create(Map<String, dynamic> data);

  List<ModelBase> getModelsAsList([List<String> ids = null])
  {
    if (_data == null || _data.isEmpty) return [];
    if (ids == null) return _data.values.toList(growable: false);
    else return _data.keys.where(ids.contains).map((key) => _data[key]).toList(growable: false);
  }

  Map<String, ModelBase> getModelsAsMap([List<String> ids = null])
  {
    Map<String, ModelBase> output = new Map();
    if (_data == null || _data.isEmpty) return output;

    if (ids == null) _data.keys.forEach((id) => output[id] = _data[id]);

    else ids.forEach((id) => output[id] = _data[id]);

    return output;
  }

  List<String> getIdsByProperty(String property, String value)
  {
    if (value is String)
    {
      return _data.keys.where((id) =>
      _data[id].properties[property] != null && (_data[id].properties[property] as String).toLowerCase().compareTo(value.toLowerCase()) == 0).toList();
    }
    else
    {
      return _data.keys.where((id) => _data[id].properties[property] != null && _data[id].properties[property] == value).toList();
    }
  }

  Map<String, ModelBase> _onDataFetched(String response, bool buffer);

  Map<String, ModelBase> get data => _data;
  bool get isLoading => _isLoading;

  bool _isLoading = false;
  Map<String, ModelBase> _data = new Map();
  final DigQuery _dq = new DigQuery();
  final String _source;
}