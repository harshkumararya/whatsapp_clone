import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';

class StorageProviderRemoteDataSource {
  // Cloudinary Setup
  static final _cloudinary = CloudinaryPublic(
    'dd5rywgad',
    'whatsapp_preset',
    cache: false,
  );

  // Profile Image Upload
  static Future<String> uploadProfileImage({
    required File file,
    Function(bool isUploading)? onComplete,
  }) async {
    onComplete!(true);

    try {
      final response = await _cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          file.path,
          folder: "profile",
          resourceType: CloudinaryResourceType.Image,
        ),
      );

      onComplete(false);
      return response.secureUrl; // Firebase downloadURL ki jagah ye return hoga
    } catch (e) {
      onComplete(false);
      return "";
    }
  }

  //  Single Status Upload
  static Future<String> uploadStatus({
    required File file,
    Function(bool isUploading)? onComplete,
  }) async {
    onComplete!(true);

    try {
      final response = await _cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          file.path,
          folder: "status",
          resourceType: CloudinaryResourceType.Image,
        ),
      );
      onComplete(false);
      return response.secureUrl;
    } catch (e) {
      onComplete(false);
      return "";
    }
  }

  //  Multiple Statuses Upload
  static Future<List<String>> uploadStatuses({
    required List<File> files,
    Function(bool isUploading)? onComplete,
  }) async {
    onComplete!(true);

    List<String> imageUrls = [];
    try {
      for (var file in files) {
        final response = await _cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            file.path,
            folder: "status",
            resourceType: CloudinaryResourceType.Image,
          ),
        );
        imageUrls.add(response.secureUrl);
      }
    } catch (e) {
      print("Multi-upload error: $e");
    }

    onComplete(false);
    return imageUrls;
  }

  // Message File Upload (Images/Videos in Chat)
  static Future<String> uploadMessageFile({
    required File file,
    Function(bool isUploading)? onComplete,
    String? uid,
    String? otherUid,
    String? type,
  }) async {
    onComplete!(true);

    try {
      // Folder structure Firebase jaisa hi rakha hai
      final response = await _cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          file.path,
          folder: "message/$type/$uid/$otherUid",
          resourceType: CloudinaryResourceType.Auto, // Taaki image aur video dono handle ho jayein
        ),
      );

      onComplete(false);
      return response.secureUrl;
    } catch (e) {
      onComplete(false);
      return "";
    }
  }
}
