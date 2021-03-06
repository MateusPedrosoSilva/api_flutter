import 'package:api_flutter/app/services/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EndpointCardData {
  final String title;
  final String assetName;
  final Color color;

  EndpointCardData(this.title, this.assetName, this.color);
}

class EndpointCard extends StatelessWidget {
  final Endpoint endpoint;
  final int value;

  static Map<Endpoint, EndpointCardData> _cardData = {
    Endpoint.cases: EndpointCardData(
      'Cases',
      'assets/count.png',
      Color(0xFFFFF492),
    ),
    Endpoint.casesSuspected: EndpointCardData(
      'Suspect cases',
      'assets/suspect.png',
      Color(0xFFEEDA28),
    ),
    Endpoint.casesConfirmed: EndpointCardData(
      'Confirmed cases',
      'assets/fever.png',
      Color(0xFFE99600),
    ),
    Endpoint.deaths: EndpointCardData(
      'Deaths',
      'assets/death.png',
      Color(0xFFE40000),
    ),
    Endpoint.recovered: EndpointCardData(
      'Recovered',
      'assets/patient.png',
      Color(0xFF70A901),
    ),
  };

  String get formattedValue {
    if (value == null) {
      return '';
    }
    return NumberFormat('#,###,###,###').format(value);
  }

  const EndpointCard({Key key, this.endpoint, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardData = _cardData[endpoint];

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cardData.title,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: cardData.color),
              ),
              SizedBox(height: 4),
              SizedBox(
                height: 52,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      cardData.assetName,
                      color: cardData.color,
                    ),
                    Text(
                      formattedValue,
                      style: Theme.of(context).textTheme.headline4.copyWith(
                            fontWeight: FontWeight.w500,
                            color: cardData.color,
                          ),
                    ),
                    // other way
                    // Text(value != null ? value.toString() : ''),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
