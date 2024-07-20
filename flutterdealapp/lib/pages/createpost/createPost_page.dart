import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdealapp/model/postmodel.dart';
import 'package:flutterdealapp/pages/UserBloc/user_provider.dart';
import 'package:flutterdealapp/pages/application/application_page.dart';
import 'package:flutterdealapp/pages/createpost/bloc/createPost_bloc.dart';
import 'package:flutterdealapp/pages/createpost/bloc/createPost_event.dart';
import 'package:flutterdealapp/pages/createpost/bloc/createPost_state.dart';
import 'package:flutterdealapp/pages/createpost/createPost_provider.dart';
import 'package:flutterdealapp/pages/post/bloc/post_state.dart';
import 'package:flutterdealapp/pages/postDetail/bloc/postDetail_event.dart';
import 'package:flutterdealapp/values/color.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import '../../model/usermodel.dart';
import '../Profile/bloc/profile_bloc.dart';
import '../UserBloc/bloc/user_bloc.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  CreatePostProvider createPostProvider = CreatePostProvider();
  String uid = FirebaseAuth.instance.currentUser!.uid;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController detailController = TextEditingController();
  final TextEditingController pricePayController = TextEditingController();
  final TextEditingController priceBuyController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController locationDetailController =
      TextEditingController();
  // final TextEditingController dateTimeController = TextEditingController();
  final FocusNode pricePayFocusNode = FocusNode();
  final FocusNode priceBuyFocusNode = FocusNode();
  PostModel postModel = PostModel();

  double? pricePayValue = 0;
  double? priceBuyValue = 0;
  double total = 0;

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
    priceBuyFocusNode.addListener(() {
      if (!priceBuyFocusNode.hasFocus) {
        final text = priceBuyController.text.replaceAll(',', '');
        final number = int.tryParse(text);
        if (number != null) {
          priceBuyController.text = NumberFormat('#,##0').format(number);
        }
      }
    });
  }

  bool isClick = false;

  @override
  void dispose() {
    pricePayController.dispose();
    pricePayFocusNode.dispose();
    priceBuyController.dispose();
    priceBuyFocusNode.dispose();
    super.dispose();
  }

  Future<void> getLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    print(position);
    currentLatitude = position.latitude;
    currentLongtitude = position.longitude;
  }

  double currentLatitude = 0;
  double currentLongtitude = 0;

  final DocumentReference newPostRef =
      FirebaseFirestore.instance.collection('posts').doc();

