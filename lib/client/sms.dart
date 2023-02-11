import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';

class SendSms extends StatelessWidget {
  const SendSms({super.key});
  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _sendSMS('hello world', ['00967772969361']);
          },
          child: const Text('hello world'),
        ),
      ),
    );
  }
}
