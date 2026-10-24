import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData {
  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    try {
      Reference ref = _storage.ref().child(childName);
      UploadTask uploadTask = ref.putData(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      print("Download URL: $downloadUrl");
      if (downloadUrl != null && downloadUrl.isNotEmpty) {
        return downloadUrl;
      } else {
        throw Exception("Empty or null download URL");
      }
    } catch (e) {
      print("Error uploading image to storage: $e");
      throw Exception("Image upload failed: $e");

    }
  }

  Future<String> saveData({
    required Uint8List file,
    required String docId,
  }) async {
    try {
      String imageUrl = await uploadImageToStorage('profileImage', file);

      if (imageUrl.isNotEmpty) {
        DocumentReference documentReference = FirebaseFirestore.instance
            .collection("newUserCredentials").doc(docId);

        try {
          await documentReference.update({
            "imageURL": imageUrl,
          });

          print("Document field 'imageURL' updated successfully!");
          return imageUrl; // Return the actual URL
        } catch (e) {
          print("Error updating document field: $e");
          throw Exception("Error updating document field: $e");
        }
      } else {
        print("Error: Empty imageUrl returned from uploadImageToStorage");
        throw Exception("Empty imageUrl");
      }
    } catch (error) {
      print("Error saving data: $error");
      throw Exception("Error saving data");
    }
  }
}