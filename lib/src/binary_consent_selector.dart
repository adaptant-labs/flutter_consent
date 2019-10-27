import 'package:flutter/material.dart';
import 'widgets/consent_tile.dart';
import 'consent_specification.dart';

class BinaryConsentSelector extends StatefulWidget {
  final List<ConsentSpecification> consentSpecifications;
  final ValueChanged<List<int>> onChanged;

  BinaryConsentSelector({
    Key key,
    @required this.consentSpecifications,
    @required this.onChanged,
  }) : super(key: key);

  @override
  _BinaryConsentSelectorState createState() => _BinaryConsentSelectorState();
}

class _BinaryConsentSelectorState extends State<BinaryConsentSelector> {
  List<int> allowedIndices = List<int>();

  void toggleConsentForIndex(bool consented, int index) {
    if (consented) {
      allowedIndices.add(index);
    } else {
      allowedIndices.remove(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(child:
          ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            itemCount: widget.consentSpecifications.length,
            itemBuilder: (context, index) {
              return ConsentTile(
                onChanged: (consented) =>
                    toggleConsentForIndex(consented, index),
                consentSpecification: widget.consentSpecifications[index],
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: SizedBox(
            width: double.infinity,
            child: RaisedButton(
              color: Colors.blue,
              child: Text('Use this setting',
                  style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (allowedIndices == null) {
                  print("list is null");
                }
                widget.onChanged(allowedIndices);
              },
            ),
          ),
        ),
      ],
    );
  }
}
