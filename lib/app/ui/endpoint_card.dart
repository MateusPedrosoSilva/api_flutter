import 'package:api_flutter/app/services/api.dart';
import 'package:flutter/material.dart';

class EndpointCard extends StatelessWidget {
  final Endpoint endpoint;
  final int value;

  static Map<Endpoint, String> _cardTitles = {
    Endpoint.cases: 'Cases',
    Endpoint.casesSuspected: 'casesSuspected',
    Endpoint.casesConfirmed: 'casesConfirmed',
    Endpoint.deaths: 'deaths',
    Endpoint.recovered: 'recovered',
  };

  const EndpointCard({Key key, this.endpoint, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _cardTitles[endpoint],
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                value?.toString() ?? '',
                style: Theme.of(context).textTheme.headline4.copyWith(
                      fontSize: 20,
                    ),
              ),
              // other way
              // Text(value != null ? value.toString() : ''),
            ],
          ),
        ),
      ),
    );
  }
}
