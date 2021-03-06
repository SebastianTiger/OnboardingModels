library model_service;

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:onboarding_models/src/model/model_base.dart';
import 'package:onboarding_models/src/service/http_service.dart';

part 'action_service.dart';
part 'course_service.dart';
part 'learning_content_service.dart';
part 'log_service.dart';
part 'push_notification_service.dart';
part 'user_service.dart';

abstract class ModelService<T> extends HttpService
{
  ModelService(this._source);

  Future<Map<String, T>> fetchAll({String where = null, buffer = true}) async
  {
    return _onDataFetched((where == null) ? await httpGET(_source) : await httpGET("$_source?${Uri.encodeFull(where)}"), buffer);
  }

  Future delete(T t) async
  {
    ModelBase model = t as ModelBase;

    if (model != null && model.id != null)
    {
      await httpDELETE("$_source/${model.id}");
      if (_data.containsKey(model.id)) _data.remove(model.id);
      _data = new Map.from(_data);
    }
  }

  Future<String> put(T t) async
  {
    ModelBase model = t as ModelBase;

    if (model.id == null) model.id = (await httpPUT("$_source", model.encode()));
    else model.id = (await httpPUT("$_source/${model.id}", model.encode()));

    _data[model.id] = t;
    _data = new Map.from(_data);
    return model.id;
  }

  Future<T> fetchModel(String id) async
  {
    if (id == null || id.isEmpty) return null;
    Map<String, dynamic> response = await httpGET("$_source/$id");
    _data[id] = create(response);
    return _data[id];
  }

  T getModel(String id);

  T create(Map<String, dynamic> data);

  List<T> getModelsAsList([List<String> ids = null])
  {
    if (_data == null || _data.isEmpty) return [];
    if (ids == null) return _data.values.toList(growable: false);
    else return _data.keys.where(ids.contains).map((key) => _data[key]).toList(growable: false);
  }

  Map<String, T> getModelsAsMap([List<String> ids = null])
  {
    Map<String, T> output = new Map();
    if (_data == null || _data.isEmpty) return output;

    if (ids == null) _data.keys.forEach((id) => output[id] = _data[id]);

    else ids.forEach((id) => output[id] = _data[id]);

    return output;
  }

  List<String> getIdsByProperty(String property, String value)
  {
    if (value is String)
    {
      Iterable<String> ids = _data.keys.where((id)
      {
        ModelBase model = _data[id] as ModelBase;
        return model.properties[property] != null && (model.properties[property] as String).toLowerCase().compareTo(value.toLowerCase()) == 0;
      });
      return ids.isEmpty ? [] : ids.toList();
    }
    else
    {
      Iterable<String> ids = _data.keys.where((id)
      {
        ModelBase model = _data[id] as ModelBase;
        return model.properties[property] != null && model.properties[property] == value;
      });

      return (ids.isEmpty) ? [] : ids.toList();
    }
  }

  Map<String, T> _onDataFetched(List<Map<String, dynamic>> response, bool buffer);
  Map<String, T> get data => _data;
  Map<String, T> _data = new Map();
  final String _source;
}