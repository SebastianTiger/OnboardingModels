import 'package:http/http.dart' as http show Response;
import 'package:fo_components/fo_components.dart' show PhraseService;

class HttpError implements Exception
{
  HttpError(http.Response response) :
        httpStatus = response.statusCode,
        requestUrl = response.request.url.toString(),
        message = response.body;

  @override
  String toString()
  {
    return "$httpStatus: $message ($requestUrl)";
  }

  /**
   * Phrases.dart should contain keys for any status codes which is to be translated, ex:
   * "http_404" : "Resource was not found!",
   * "http_500" : "An internal server has occurred! Please contact us if the problem persists."
   */
  String translated(PhraseService phrase) => "$httpStatus: ${phrase.get('http_$httpStatus')} ($requestUrl)";

  final int httpStatus;
  final String requestUrl;
  final String message;
}