// Get the unique document ID

  UserModel? userModel = UserModel();

  @override
  Widget build(BuildContext context) {
    bool isSelectedReceive = true;

    return Container(
      // color: Colors.white,
      decoration: const BoxDecoration(
        // color: Colors.white,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            // Color.fromRGBO(207, 162, 250,100),
            // Color.fromRGBO(194, 233, 251, 100),

            Color.fromRGBO(224, 195, 252, 100),
            Color.fromRGBO(142, 197, 252, 100),
          ],
        ),
        // border: Border.all(
        //   width: 0.2,
        //   color: Colors.black,
        // ),
        // borderRadius: BorderRadius.circular(25),
      ),
      // child: SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: buildAppBarEditProfile(context),
          body: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 20),
            child: Container(
                decoration: const BoxDecoration(
                  // color: Colors.white,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      // Color.fromRGBO(207, 162, 250,100),
                      // Color.fromRGBO(194, 233, 251, 100),

                      Color.fromRGBO(224, 195, 252, 100),
                      Color.fromRGBO(142, 197, 252, 100),
                    ],
                  ),
                  // border: Border.all(
                  //   width: 0.2,
                  //   color: Colors.black,
                  // ),
                  // borderRadius: BorderRadius.circular(25),
                ),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      border: Border.all(
                        width: 0.1,
                        // color: Colors.black,
                      ),
                      // borderRadius: BorderRadius.circular(10),
                    ),
                    child: _showForm(context))),
          )),

      // ),
    );
  }

  Widget _showForm(BuildContext context) {
    String imageUrl;
    // print("state is $state ");
    return BlocConsumer<CreatePostBloc, createPostState>(
        listener: (context, state) {
      if (state is createPostSuccess) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ApplicationPage(
              initialIndex: 2,
            ),
          ),
        );
        print("success");
      }
    },
        // BlocBuilder<CreatePostBloc, createPostState>(
        builder: (context, state) {
      if (state is createPostLoading) {
        return Center(child: CircularProgressIndicator());
      }
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            buildSelectBox(context),
            SizedBox(height: 16),
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
            // SizedBox(height: 16),
            // TextFormField(
            //   maxLines: null,
            //   controller: locationDetailController,
            //   decoration: InputDecoration(
            //     labelText: 'Location detail',
            //     suffixIcon: Icon(Icons.arrow_forward_ios),
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //   ),
            // ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 100,
                  height: 50,
                  child: TextFormField(
                    maxLines: 1,
                    controller: pricePayController,
                    focusNode: pricePayFocusNode,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(
                          r'^\d*,?\d*\.{0,1}\d{0,2}$')), // Corrected regex
                    ],
                    decoration: InputDecoration(
                      labelText: 'Price Pay',
                      labelStyle: TextStyle(fontSize: 12),
                      // suffixIcon: Icon(Icons.arrow_forward_ios),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) {
                      pricePayValue = double.tryParse(value.toString());
                      // priceBuyValue = double.tryParse(value.toString());
                      BlocProvider.of<CreatePostBloc>(context).add(calTotal(
                          priceBuy: priceBuyValue, pricePay: pricePayValue));
                    },
                    validator: (value) {
                      pricePayValue = double.tryParse(value.toString());
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
                ),
                Container(
                  height: 50,
                  width: 100,
                  child: TextFormField(
                    maxLines: 1,
                    controller: priceBuyController,
                    focusNode: priceBuyFocusNode,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(
                          r'^\d*,?\d*\.{0,1}\d{0,2}$')), // Corrected regex
                    ],
                    onChanged: (value) {
                      // pricePayValue = double.tryParse(value.toString());
                      priceBuyValue = double.tryParse(value.toString());
                      BlocProvider.of<CreatePostBloc>(context).add(calTotal(
                          priceBuy: priceBuyValue, pricePay: pricePayValue));
                    },
                    decoration: InputDecoration(
                      labelText: 'Price Buy',
                      labelStyle: TextStyle(fontSize: 12),
                      // suffixIcon: Icon(Icons.arrow_forward_ios),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) {
                      priceBuyValue = double.tryParse(value.toString());
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
                ),
                BlocBuilder<CreatePostBloc, createPostState>(
                    builder: (context, state) {
                  if (state is calTotalSuccess) {
                    total = state.total;
                  } else {}
                  return Container(
                    width: 100,
                    height: 50,
                    child: TextFormField(
                        enabled: false,
                        maxLines: 1,
                        // controller: priceBuyController,
                        // focusNode: priceBuyFocusNode,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(
                              r'^\d*,?\d*\.{0,1}\d{0,2}$')), // Corrected regex
                        ],
                        decoration: InputDecoration(
                          labelText: total.toString(),
                          // labelStyle: TextStyle(fontSize: 12),
                          // suffixIcon: Icon(Icons.arrow_forward_ios),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        )),
                  );
                  // return Container(height: 50, width: 100, child: Text(
                  //   'Total: ${state is calTotalSuccess ? state.total : 0}',
                  //   style: TextStyle(fontSize: 12),

                  // ));
                }),
              ],
            ),

            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                selectFile(context);
                // Implement image upload functionality
              },
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: BlocBuilder<CreatePostBloc, createPostState>(
                    builder: (context, state) {
                  print("state is $state");
                  if (state is addImageSuccess) {
                    pickedFile = state.image;
                    print("steate is add");
                    return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(state.image.path!),
                          // fit: BoxFit.cover,
                        ));
                  }
                  if (state is createPostLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Center(child: Icon(Icons.upload));
                }),
              ),
            ),
            SizedBox(height: 15.h),
            SizedBox(
              height: 30.h,
              width: 100.w,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(83, 82, 125, 0.8),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  if (pickedFile == null ||
                          titleController.text.isEmpty ||
                          detailController.text.isEmpty ||
                          locationController.text.isEmpty ||
                          pricePayController.text.isEmpty ||
                          locationController.text.isEmpty ||
                          priceBuyController.text.isEmpty
            
                      // locationDetailController.text.isEmpty
            
                      ) {
                    return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('กรุณากรอกข้อมูลให้ครบถ้วน'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('ตกลง'),
                            ),
                          ],
                        );
                      },
                    );
                  }
            
                  print("uid = $uid");
                  var results = await Future.wait([
                    createPostProvider.imageToFirebase(pickedFile!),
                    createPostProvider.getUserData(uid.toString()),
                  ]);
                  imageUrl = results[0].toString();
                  userModel = results[1] as UserModel;
            
                  // imageUrl =
                  //     await createPostProvider.imageToFirebase(pickedFile!);
                  // userModel =
                  //     await createPostProvider.getUserData(uid.toString());
            
                  String priceText = pricePayController.text.replaceAll(',', "");
                  double pricePay = double.parse(priceText); // Convert to double
                  String priceBuyText =
                      priceBuyController.text.replaceAll(',', "");
                  double priceBuy =
                      double.parse(priceBuyText); // Convert to double
            
                  // double price = double.parse(pricePayController.text);
                  Timestamp now = Timestamp.now();
                  final String pid = newPostRef.id;
            
                  postModel = PostModel(
                    pid: pid,
                    title: titleController.text,
                    detail: detailController.text,
                    location_item: locationController.text,
                    // locationDetail: locationDetailController.text,
                    // pricePay: price,
                    postdate: Timestamp.now(),
                    postimage: imageUrl,
                    uid: uid,
                    postby: userModel!.username,
                    latitude: currentLatitude,
                    longitude: currentLongtitude,
                    isTake: false,
                    takeby: 'none',
                    profileImage: userModel!.urlprofileimage,
                    isFindJob: isSelectedReceive,
                    pricePay: pricePay,
                    priceBuy: priceBuy,
                    totalPrice: priceBuy + pricePay,
                    isGave: false,
                    isReceived: false,
                  );
            
                  // BlocProvider.of<CreatePostBloc>(context).add(
                  //   SubmitPost(postModel),
                  // );
                  if (isClick == false) {
                    context.read<CreatePostBloc>().add(SubmitPost(postModel));
                    isClick = true;
                  }
            
                  // Implement create post functionality
                },
                child: Text('สร้างดีล'),
              ),
            ),
            SizedBox(
              height: 230.h,
            ),
          ],
        ),
      );
    });
  }
  // );
}

