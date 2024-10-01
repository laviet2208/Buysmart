import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:buysmartm/data/finaldata.dart';
import 'package:buysmartm/screen/entered_screen/main_page/main_page_controller.dart';

class avatar_edit extends StatefulWidget {
  const avatar_edit({super.key});

  @override
  State<avatar_edit> createState() => _avatar_editState();
}

class _avatar_editState extends State<avatar_edit> {
  bool loading = false;
  final picker = ImagePicker();
  Uint8List? registrationImage;

  Future<Uint8List?> galleryImagePicker() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return null;
    }
    List<int> imageBytes = await pickedFile.readAsBytes();
    Uint8List? bytesFromPicker = Uint8List.fromList(imageBytes);
    return bytesFromPicker;
  }

  Future<void> uploadImageToFirebaseStorage(Uint8List imageBytes, String path) async {
    try {
      Reference storageReference = FirebaseStorage.instance.ref().child(path);
      SettableMetadata metadata = SettableMetadata(contentType: 'image/png');
      UploadTask uploadTask = storageReference.putData(imageBytes, metadata);
      await uploadTask.whenComplete(() => print('Upload completed'));
      finaldata.avatarUrl = await main_page_controller.getImageURL(path);
      setState(() {});
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: width/3,
      width: width,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            bottom: 0,
            left: (width - width/3)/2,
            right: (width - width/3)/2,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(1000),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: finaldata.avatarUrl == '' ? Image.asset('assets/image/product_type_example/ava_example.png', fit: BoxFit.cover,) :
                  Image.network(finaldata.avatarUrl, fit: BoxFit.cover,),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            right: (width - width/3)/2,
            child: GestureDetector(
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(1000),
                ),
                child: Center(
                  child: !loading ? Icon(
                    Icons.edit,
                    size: 25,
                  ) : CircularProgressIndicator(color: Colors.blueGrey,),
                ),
              ),
              onTap: () async {
                final Uint8List? image = await galleryImagePicker();
                if (image != null) {
                  setState(() {
                    loading = true;
                  });
                  registrationImage = image;
                  await uploadImageToFirebaseStorage(registrationImage!, 'Avartar/' + finaldata.account.id + '.png');
                  setState(() {
                    loading = false;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

