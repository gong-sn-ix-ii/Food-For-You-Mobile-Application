// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, file_names, unused_local_variable, nullable_type_in_catch_clause, unnecessary_brace_in_string_interps, avoid_print, empty_catches, avoid_function_literals_in_foreach_calls
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(
      {required String filePath, required String fileName}) async {
    File file = File(filePath);
    print("##uploadFile path ${filePath}");
    try {
      await storage.ref("test/${fileName}").putFile(file);
      print("####--> Complete");
    } catch (error) {
      print("###---> Error ${error}");
    }
  }

  Future<firebase_storage.ListResult> getFile({required String folder}) async {
    firebase_storage.ListResult results = await storage.ref(folder).listAll();
    results.items.forEach((firebase_storage.Reference ref) {
      print("Found File : ${ref}");
    });
    return results;
  }

  Future<String> downloadURL(
      {required String folder, required String imageName}) async {
    String downloadURL = "";
    try {
      downloadURL = await storage.ref("test/${imageName}").getDownloadURL();
      print("find File Complete ${downloadURL}");
    } catch (e) {
      print("can't find File");
    }
    return downloadURL;
  }

  Future<void> deleteFile(
      {required String folder, required String imageName}) async {
    try {
      await storage.ref("${folder}/${imageName}").delete();
      print("Delete-File : ${imageName} ");
    } catch (e) {
      print("Delete-File : ${imageName} Failed Error ${e}");
    }
  }
}