PlatformFile? pickedFile;
Future selectFile(BuildContext context) async {
  final result = await FilePicker.platform.pickFiles();
  if (result == null) return;
  pickedFile = result.files.first;
  BlocProvider.of<CreatePostBloc>(context).add(addImage(imageFile: pickedFile));
  // BlocProvider.of<EditProfileBloc>(context)
  //     .add(showImageSelect(imageFile: pickedFile));
}

bool isSelectedReceive = true;
buildSelectBox(BuildContext context) {
  return BlocBuilder<CreatePostBloc, createPostState>(
      builder: (context, state) {
    if (state is selectBoxSuccess) {
      print(state.isFindJob);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            BlocProvider.of<CreatePostBloc>(context)
                .add(selectBox(isFindJob: true));
            isSelectedReceive = true;
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
                color: isSelectedReceive ? Colors.white : Colors.transparent,
                // border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: isSelectedReceive
                  ? Color.fromRGBO(83, 82, 125, 0.8)
                        // ? Color.fromRGBO(224, 195, 252, 0.918)
                        : Colors.white,
                    strokeAlign: BorderSide.strokeAlignInside,
                    width: 2.0),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 5,
                      color: isSelectedReceive
                          ? Color.fromRGBO(224, 195, 252, 100)
                          : Colors.transparent)
                ]),
            child: Text(
              'รับจ้าง',
              style: TextStyle(
                color: isSelectedReceive
                    ? Colors.black
                    : Colors.black.withOpacity(0.5),
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            BlocProvider.of<CreatePostBloc>(context)
                .add(selectBox(isFindJob: false));
            isSelectedReceive = false;
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
                color: isSelectedReceive ? Colors.transparent : Colors.white,
                // border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: isSelectedReceive
                        ? Colors.white
                  : Color.fromRGBO(83, 82, 125, 0.8),
                        // : Color.fromRGBO(224, 195, 252, 0.918),
                    strokeAlign: BorderSide.strokeAlignInside,
                    width: 2.0),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 5,
                      color: isSelectedReceive
                          ? Colors.transparent
                          : Color.fromRGBO(224, 195, 252, 100))
                ]),
            child: Text(
              'จ้างงาน',
              style: TextStyle(
                  color: isSelectedReceive
                      ? Colors.black.withOpacity(0.5)
                      : Colors.black),
            ),
          ),
        ),
      ],
    );
  });
}

AppBar buildAppBarEditProfile(BuildContext context) {
  return AppBar(
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        // color: Colors.white,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            // Color.fromRGBO(207, 162, 250,100),
            // Color.fromRGBO(194, 233, 251, 100),

            Color.fromRGBO(224, 195, 252, 100),
            Color.fromRGBO(142, 197, 252, 100),
          ],
        ),
        // border: Border.all(
        //   width: 0.2,
        //   color: Colors.black,
        // ),
        // borderRadius: BorderRadius.circular(25),
      ),
    ),
    // backgroundColor: Colors.transparent,
    automaticallyImplyLeading: true,
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
// }
