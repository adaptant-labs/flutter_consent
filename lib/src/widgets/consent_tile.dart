import 'package:flutter/material.dart';
import '../consent_specification.dart';

class ConsentTile extends StatefulWidget {
  final ConsentSpecification consentSpecification;
  final ValueChanged<bool> onChanged;

  ConsentTile(
      {Key key, @required this.consentSpecification, @required this.onChanged})
      : super(key: key);

  @override
  _ConsentTileState createState() => _ConsentTileState();
}

class _ConsentTileState extends State<ConsentTile> {
  FlutterConsent _flutterConsent = FlutterConsent();
  bool _switchState;

  @override
  void initState() {
    super.initState();
    _switchState = false;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(widget.consentSpecification.title),
                  subtitle: Text(widget.consentSpecification.description),
                ),
                ListTile(
                  title: Text('We will use'),
                  subtitle: Text(_flutterConsent
                      .formatScopes(widget.consentSpecification.scopes)),
                ),
                ListTile(
                  title: Text('For the purpose of'),
                  subtitle: Text(widget.consentSpecification.purpose),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 60,
            child: Switch(
              value: _switchState,
              onChanged: (switchState) {
                setState(() {
                  _switchState = switchState;
                });

                widget.onChanged(switchState);
              },
            ),
          ),
        ],
      ),
    );
  }
}
