import 'dart:io';
import 'package:path/path.dart' as p;
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

  Future<String?> uploadImageToStorege (File imageFile) async {
    try{
      // Dosya uzantısını elde edin
      String? extension = p.extension(imageFile.path);
      String? path = '${DateTime.now().millisecondsSinceEpoch}$extension';  // Dosya adını ve uzantısını birleştirin

      // Dosya türünü belirtmek için metadataları ayarlayın
      String mimeType = extension == '.png' ? 'image/png' : 'image/jpeg';  // Uzantıya göre MIME tipini belirleyin
      SettableMetadata metadata = SettableMetadata(
        contentType: mimeType,  // MIME tipini ayarlayın
      );

      TaskSnapshot uploadTask = await storage.ref().child("patientPhotos").child(path).putFile(imageFile,metadata);
      String? uploadedImageUrl = await uploadTask.ref.getDownloadURL();
      print("UploadedImageUrl: $uploadedImageUrl");
      return uploadedImageUrl;
    }catch(e){
      print("Firebase Storage error: $e");
      return null;
    }
  }
}
