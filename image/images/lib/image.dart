import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import "dart:io";
import "package:http/http.dart" as http;
import "package:http_parser/http_parser.dart";
import "package:path/path.dart";

class Images extends StatefulWidget {
  const Images({super.key});

  @override
  State<Images> createState() => _ImagesState();
}

class _ImagesState extends State<Images> {
  Future<void> uploadProfileImage(File imageFile) async {
    var request = http.MultipartRequest(
        'PUT',
        Uri.parse(
            'https://jackdelivery-full-backend.onrender.com/api/upload/profile-photo'));
    request.headers['authorization'] =
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NDNhNGUzNTM5MGFiZDQ0MDc1ODU3OTUiLCJpYXQiOjE2ODIwODA3NzEsImV4cCI6MTY4MjE2NzE3MX0.CGueoqbZnPwGMGiV65xQ4Vj4OYIiMYWvdVCUlcut5O0';

    var multipartFile = await http.MultipartFile.fromPath(
        'image', imageFile.path,
        filename: basename(imageFile.path),
        contentType: MediaType(
            'image', 'jpg')); // replace 'jpg' with the actual image format

    // request.fields['_id'] =
    //     'yourUserId'; // replace 'yourUserId' with the actual user ID
    request.files.add(multipartFile);

    var response = await request.send();
    if (response.statusCode == 200) {
      print('Profile picture updated');
    } else {
      print('Error updating profile picture');
    }
  }

  File? storedImage;
  void pickImage() async {
    final pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxWidth: 600);
    if (pickedImage != null) {
      setState(() {
        storedImage = File(pickedImage.path);
      });
      print('picked ${pickedImage.path}');
      uploadProfileImage(storedImage!);

    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
          child: Column(
        children: [
          Container(
              width: 150,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
              ),
              alignment: Alignment.center,
              child: storedImage != null
                  ? Image.file(
                      storedImage!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )
                  : Text('No IMAge')),
          ElevatedButton(onPressed: pickImage, child: Text('Pick'))
        ],
      )),
    );
  }
}
