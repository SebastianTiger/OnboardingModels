import 'dart:async' show Future;
import 'dart:convert' show JSON;
import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http show Response;

abstract class ServiceBase
{
  Future<Map<String, dynamic>> httpPOST(String url, Map<String, dynamic> body) async
  {
    _loading = true;
    http.Response response = await _client.post(_apiBase + url, body: JSON.encode(body));
    _loading = false;
    return JSON.decode(response.body);
  }

  Future<Map<String, dynamic>> httpGET(String url) async
  {
    _loading = true;
    http.Response response = await _client.get(_apiBase + url);
    _loading = false;
    return JSON.decode(response.body);
  }

  /**
   * Returns id of created resource
   */
  Future<Map<String, String>> httpPUT(String url, Map<String, dynamic> body) async
  {
    _loading = true;
    http.Response response = await _client.put(_apiBase + url, body: body);
    _loading = false;
    return JSON.decode(response.body);
  }

  Future httpDELETE(String url) async
  {
    await _client.delete(url);
  }

  bool get loading => _loading;

  final String _apiBase = "https://api.introduktion.nu/v1/admin.php/";
  final BrowserClient _client = new BrowserClient();
  bool _loading = false;
}