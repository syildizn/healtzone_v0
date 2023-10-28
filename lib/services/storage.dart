import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<String?> storegeExample() async {
    try {
      String? photoUrl;
      Reference refPatPhts = storage.ref().child("patientPhotos");
      photoUrl = await refPatPhts.child("a1.jpg").getDownloadURL();
      print("urlPhoto = $photoUrl");
      return photoUrl;
    } catch (e) {
      print("Firebase Storage error: $e");
      return null;
    }
  }

  Future<void> uploadImageToStorege (File imageFile) async {
    try{
      String? path = "ozelDosya";
      TaskSnapshot uploadTask = await storage.ref().child("patientPhotos").child(path).putFile(imageFile);
      String? uploadedImageUrl = await uploadTask.ref.getDownloadURL();
      print("UploadedImageUrl: $uploadedImageUrl");
    }catch(e){
      print("Firebase Storage error: $e");
    }
  }
}
