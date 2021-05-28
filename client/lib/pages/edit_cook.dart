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
import 'package:client/pages/home.dart';
import 'detailFoodAfterCreateFood.dart';

class EditCook extends StatefulWidget {
  final String nameFood;
  final String timeCook;
  final String categoryFood;
  final List<dynamic> ingredient;
  final List<dynamic> howcook;
  final String imageFood;
  final String linkYoutube;
  final String foodid;

  EditCook(
      {Key key,
      this.nameFood,
      this.timeCook,
      this.categoryFood,
      this.ingredient,
      this.howcook,
      this.imageFood,
      this.linkYoutube,
      this.foodid})
      : super(key: key);

  @override
  _EditCookState createState() => _EditCookState(nameFood, timeCook,
      categoryFood, ingredient, howcook, imageFood, linkYoutube, foodid);
}

class _EditCookState extends State<EditCook> {
  _EditCookState(
      this.nameFood,
      this.timeCook,
      this.categoryCook,
      this.ingredient,
      this.howtoCook,
      this.imageUrl,
      this.linkYoutube,
      this.foodid);
  final _formKey = GlobalKey<FormState>();

  UploadTask task;
  String foodid;
  String nameFood;
  String imageUrl;
  File imageFile;
  String timeCook;
  String categoryCook;
  List<dynamic> ingredient = [];
  List<dynamic> howtoCook = [];
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

  submitCook(context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    var urlImage;
    if (imageFile != null) {
      urlImage = await uploadImageToFirebase();
    } else {
      urlImage = imageUrl;
    }
    print(foodid);
    final url_service =
        Uri.parse("https://ezcooks.herokuapp.com/food/editFood/" + foodid);

    Map<String, String> header = {'Content-Type': 'application/json'};

    Map<String, dynamic> data = {
      "nameFood": nameFood,
      "timeCook": timeCook,
      "categoryFood": categoryCook,
      "ingredient": ingredient,
      "howCook": howtoCook,
      "linkYoutube": linkYoutube,
      "imageFood": urlImage
    };

    var json = JsonEncoder().convert(data);

    print(json);

    try {
      var res = await http.post(
        url_service,
        headers: header,
        body: json,
      );
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
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.network(
              imageUrl,
              height: 260,
              fit: BoxFit.cover,
            ),
          ),
          TextButton(
              onPressed: () => getLocalImage(),
              child: Text(
                "เลือกรูปภาพ",
                style: TextStyle(
                    color: Colors.black87,
                    backgroundColor: Colors.white,
                    fontSize: 16),
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
            initialValue: nameFood,
            onChanged: (String value) {
              // setState(() {
              nameFood = value;
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
            value: timeCook,
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
            value: categoryCook,
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Color(0xFFF04D56),
        title: Text("แก้ไขเมนูอาหาร"),
      ),
      body: Container(
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
                  onPressed: () => _addIngredient(),
                  child: Text("เพิ่มส่วนผสม")),
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
                  style:
                      TextButton.styleFrom(backgroundColor: Color(0xFFF04D56)),
                  child: Text(
                    "บันทึก",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () async => {
                    await submitCook(context),
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
      ),
    );
  }
}
