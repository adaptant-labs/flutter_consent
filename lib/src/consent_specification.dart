import 'package:flutter/material.dart';

class FlutterConsent {
  String formatScopes(List<String> scopes) {
    if (scopes.length == 1) {
      return scopes.first;
    } else if (scopes.length == 2) {
      return scopes.first + " and " + scopes.last;
    } else {
      // Handle oxford comma insertion
      Iterable<String> scopeStr = scopes.getRange(0, scopes.length - 1);
      return scopeStr.join(', ') + ", and ${scopes.last}";
    }
  }
}

class ConsentSpecification {
  String title;
  String description;
  List<String> scopes;
  String purpose;
}

class ConsentSpecificationResponse {
  final List<String> allowedScopes;
  final List<String> deniedScopes;
  final int level;

  const ConsentSpecificationResponse({
    @required this.allowedScopes,
    this.deniedScopes,
    @required this.level
  });
}