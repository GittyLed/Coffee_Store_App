// import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

Future<void> sendEmail(String userEmail, String subject, String text) async {
  String username = 'ohadleib@gmail.com';
  // String username = 'hand3c23@mbjcomp.org.il';

  String password = 'bcep gayq pxzx oxkf';
  // String password = 'Gitty9565';

  // final smtpServer = SmtpServer(
  //   'smtp-mail.outlook.com',
  //   port: 587,
  //   username: username,
  //   password: password,
  //   ignoreBadCertificate: true, // For development purposes; consider removing or setting appropriately for production
  //   ssl: false,
  // );
  final smtpServer = gmail(username, password);
  

  final message = Message()
    ..from = Address(username, 'Coffee App')
    ..recipients.add(userEmail)
    ..subject = subject
    ..text = text
   ;
  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }

  

}
Future<void> verificationEmail(String email, String code) async{
    await sendEmail(email, 'Verification Code', 'your verification code is: ${code}');
  }

  Future<void> orderDetails(String email, String orderDetails, String total) async{
    await sendEmail(email, 'Your Order Details', 'Order Details:\n${orderDetails}\n\nTotal: \$${total}');
  }

