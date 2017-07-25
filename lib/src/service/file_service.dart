import 'dart:async' show Future;
import 'package:angular2/core.dart';
import 'package:onboarding_models/src/model/file.dart';
import 'package:onboarding_models/src/service/service_base.dart';

@Injectable()
class FileService extends ServiceBase
{
  FileService()
  {
    httpGET("file").then(_onDataFetched).catchError((e) => print(e.target.responseText));
  }

  Future put(String filename, String url_data) async
  {
    try
    {
      await httpPUT("file", {"filename":filename, "data":url_data});
      await _onDataFetched(await httpGET("file"));
    }
    catch (e)
    {
      throw new Exception(e.target.responseText);
    }
  }

  void _onDataFetched(Map<String, dynamic> response)
  {
    List<Map<String, String>> table = response['body'];
    _data = new Map();
    table.forEach((row) => _data[row["name"]] = new FileModel(row["name"], row["type"], row["size"]));
  }

  Map<String, FileModel> get data => _data;
  Map<String, FileModel> _data;
}