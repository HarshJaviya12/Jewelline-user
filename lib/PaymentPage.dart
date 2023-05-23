import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jewellin_user/All-MODEL-CLASS/MethodClass.dart';
import 'package:jewellin_user/MyOrders-Page.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Payment extends StatefulWidget {
  Payment(
      {Key? key,
      this.UserName,
      this.UserEmail,
      this.UserNumber,
      this.ProductName,
      this.ProductPrice,
      this.ProductPhoto,
      this.Address,
      this.StateName,
      this.Pincode,
      this.CityName})
      : super(key: key);

  String? UserName;
  String? UserEmail;
  String? UserNumber;
  String? ProductPrice;
  String? ProductName;
  String? ProductPhoto;
  String? Address;
  String? StateName;
  String? Pincode;
  String? CityName;

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  TextEditingController Cardcontroller = TextEditingController();
  TextEditingController Cvvcontroller = TextEditingController();
  TextEditingController Expirycontroller = TextEditingController();

  var key = GlobalKey<FormState>();

  Method ref = Method();

  String? payment;

  CredicardDialogbox() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: Text(
                "Enter card Deatils",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              actions: [
                Container(
                  // height: 300,
                  child: Form(
                    key: key,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: Cardcontroller,
                            validator: (k2) {
                              if (k2!.isEmpty) {
                                return " Enter Card number";
                              } else if (k2.length < 19) {
                                return "Enter valid number";
                              }
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(19),
                              FilteringTextInputFormatter.digitsOnly,
                              CreditCardInputFormat()

                            ],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: "Enter Credit Card Number",
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.credit_card),
                                ),
                                filled: true,
                                fillColor: Colors.grey[350],
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10.0))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(3)
                            ],
                            controller: Cvvcontroller,
                            validator: (k2) {
                              if (k2!.isEmpty) {
                                return "Enter Cvv";
                              } else if (k2.length < 3) {
                                return "Cvv is Invalid";
                              }
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[350],
                                labelText: "Enter Cvv Number",
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10.0))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: Expirycontroller,
                            validator: (k2) {
                              if (k2!.isEmpty) {
                                return "Enter Date";
                              }
                            },
                            keyboardType: TextInputType.number,
                            readOnly: true,
                            showCursor: true,
                            decoration: InputDecoration(
                                fillColor: Colors.grey[350],
                                filled: true,
                                prefixIcon: IconButton(
                                  onPressed: () => _selectDate(context),
                                  icon: Icon(Icons.calendar_today),
                                ),
                                labelText: "Expiry Date",
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10.0))),
                            onTap: () => _selectDate(context),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  onPressed: () {

                                    setState(() {
                                      Navigator.pop(context);
                                      payment = "Paytm";
                                    });
                                    },
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(color: Colors.black),
                                  )),
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                onPressed: () {

                                  if (key.currentState!.validate()) {
                                    print("its validate");
                                    Navigator.pop(context);

                                  } else {
                                    print("its Invalid");
                                  }
                                },
                                child: Text(
                                  "Ok",
                                  style: TextStyle(color: Colors.black),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]);
        });
  }

  PaymentDialogbox() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: Text(
                "Are You sure You  Pay This Bill From ${payment}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {

                      ref.OrderPayment(
                        widget.UserName.toString(),
                        widget.UserEmail.toString(),
                        widget.UserNumber.toString(),
                        widget.ProductPrice.toString(),
                        widget.ProductName.toString(),
                        widget.ProductPhoto.toString(),
                        widget.Address.toString(),
                        widget.CityName.toString(),
                        widget.StateName.toString(),
                        widget.Pincode.toString(),
                        Cardcontroller.text.toString(),
                        Cvvcontroller.text.toString(),
                        Expirycontroller.text.toString(),
                        payment.toString(),
                      )
                          .whenComplete(() => Navigator.pop(context)).whenComplete(() =>
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Order Placed Successfully")))

                      )

                          .whenComplete(() =>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyOrders())));

                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: Text(
                    "Yes",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: Text(
                    "Cancle",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ]);
        });
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2050));
    if (picked != null)
      setState(() {
        Expirycontroller.text = formatDate(picked, [dd, '/', yyyy]);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: GradientText(
            "Payment",
            style: TextStyle(fontSize: 25),
            colors: [Colors.black, Colors.blueGrey, Colors.red, Colors.brown],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "What is your Payment Method?",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Divider(
              color: Colors.black,
            ),
            RadioListTile(
              activeColor: Colors.orangeAccent,
              title: Text(
                "Paytm",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              value: "Paytm",
              groupValue: payment,
              onChanged: (value) {

                setState(() {
                  payment = value;
                });
              },
            ),
            RadioListTile(
              activeColor: Colors.orangeAccent,
              title: Text(
                "Credit Card",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              value: "credit card",
              groupValue: payment,
              onChanged: (value) {
                setState(() {
                  CredicardDialogbox();
                  payment = value;
                });
              },
            ),
            RadioListTile(
              activeColor: Colors.orangeAccent,
              title: Text(
                "Goggle Pay",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              value: "Google pay",
              groupValue: payment,
              onChanged: (value) {
                setState(() {
                  payment = value;
                });
              },
            ),
            RadioListTile(
              activeColor: Colors.orangeAccent,
              title: Text(
                "Phone Pay",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              value: "Phonepay",
              groupValue: payment,
              onChanged: (value) {
                setState(() {

                  payment = value;
                });
              },
            ),
            RadioListTile(
              activeColor: Colors.orangeAccent,
              title: Text(
                "Cash on Dilevary",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              value: "cash",
              groupValue: payment,
              onChanged: (value) {
                setState(() {
                  payment = value;
                });
              },
            ),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () {
                    PaymentDialogbox();
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35))),
                  child: Text(
                    "Pay",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.black),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class DateFormat {
  DateFormat(String Dateformat);

  format(DateTime selectedDate) {}
}

class CreditCardInputFormat extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    String Enterdata = newValue.text;
    StringBuffer buffer = StringBuffer();

    for (int i = 0; i < Enterdata.length; i++) {
      buffer.write(Enterdata[i]);
      int index = i + 1;
      if (index % 4 == 0 && Enterdata.length != index) {
        buffer.write(" ");
      }
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.toString().length),
    );
  }
}
