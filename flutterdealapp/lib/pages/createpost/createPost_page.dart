import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../model/usermodel.dart';
import '../Profile/bloc/profile_bloc.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final uid = FirebaseAuth.instance.currentUser;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController detailController = TextEditingController();
  final TextEditingController pricePayController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController locationDetailController = TextEditingController();
  final TextEditingController dateTimeController = TextEditingController();
  final FocusNode pricePayFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    pricePayFocusNode.addListener(() {
      if (!pricePayFocusNode.hasFocus) {
        final text = pricePayController.text.replaceAll(',', '');
        final number = int.tryParse(text);
        if (number != null) {
          pricePayController.text = NumberFormat('#,##0').format(number);
        }
      }
    });
  }

  @override
  void dispose() {
    pricePayController.dispose();
    pricePayFocusNode.dispose();
    super.dispose();
  }

  UserModel? userModel = UserModel();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      if (state is getDataState) {
        userModel = state.userModel;
        return Container(
          color: Colors.white,
          child: Scaffold(
            appBar: buildAppBarEditProfile(context),
            body: _showForm(context, userModel),
          ),
        );
      } else {
        return Container(
          color: Colors.white,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    });
  }

  Widget _showForm(BuildContext context, UserModel? userModel) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            maxLines: null,
            controller: titleController,
            decoration: InputDecoration(
              labelText: 'Title',
              suffixIcon: Icon(Icons.arrow_forward_ios),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            maxLines: null,
            controller: detailController,
            decoration: InputDecoration(
              labelText: 'detail',
              suffixIcon: Icon(Icons.arrow_forward_ios),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            maxLength: 30,
            maxLines: null,
            controller: locationController,
            decoration: InputDecoration(
              labelText: 'Location',
              suffixIcon: Icon(Icons.arrow_forward_ios),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            maxLines: null,
            controller: locationDetailController,
            decoration: InputDecoration(
              labelText: 'Location detail',
              suffixIcon: Icon(Icons.arrow_forward_ios),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            maxLines: null,
            controller: pricePayController,
            focusNode: pricePayFocusNode,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp(r'^\d*,?\d*\.{0,1}\d{0,2}$')), // Corrected regex
            ],
            decoration: InputDecoration(
              labelText: 'Price Pay',
              suffixIcon: Icon(Icons.arrow_forward_ios),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a price';
              }
              String valueWithoutCommas = value.replaceAll(',', '');
              final n = num.tryParse(valueWithoutCommas);
              if (n == null) {
                return '"$value" is not a valid number';
              }
              return null; // Return null if the input is valid
            },
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              // Implement image upload functionality
            },
            child: Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(child: Icon(Icons.upload)),
            ),
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              // Implement create post functionality
            },
            child: Text('สร้างดีล'),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBarEditProfile(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: Colors.grey.withOpacity(0.5),
          height: 1.0,
        ),
      ),
      title: Text(
        "Create Post",
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
