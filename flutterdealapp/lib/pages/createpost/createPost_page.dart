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
  final TextEditingController locationController = TextEditingController();
  final TextEditingController locationDetailController =
      TextEditingController();
  // final TextEditingController dateTimeController = TextEditingController();
  final FocusNode pricePayFocusNode = FocusNode();
  PostModel postModel = PostModel();

  @override
  void initState() {
    super.initState();
    getLocation();
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
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            appBar: buildAppBarEditProfile(context), body: _showForm(context)),
      ),
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
            builder: (context) => ApplicationPage(initialIndex: 2,),
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
      return SingleChildScrollView(
        child: Padding(
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

              ElevatedButton(
                onPressed: () async {
                  if (pickedFile == null ||
                          titleController.text.isEmpty ||
                          detailController.text.isEmpty ||
                          locationController.text.isEmpty ||
                          pricePayController.text.isEmpty ||
                          locationController.text.isEmpty
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

                  String priceText =
                      pricePayController.text.replaceAll(',', "");
                  double price = double.parse(priceText); // Convert to double

                  // double price = double.parse(pricePayController.text);
                  Timestamp now = Timestamp.now();
                  final String pid = newPostRef.id;

                  postModel = PostModel(
                      pid: pid,
                      title: titleController.text,
                      detail: detailController.text,
                      location_item: locationController.text,
                      // locationDetail: locationDetailController.text,
                      pricePay: price,
                      postdate: Timestamp.now(),
                      postimage: imageUrl,
                      uid: uid,
                      postby: userModel!.username,
                      latitude: currentLatitude,
                      longitude: currentLongtitude,
                      isTake: false,
                      takeby: 'none',
                      profileImage: userModel!.urlprofileimage,
                      isFindJob: isSelectedReceive);

                  BlocProvider.of<CreatePostBloc>(context).add(
                    SubmitPost(postModel),
                  );

                  // Implement create post functionality
                },
                child: Text('สร้างดีล'),
              ),
            ],
          ),
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
              color: isSelectedReceive ? AppColors.primaryButton : Colors.white,
              // border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'รับงาน',
              style: TextStyle(
                color: isSelectedReceive ? Colors.white : Colors.grey,
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
              color: isSelectedReceive ? Colors.white : AppColors.primaryButton,
              // border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'หางาน',
              style: TextStyle(
                color: isSelectedReceive ? Colors.grey : Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  });
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
// }
