import 'package:flutter/material.dart';
import 'package:flutter_radio_slider/flutter_radio_slider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'consent_specification.dart';
import 'consent_card.dart';

class LinearConsentSelector extends StatefulWidget {
  final List<ConsentSpecification> consentSpecifications;
  final int levelConsented;
  final ValueChanged<int> onChanged;

  const LinearConsentSelector({
    Key key,
    @required this.consentSpecifications,
    this.levelConsented = 0,
    @required this.onChanged,
  }) : assert(levelConsented >= 0),
       super(key: key);

  @override
  _LinearConsentSelectorState createState() => _LinearConsentSelectorState();
}

class _LinearConsentSelectorState extends State<LinearConsentSelector> {
  SwiperController swiperController = SwiperController();
  int _divisions;
  int _value;

  @override
  void initState() {
    super.initState();
    _value = widget.levelConsented;
    _divisions = widget.consentSpecifications.length - 1;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        RadioSlider(
          key: ValueKey(_value),
          value: _value,
          divisions: _divisions,
          activeColor: Colors.blue,
          outerCircle: false,
          orientation: RadioSliderOrientation.Vertical,
          onChanged: (value) {
            setState(() {
              _value = value;
            });

            swiperController.move(value);
          },
        ),
        Expanded(
          child: Card(
            child: Column(children: <Widget>[
              Expanded(
                child: Swiper(
                  index: _value,
                  onIndexChanged: (index) {
                    setState(() {
                      _value = index;
                    });
                  },
                  controller: swiperController,
                  itemBuilder: (BuildContext context, int index) {
                    return ConsentCard(spec: widget.consentSpecifications[index]);
                  },
                  autoplay: false,
                  itemCount: widget.consentSpecifications.length,
                  pagination: SwiperPagination(),
                  control: SwiperControl(),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text('Use this setting',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      widget.onChanged(_value);
                    },
                  ),
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
