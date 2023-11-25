import 'package:flutter/material.dart';

import '../utilties/constants.dart';

class ErrorMessage extends StatelessWidget {
  final String title, message;

  const ErrorMessage({Key? key, required this.title, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_rounded,
              size: 150,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              title,
              style: kDetailsTextStyle,
            ),
            Text(
              message,
              style: kLocationTextStyle,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

//import 'package:clima_app/utilties/constants.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class ErrorMessage extends StatefulWidget {
//   final String title, message;
//   const ErrorMessage({Key? key, required this.title, required this.message}) : super(key: key);
//
//   @override
//   State<ErrorMessage> createState() => _ErrorMessageState();
// }
//
// class _ErrorMessageState extends State<ErrorMessage> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Column(
//         children: [
//           Icon(Icons.error_rounded, size: 150,),
//           SizedBox(height: 20,),
//           Text(title, style: kDetailsTextStyle,),
//           Text(message, style: kLocationTextStyle, textAlign: TextAlign.center,)
//         ],
//       ),
//     );
//   }
// }
