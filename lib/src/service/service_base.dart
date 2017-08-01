import 'dart:async' show Future;
import 'dart:convert' show JSON;
import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http show Response;

abstract class ServiceBase
{
  Future<dynamic> httpPOST(String url, Map<String, dynamic> body) async
  {
    _loading = true;
    http.Response response = await client.post(_apiBase + url, body: JSON.encode(body));
    _loading = false;

    if (response.statusCode != 200)
    {
      throw new Exception("${response.body} (http-status: ${response.statusCode})");
    }

    return response.body;
  }

  /**
   * Returns either a Map<String, dynamic> if a single resource was requested,
   * or a List<Map<String, dynamic> if multiple resources.
   */
  Future<dynamic> httpGET(String url) async
  {
    _loading = true;
    http.Response response = await client.get(_apiBase + url);
    _loading = false;

    if (response.statusCode != 200)
    {
      throw new Exception("${response.body} (http-status: ${response.statusCode})");
    }

    return JSON.decode(response.body);
  }

  /**
   * Returns id of created resource in most cases, or a status message
   */
  Future<String> httpPUT(String url, Map<String, dynamic> body) async
  {
    _loading = true;
    http.Response response = await client.put(_apiBase + url, body: JSON.encode(body));
    _loading = false;

    if (response.statusCode != 200)
    {
      throw new Exception("${response.body} (http-status: ${response.statusCode})");
    }

    return response.body;
  }

  Future httpDELETE(String url) async
  {
    _loading = true;
    http.Response response = await client.delete(_apiBase + url);
    _loading = false;

    if (response.statusCode != 200)
    {
      throw new Exception("${response.body} (http-status: ${response.statusCode})");
    }
  }

  bool get loading => _loading;

  final String _apiBase = "https://api.introduktion.nu/v1/index.php/";
  final BrowserClient client = new BrowserClient();
  bool _loading = false;
}