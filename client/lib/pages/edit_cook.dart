import 'dart:convert';
import 'dart:io';
import 'package:client/model/food.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../firebase/firebase_api.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

import 'detailFoodAfterCreateFood.dart';

class AddCook extends StatefulWidget {
  // final Map<String, dynamic> editData;
  // Addcook({Key key, this.editData}) : super(key: key);

  @override
  _AddCookState createState() => _AddCookState();
}

class _AddCookState extends State<AddCook> {
  final _formKey = GlobalKey<FormState>();

  UploadTask task;
  String nameCook;
  String imageUrl;
  File imageFile;
  String timeCook;
  String categoryCook;
  List<String> ingredient = [];
  List<String> howtoCook = [];
  String linkYoutube;
  List<Map<String, dynamic>> food = [];
  List<Map<String, dynamic>> user = [];
  final List<String> _timeCookOption = ["5", "10", "20", "30", "45", "60"];
  final List<String> _categoryCookOption = [
    'ทอด',
    'ต้ม',
    'แกง',
    'นึ่ง',
    'ย่าง',
    'ผัด',
    'ยำ',
  ];

  @override
  void initState() {
    super.initState();
    ingredient = ["", "", ""];
    howtoCook = ["", "", ""];
    imageUrl =
        "http://flxtable.com/wp-content/plugins/pl-platform/engine/ui/images/image-preview.png";
  }

  final TextStyle inputStyle = TextStyle(
    fontSize: 15,
    color: Colors.black87,
  );
  final TextStyle lableStyle = TextStyle(
    fontSize: 18,
    color: Colors.black87,
  );

  getDataToEdit() async {}

  getLocalImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  uploadImageToFirebase() async {
    final fileName = basename(imageFile.path);
    final destination = 'images/$fileName';

    task = FirebaseApi.uploadFile(destination, imageFile);
    setState(() {});

    if (task == null) return;

    final snapshot = await task.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    return urlDownload;
  }

  submitCook() async {
    if (!_formKey.currentState.validate()) {
      return;
    } else if (imageFile == null) {
      return;
    }
    var urlImage = await uploadImageToFirebase();
  var uid = FirebaseAuth.instance.currentUser.uid;
     final url_service =
        Uri.parse("https://ezcooks.herokuapp.com/food/editFood/" + uid);


    Map<String, String> header = {'Content-Type': 'application/json'};

    Map<String, dynamic> data = {
      "nameFood": nameCook,
      "timeCook": timeCook,
      "categoryFood": categoryCook,
      "ingredient": ingredient,
      "howCook": howtoCook,
      "linkYoutube": linkYoutube,
      "imageFood": urlImage
    };

    var json = JsonEncoder().convert(data);

    try {
      var res = await http.post(
        url_service,
        headers: header,
        body: json,
      );
      print(res.statusCode);
      if (res.statusCode == 200) {
         var foodApi = (jsonDecode(res.body)['data'][0]['food']);
        var userApi = (jsonDecode(res.body)['data'][0]['user']);
        Food foodData = Food.fromJson(foodApi);
        Food userData = Food.fromJson(userApi);
        setState(() {
          food.add({
            "nameFood": foodData.nameFood,
            "timeCook": foodData.timeCook,
            "categoryFood": foodData.categoryFood,
            "ingredient": foodData.ingredient,
            "linkYoutube": foodData.linkYoutube,
            "howCook": foodData.howCook,
            "imageFood": foodData.imageFood,
            "like": foodData.like.toString(),
          });
          user.add({
            "imageProfile": userData.imageProfile,
            "username": userData.username,
          });
        });
        print(user[0]);
        print(food[0]);
      } else {
        print("fail");
      }
    } catch (e) {
      print(e);
    }
  }

