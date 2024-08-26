import 'dart:convert';

import 'package:http/http.dart' as http;

class SendEmailService {
  static sendEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
    required String phone,
  }) async {
    try {
      var endPoint =
           Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
      var response = await http.post(
        endPoint,
        headers: {'content-type': 'application/json'},
        body: json.encode({
          'service_id': 'service_q5t4s49',
          'template_id': 'template_h6e6lss',
          'user_id': "7pg8VC8_4-xfKwtSM",
          'template_params': {
            'user_name': name,
            'user_email': email,
            'user_subject': subject,
            'user_message': message,
            // 'user_phone': phone,
          }
        }),
      );

      if (response.statusCode == 200) {
        print('send');
      }else{
        print(response.statusCode);
      }
    } catch (e) {
      print('error $e');
    }
  }
}
