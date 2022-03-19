import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName {
    if (kReleaseMode) {
      return '.env.production';
    }
    return '.env.development';
  }

  static String get apiUrl {
    return dotenv.env['API_URL'] ?? "API_URL not found";
  }

  static String get registration {
    return dotenv.env['REGISTRATION'] ?? "REGISTRATION not found";
  }

  static String get login {
    return dotenv.env['LOGIN'] ?? "LOGIN not found";
  }

  static String get logout {
    return dotenv.env['LOGOUT'] ?? "LOGOUT not found";
  }

  static String get loggedInUser {
    return dotenv.env['LOGGEDINUSER'] ?? "LOGGEDINUSER not found";
  }

  static String get leaseagreements {
    return dotenv.env['LEASEAGREEMENTS'] ?? "LEASEAGREEMENTS not found";
  }

  static String get conversation {
    return dotenv.env['CONVERSATION'] ?? "CONVERSATION not found";
  }

  static String get websocket {
    return dotenv.env['WEBSOCKET'] ?? "WEBSOCKET not found";
  }

  static String get payment {
    return dotenv.env['PAYMENT'] ?? "PAYMENT not found";
  }

  static String get maintenance {
    return dotenv.env['MAINTENANCE'] ?? "MAINTENANCE not found";
  }
}
