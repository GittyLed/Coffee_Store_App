import 'package:coffee_store_app/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class PaymentPage extends StatefulWidget {
  final VoidCallback onPaymentSuccess;
  PaymentPage({required this.onPaymentSuccess});
  PaymentPageState createState() => PaymentPageState();
}

class PaymentPageState extends State<PaymentPage> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  void valid(){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.brown,
          title: Text(
            "Payment Successful!",
            style: TextStyle(color: Colors.white,),
          ),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(context);
                Navigator.pop(context, true);
              },
              child: Text("Ok", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text("Payment"),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              onCreditCardWidgetChange: (CreditCardBrand) {},
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CreditCardForm(
                      formKey: formKey,
                      obscureCvv: true,
                      obscureNumber: true,
                      cvvCode: cvvCode,
                      cardHolderName: cardHolderName,
                      expiryDate: expiryDate,
                      cardNumber: cardNumber,
                      onCreditCardModelChange: onCreditCardModelChange,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          widget.onPaymentSuccess();
                          valid();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Invalid Card",
                              ),
                            ),
                          );
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.all(8),
                        child: Text(
                          'Pay Now',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}