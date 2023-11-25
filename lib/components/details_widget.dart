import 'package:clima_app/utilties/constants.dart';
import 'package:flutter/material.dart';

class DetailsWidget extends StatelessWidget {
  final String title, value;

  const DetailsWidget({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value,
              style: kDetailsTextStyle,
            ),
            Visibility(
                visible: title == 'WIND' ? true : false,
                child: const Text(
                  ' km/hr',
                  style: kDetailsTitleTextStyle,
                )),
          ],
        ),
        Text(
          title,
          style: kDetailsTitleTextStyle,
        ),
      ],
    );
  }
}
