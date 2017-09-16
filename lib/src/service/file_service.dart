import 'dart:async' show Future;
import 'package:angular/angular.dart';
import 'package:onboarding_models/src/model/file.dart';
import 'package:onboarding_models/src/service/http_service.dart';

/**
 * Manage files on admin side
 */

@Injectable()
class FileService extends HttpService
{
  FileService()
  {
    //fetchAll();
  }

  Future fetchAll() async
  {
    _onDataFetched(await httpGET("file"));
  }

  Future delete(String filename) async
  {
    await httpDELETE("file/$filename");
  }

  Future put(String filename, String url_data) async
  {
    await httpPUT("file", {"filename":filename, "data":url_data});
    await _onDataFetched(await httpGET("file"));
  }

  Future<String> fetchUsedSpace() async
  {
    return await httpPOST("file/fetch_used_space", null);
  }

  void _onDataFetched(List<Map<String, dynamic>> response)
  {
    _data = new Map();
    response.forEach((row) => _data[row["name"]] = new FileModel(row["name"], row["type"], row["size_kb"]));
  }

  Map<String, FileModel> get data => _data;
  Map<String, FileModel> _data = new Map();
}