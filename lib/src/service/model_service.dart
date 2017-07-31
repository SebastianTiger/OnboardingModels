library model_service;

import 'dart:async';
import 'package:angular2/core.dart';
import 'package:onboarding_models/src/model/model_base.dart';
import 'package:onboarding_models/src/service/service_base.dart';

part 'action_service.dart';
part 'course_service.dart';
part 'learning_content_service.dart';
part 'push_notification_service.dart';
part 'user_service.dart';

abstract class ModelService extends ServiceBase
{
  ModelService(this._source);

  Future<Map<String, ModelBase>> fetchAll({String where = null, buffer = true}) async
  {
    return _onDataFetched((where == null) ? await httpGET(_source) : await httpGET("$_source?$where"), buffer);
  }

  Future delete(ModelBase model) async
  {
    if (model != null && model.id != null)
    {
      await httpDELETE("$_source/${model.id}");
      if (_data.containsKey(model.id)) _data.remove(model.id);
      _data = new Map.from(_data);
    }
  }

  Future<String> put(ModelBase model) async
  {
    if (model.id == null) model.id = (await httpPUT("$_source", model.encode()));
    else model.id = (await httpPUT("$_source/${model.id}", model.encode()));

    _data[model.id] = model;
    _data = new Map.from(_data);
    return model.id;
  }

  Future<ModelBase> fetchModel(String id) async
  {
    if (id == null || id.isEmpty) return null;
    Map<String, dynamic> response = await httpGET("$_source/$id");
    _data[id] = create(response);
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

  Map<String, ModelBase> _onDataFetched(List<Map<String, dynamic>> response, bool buffer);
  Map<String, ModelBase> get data => _data;
  Map<String, ModelBase> _data = new Map();
  final String _source;
}