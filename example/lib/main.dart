import 'package:flutter/material.dart';
import 'package:flutter_consent/flutter_consent.dart';

void main() => runApp(MyApp());

// Some example consent specifications that demonstrate a linear progression
var consentSpecStatic = ConsentSpecification()
  ..title =
      "I consent to allowing information minimal information about my vehicle to be used for risk scoring"
  ..description =
      "You consent to allowing the use of static vehicle data (make, model, and year)"
  ..scopes = ["VIN"]
  ..purpose = "Risk Assessment";

var consentSpecLocation = ConsentSpecification()
  ..title =
      "I consent to allowing my vehicle information and locational data to be used for risk scoring"
  ..description =
      "You consent to the analysis of static vehicle data and the collecting of positioning data for analysis"
  ..scopes = ["VIN", "Location"]
  ..purpose = "Risk Assessment";

var consentSpecSensors = ConsentSpecification()
  ..title =
      "I consent to allowing vehicle sensor data to be used for risk scoring"
  ..description =
      "You consent to the use of static vehicle data, location, as well as vehicle sensors that can advise harsh braking and acceleration"
  ..scopes = ["VIN", "Location", "Sensors"]
  ..purpose = "Risk Assessment";

var consentSpecBiometric = ConsentSpecification()
  ..title = "I consent to allowing biometric data to be used for risk scoring"
  ..description =
      "You consent to the use of available biometric data in addition to vehicle, location, and other vehicle sensor data"
  ..scopes = ["VIN", "Location", "Sensors", "Biometric"]
  ..purpose = "Risk Assessment";

var consentSpecifications = [
  consentSpecStatic,
  consentSpecLocation,
  consentSpecSensors,
  consentSpecBiometric
];

class LinearConsentDemo extends StatefulWidget {
  final int levelConsented;

  LinearConsentDemo({this.levelConsented = 0});

  @override
  _LinearConsentDemoState createState() => _LinearConsentDemoState();
}

class _LinearConsentDemoState extends State<LinearConsentDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Linear Consent Demo',
          style:
              Theme.of(context).textTheme.title.copyWith(color: Colors.white),
        ),
      ),
      body: LinearConsentSelector(
        levelConsented: widget.levelConsented,
        consentSpecifications: consentSpecifications,
        onChanged: (level) {
          ConsentSpecificationResponse response = ConsentSpecificationResponse(
            allowedScopes: consentSpecifications[level].scopes,
            level: level,
          );

          Navigator.pop(context, response);
        },
      ),
    );
  }
}

class BinaryConsentDemo extends StatefulWidget {
  @override
  _BinaryConsentDemoState createState() => _BinaryConsentDemoState();
}

class _BinaryConsentDemoState extends State<BinaryConsentDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Binary Consent Demo',
          style:
              Theme.of(context).textTheme.title.copyWith(color: Colors.white),
        ),
      ),
      body: BinaryConsentSelector(
        consentSpecifications: consentSpecifications,
        onChanged: (allowedIndices) {
          List<String> allowedScopes = List<String>();

          if (allowedIndices.isNotEmpty) {
            allowedIndices.forEach((index) =>
                allowedScopes.addAll(consentSpecifications[index].scopes));
            allowedScopes = allowedScopes.toSet().toList();
          }

          ConsentSpecificationResponse response = ConsentSpecificationResponse(
            allowedScopes: allowedScopes,
          );

          Navigator.pop(context, response);
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterConsent flutterConsent = FlutterConsent();
  String authorizedScopes = "";
  int levelConsented = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("Authorized Scopes: $authorizedScopes"),
          RaisedButton(
              onPressed: () async {
                final ConsentSpecificationResponse result =
                    await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BinaryConsentDemo()));
                setState(() {
                  authorizedScopes =
                      flutterConsent.formatScopes(result.allowedScopes);
                });
              },
              child: Text('Binary Consent Demo')),
          RaisedButton(
              onPressed: () async {
                final ConsentSpecificationResponse result =
                    await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            LinearConsentDemo(levelConsented: levelConsented)));
                setState(() {
                  authorizedScopes =
                      flutterConsent.formatScopes(result.allowedScopes);
                  levelConsented = result.level;
                });
              },
              child: Text('Linear Consent Demo')),
        ],
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        sliderTheme: SliderThemeData(
          trackHeight: 10,
          overlayColor: Colors.blue.withAlpha(32),
          activeTickMarkColor: Colors.lightBlue,
          activeTrackColor: Colors.grey[300],
          inactiveTrackColor: Colors.grey[300],
          inactiveTickMarkColor: Colors.grey[500],
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Consent example app'),
        ),
        body: MyHomePage(),
      ),
    );
  }
}
