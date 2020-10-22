import 'package:api_flutter/app/services/api.dart';
import 'package:flutter/material.dart';

class EndpointCard extends StatelessWidget {
  final Endpoint endpoint;
  final int value;

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
                'Cases',
                style: Theme.of(context).textTheme.headline5,
              ),

              Text(
                value?.toString() ?? '',
                style: Theme.of(context).textTheme.headline4,
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
