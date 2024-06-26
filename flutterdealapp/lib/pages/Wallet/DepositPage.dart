import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdealapp/pages/Wallet/WalletPage.dart';
import 'package:flutterdealapp/pages/application/application_page.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_bloc.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_event.dart';

class DepositPage extends StatefulWidget {
  const DepositPage({super.key});

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Deposit')),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 350.w,
            height: 500.h,
            margin: EdgeInsets.all(20),
            // padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                buildTextField('Card Number', cardNumberController),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                        child: buildTextField(
                            'Expiry Date', expiryDateController)),
                    SizedBox(width: 10),
                    Expanded(child: buildTextField('CVV', cvvController)),
                  ],
                ),
                SizedBox(height: 10),
                buildTextField('Name on Card', nameController),
                SizedBox(height: 10),
                buildTextField('Amount', amountController),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildAmountButton('200'),
                    buildAmountButton('500'),
                    buildAmountButton('1,000'),
                    buildAmountButton('2,000'),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    double? amount = double.tryParse(
                        amountController.text.replaceAll(',', ''));

                    BlocProvider.of<EditProfileBloc>(context)
                        .add(updateCoinEvent(
                      uid,amount!
                    ));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ApplicationPage(initialIndex: 3,)
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: Text('deposit', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextField(
        maxLength: cvvController == controller ? 3 : null,
        // maxLengthEnforcement: MaxLengthEnforcement.none,

        keyboardType: amountController == controller
            ? TextInputType.number
            : TextInputType.text,
        controller: controller,
        decoration: InputDecoration(
          counterText: '',
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.lightBlue, width: 2),
          ),
        ),
      ),
    );
  }

  Widget buildAmountButton(String amount) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        side: BorderSide(color: Colors.lightBlue, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Text(
        amount,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
