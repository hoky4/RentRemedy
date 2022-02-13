import 'package:flutter/foundation.dart';
import 'package:rentremedy_mobile/models/Auth/logged_in_user.dart';
import 'package:rentremedy_mobile/models/LeaseAgreement/lease_agreement.dart';

enum AuthStatus { pending, loggedIn, notLoggedIn }

class AuthModelProvider extends ChangeNotifier {
  LoggedInUser? _loggedInUser;
  AuthStatus _status = AuthStatus.pending;

  void loginUser(LoggedInUser loggedInUser) {
    _loggedInUser = loggedInUser;
    _status = AuthStatus.loggedIn;
    notifyListeners();
  }

  void notLoggedIn() {
    _status = AuthStatus.notLoggedIn;
    notifyListeners();
  }

  void logoutUser() {
    _loggedInUser = null;
    _status = AuthStatus.notLoggedIn;
    notifyListeners();
  }

  LoggedInUser? get user {
    return _loggedInUser;
  }

  String? get cookie {
    return _loggedInUser?.cookie;
  }

  String? get landlordId {
    return _loggedInUser?.leaseAgreement?.landlord.id;
  }

  LeaseAgreement? get leaseAgreement {
    return _loggedInUser?.leaseAgreement;
  }

  bool get isLoggedIn {
    return _loggedInUser != null;
  }

  AuthStatus get status {
    return _status;
  }
}
