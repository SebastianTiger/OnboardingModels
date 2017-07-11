import 'dart:async' show Future;
import 'dart:convert' show JSON;
import 'package:angular2/core.dart';
import '../model/file.dart';
import '../util/dig_query.dart';

@Injectable()
class FileService
{
  FileService()
  {
    _dq.get("/file").then(_onDataFetched).catchError((e) => print(e.target.responseText));
  }

  Future put(String filename, String url_data) async
  {
    try
    {
      await _dq.put("/file", {"filename":filename, "data":url_data});
      await _onDataFetched(await _dq.get("/file"));
    }
    catch (e)
    {
      throw new Exception(e.target.responseText);
    }
  }

  void _onDataFetched(String response)
  {
    List<Map<String, String>> table = JSON.decode(response);
    _data = new Map();
    table.forEach((row) => _data[row["name"]] = new FileModel(row["name"], row["type"], row["size"]));
  }

  Map<String, FileModel> get data => _data;

  Map<String, FileModel> _data;
  final DigQuery _dq = new DigQuery();

}