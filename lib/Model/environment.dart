import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get apiUrl {
    String? url = dotenv.env['API_URL'];
    if(url == null)
    {
      throw Exception("apiUrl is null");
    }
    return url;
  }

  static String get websocketUrl {
    String? url = dotenv.env['WEBSOCKET'];
    if(url == null)
    {
      throw Exception("websocket url is null");
    }
    return url;
  }
}
