import 'dart:async';
import 'dart:convert';
import 'dart:html';

class DigQuery
{
  DigQuery();

  Future<String> delete(String url) async
  {
    HttpRequest req = await HttpRequest.request(apiUrl + url, method: "DELETE", withCredentials: false);
    return req?.responseText;
  }

  Future<String> get(String url) async
  {
    return await HttpRequest.getString(apiUrl + url, withCredentials: false);
  }

  /*
  PUT puts a file or resource at a specific URI, and exactly at that URI.
  If there's already a file or resource at that URI, PUT replaces that file or
  resource. If there is no file or resource there, PUT creates one.
  */
  Future<String> put(String url, Map<String, dynamic> data) async
  {
    HttpRequest req = await HttpRequest.request(apiUrl + url, method: "PUT", withCredentials: false, sendData: JSON.encode(data));
    return req.responseText;
  }

  Future<String> post(String url, Map<String, String> data) async
  {
    HttpRequest req = await HttpRequest.postFormData(apiUrl + url, data);
    return req.responseText;
  }

  String apiUrl = "https://api.introduktion.nu/admin2.php";
}