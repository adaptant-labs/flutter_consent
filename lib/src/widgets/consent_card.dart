import 'package:flutter/material.dart';
import '../consent_specification.dart';

class ConsentCard extends StatelessWidget {
  static final FlutterConsent _flutterConsent = FlutterConsent();

  final Icon icon;
  final Color color;
  final ConsentSpecification spec;

  ConsentCard({this.icon, this.color, @required this.spec});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  icon ?? Icon(Icons.assignment_turned_in,
                      color: color ?? Colors.blue, size: 40),
                  ListTile(
                    title: Text(spec.title,
                        style: Theme.of(context).textTheme.subtitle),
                    subtitle: Text(spec.description),
                    isThreeLine: true,
                  ),
                  Divider(),
                  ListTile(
                    title: Text('We will use',
                        style: Theme.of(context).textTheme.subtitle),
                    subtitle: Text(_flutterConsent.formatScopes(spec.scopes)),
                  ),
                  ListTile(
                    title: Text('For the purpose of',
                        style: Theme.of(context).textTheme.subtitle),
                    subtitle: Text(spec.purpose),
                  ),
                  Divider(),
                ],
              ),
            ),
          ),
        ],
      ),
      elevation: 10.0,
    );
  }
}