  // ignore: missing_return
  Widget _showImage() {
    if (imageFile == null && imageUrl == null) {
      return Text("image placeholder");
    } else if (imageFile != null) {
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.file(
              imageFile,
              height: 260,
              fit: BoxFit.cover,
            ),
          ),
          TextButton(
              onPressed: () => getLocalImage(),
              child: Text(
                "เปลี่ยนรูปภาพ",
                style: TextStyle(
                    color: Colors.black87,
                    backgroundColor: Colors.white,
                    fontSize: 16),
              )),
        ],
      );
    } else if (imageUrl != null) {
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Center(
            child: Image.network(imageUrl, height: 260, fit: BoxFit.cover),
          ),
          TextButton(
              onPressed: () => getLocalImage(),
              child: Text(
                "เลือกรูปภาพ",
                style: lableStyle,
              )),
        ],
      );
    }
  }

  Widget _nameCook() {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Text(
              "ชื่อเมนูอาหาร",
              style: lableStyle,
            )),
        Expanded(
          flex: 2,
          child: TextFormField(
            keyboardType: TextInputType.text,
            style: inputStyle,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFFAFAFA),
              hintText: 'ชื่อเมนู',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Color(0xFFCECECE)),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Color(0xFFF04D56)),
                  borderRadius: BorderRadius.circular(10)),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return 'โปรดกรอกชื่อเมนูอาหาร';
              }
              return null;
            },
            onChanged: (String value) {
              // setState(() {
              nameCook = value;
              // });
            },
          ),
        ),
      ],
    );
  }

  Widget _timeCook() {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Text(
              "เวลาในการทำ",
              style: lableStyle,
            )),
        Expanded(
          flex: 2,
          child: DropdownButtonFormField(
            focusColor: Colors.white,
            style: inputStyle,
            isExpanded: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFFAFAFA),
              hintText: 'ใช้เวลากี่นาที ?',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Color(0xFFCECECE)),
                  borderRadius: BorderRadius.circular(10)),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            ),
            // hint: Text(
            //   "ใช้เวลากี่นาที?",
            //   style: TextStyle(
            //       color: Colors.black38,
            //       fontSize: 14,
            //       fontWeight: FontWeight.w500),
            // ),
            items: _timeCookOption.map((String value) {
              return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    '$value นาที',
                    style: inputStyle,
                  ));
            }).toList(),
            validator: (String value) {
              if (value == null) {
                return 'โปรดเลือกเวลาในการทำ';
              }
              return null;
            },
            onChanged: (String value) {
              // setState(() {
              timeCook = value;
              // });
            },
          ),
        ),
      ],
    );
  }

  Widget _categoryCook() {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Text(
              "ประเภทอาหาร",
              style: lableStyle,
            )),
        Expanded(
          flex: 2,
          child: DropdownButtonFormField(
            style: inputStyle,
            isExpanded: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFFAFAFA),
              hintText: 'ผัด ทอด ต้ม นึ่ง แกง ย่าง ยำ',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Color(0xFFCECECE)),
                  borderRadius: BorderRadius.circular(10)),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            ),
            items: _categoryCookOption.map((String value) {
              return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: inputStyle,
                  ));
            }).toList(),
            validator: (String value) {
              if (value == null) {
                return 'โปรดเลือกประเภทอาหาร';
              }
              return null;
            },
            onChanged: (String value) {
              categoryCook = value;
            },
          ),
        ),
      ],
    );
  }

  Widget _ingredientCook(ingredientItem, index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('${index + 1}'),
        SizedBox(width: 30),
        Expanded(
          flex: 1,
          child: TextFormField(
            controller: TextEditingController(text: ingredientItem),
            keyboardType: TextInputType.text,
            style: inputStyle,
            validator: (String value) {
              if (value.isEmpty) {
                return 'โปรดกรอกส่วนผสม';
              }
              return null;
            },
            onChanged: (String value) {
              ingredient[index] = value.toString();
            },
          ),
        ),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            _onDeleteIngredient(index);
          },
        )
      ],
    );
  }

  Widget _dynamicIngredient() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: ingredient.length,
        itemBuilder: (context, index) {
          return _ingredientCook(ingredient[index], index);
        });
  }

  _addIngredient() {
    setState(() {
      ingredient.add("");
    });
  }

  _onDeleteIngredient(index) {
    if (ingredient.length <= 3) {
      return;
    }
    setState(() {
      ingredient.removeAt(index);
    });
  }

  Widget _howtoCook(howtoCookItem, index) {
    return Row(
      children: [
        Text('${index + 1}'),
        SizedBox(width: 30),
        Expanded(
          child: TextFormField(
            controller: TextEditingController(text: howtoCookItem),
            keyboardType: TextInputType.text,
            style: inputStyle,
            validator: (String value) {
              if (value.isEmpty) {
                return 'โปรดกรอกวิธีทำ';
              }
              return null;
            },
            onChanged: (String value) {
              howtoCook[index] = value.toString();
            },
          ),
        ),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            _onDeletehowtoCook(index);
          },
        )
      ],
    );
  }

  Widget _dynamicHowtoCook() {
    return Stack(children: [
      ListView.builder(
          shrinkWrap: true,
          itemCount: howtoCook.length,
          itemBuilder: (context, index) {
            var data = howtoCook[index];
            print(data);
            return _howtoCook(data, index);
          }),
    ]);
  }

  _addHowToCook() {
    setState(() {
      howtoCook.add("");
    });
  }

  _onDeletehowtoCook(index) {
    if (howtoCook.length <= 3) {
      return;
    }
    setState(() {
      howtoCook.removeAt(index);
    });
  }

  Widget _linkYoutube() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "link youtube (ถ้ามี)",
          style: lableStyle,
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          keyboardType: TextInputType.text,
          style: inputStyle,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFFAFAFA),
            hintText: 'url',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Color(0xFFCECECE)),
                borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Color(0xFFF04D56)),
                borderRadius: BorderRadius.circular(10)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          ),
          onChanged: (String value) {
            linkYoutube = value;
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _showImage(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _nameCook(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _timeCook(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _categoryCook(),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "ส่วนผสม",
                style: lableStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _dynamicIngredient(),
            ),
            TextButton(
                onPressed: () => _addIngredient(), child: Text("เพิ่มส่วนผสม")),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "วิธีการทำ",
                style: lableStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _dynamicHowtoCook(),
            ),
            TextButton(
                onPressed: () => _addHowToCook(),
                child: Text("เพิ่มวิธีการทำ")),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _linkYoutube(),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Color(0xFFF04D56)),
                child: Text(
                  "สร้างเมนูอาหาร",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: () async => {
                    await submitCook(),
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailFoodAfterCreateFood(
                              myFoodSee: food[0],
                              username: user[0]['username'],
                              imageProfile: user[0]['imageProfile'],
                              ingredient: food[0]['ingredient'],
                              howcook: food[0]['howCook'],
                              imageFood: food[0]['imageFood'],
                              nameFood: food[0]['nameFood'])),
                    )
                  },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
