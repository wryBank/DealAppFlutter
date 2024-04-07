import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/src/platform_file.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_event.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_repo.dart';
import 'package:flutterdealapp/pages/editProfile/bloc/editprofile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent,EditProfileState>{
  final editProfile_repo repository;
  EditProfileBloc(this.repository) : super(EditProfileState()){
    on<Create>(((event, emit)async {
        print("inbloc");
      try {
        print("inbloc");
        print("eventusermodel = ${event.userModel}");
        await  repository.editProfile(event.userModel);
        // emit(EditingData());
      } catch (e) {
        
      }
    }));
    on<uploadingImageEvent>((event, emit)async {
      try {
        print("in bloc uploadimage");
        print("wwwwaaaa${repository.uploadingImage(event.imageFile)}");
        // await repository.uploadingImage(event.imageFile);
        print(" wwwwww ${event.imageFile!.path}");
        String? url = await repository.provider.uploadImage(event.imageFile);
        print("url = ${url}");
        emit(uploadingImageState(url));

      } catch (e) {
      }
    });
    on<showImageSelect>((event, emit)async {
      try {
        print("in bloc uploadimage");
        // print("wwwwaaaa${repository.uploadingImage(event.imageFile)}");
        // await repository.uploadingImage(event.imageFile);
        // print(" wwwwww ${event.imageFile!.path}");
        emit(showImageSelectState(event.imageFile));

      } catch (e) {
        
      }
    });
    on<UploadUrlImageEvent>((event, emit)async {
      try {
        print("in bloc uploadimage");
        print("wwwwaaaa${repository.upLoadUrlImage(event.url)}");
        await repository.upLoadUrlImage(event.url);
        print(" wwwwww ${event.url}");

      } catch (e) {
        
      }
    });
    // on<EditImageEvent>((event, emit)async {
    //   try {
    //     print("in bloc uploadimage");
    //     print("wwwwaaaa${repository.EditImage(event.imageFile as PlatformFile?)}");
    //     await repository.EditImage(event.imageFile as PlatformFile?);
    //     print(" wwwwww ${event.imageFile!}");
    //     emit(EditImageState(event.imageFile!));

    //   } catch (e) {
        
    //   }
    // });
}
}