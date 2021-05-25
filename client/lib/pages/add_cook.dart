import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddCook extends StatefulWidget {
  AddCook({@required this.isUpdating});

  final bool isUpdating;
  @override
  _AddCookState createState() => _AddCookState();
}

class _AddCookState extends State<AddCook> {
  final _formKey = GlobalKey<FormState>();

  String nameCook;
  String imageUrl;
  File imageFile;
  String timeCook;
  String categoryCook;
  List<String> ingredient = [];
  List<String> howtoCook = [];

  final List<String> _timeCookOption = ["10", "20", "30", "45", "60"];
  final List<String> _categoryCookOption = [
    'ทอด',
    'ต้ม',
    'นึ่ง',
    'ย่าง',
    'ผัด',
    'ยำ'
  ];

  @override
  void initState() {
    super.initState();
    ingredient = ["", "", ""];
    howtoCook = ["", "", ""];
    imageUrl =
        "https://thaigifts.or.th/wp-content/uploads/2017/03/no-image.jpg";
  }

  final TextStyle inputStyle = TextStyle(
    fontSize: 18,
    color: Colors.blue[900],
  );
  final TextStyle lableStyle = TextStyle(
    fontSize: 16,
    color: Colors.grey[900],
  );

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

  submitCook() {
    if (!_formKey.currentState.validate()) {
      return;
    } else if (imageFile == null) {
      return;
    }
    print(imageFile);
    print("name $nameCook");
    print("name $timeCook");
    print("name $categoryCook");
    print("name $ingredient");
    print("name $howtoCook");
  }

  // ignore: missing_return
  Widget _showImage() {
    if (imageFile == null && imageUrl == null) {
      return Text("image placeholder");
    } else if (imageFile != null) {
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Center(
            child: Image.file(imageFile,
                height: 250,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover),
          ),
          TextButton(
              onPressed: () => getLocalImage(), child: Text("เปลี่ยนรูปภาพ")),
        ],
      );
    } else if (imageUrl != null) {
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Center(
            child: Image.network(imageUrl,
                height: 250,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover),
          ),
          TextButton(
              onPressed: () => getLocalImage(), child: Text("เลือกรูปภาพ")),
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
            style: TextStyle(fontSize: 20),
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
          flex: 1,
          child: DropdownButtonFormField(
            focusColor: Colors.white,
            style: inputStyle,
            isExpanded: true,
            hint: Text(
              "ใช้เวลากี่นาที?",
              style: TextStyle(
                  color: Colors.black38,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            items: _timeCookOption.map((String value) {
              return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    '$value นาที',
                    style: lableStyle,
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
          flex: 1,
          child: DropdownButtonFormField(
            style: inputStyle,
            isExpanded: true,
            hint: Text(
              "ผัด ทอด ต้ม นึ่ง ...",
              style: TextStyle(
                  color: Colors.black38,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            items: _categoryCookOption.map((String value) {
              return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: lableStyle,
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
      children: [
        Text('${index + 1}'),
        SizedBox(width: 30),
        Expanded(
          child: TextFormField(
            controller: TextEditingController(text: ingredientItem),
            keyboardType: TextInputType.text,
            style: TextStyle(fontSize: 20),
            validator: (String value) {
              if (value.isEmpty) {
                return 'โปรดกรอกส่วนผสม';
              }
              return null;
            },
            onChanged: (String value) {
              ingredient[index] = value;
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
    return Flexible(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: ingredient.length,
            itemBuilder: (context, index) {
              var data = ingredient[index];
              print(data);
              return _ingredientCook(data, index);
            }));
  }

  _addIngredient() {
    setState(() {
      ingredient.add("");
    });
  }

  _onDeleteIngredient(index) {
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
            style: TextStyle(fontSize: 20),
            validator: (String value) {
              if (value.isEmpty) {
                return 'โปรดกรอกวิธีทำ';
              }
              return null;
            },
            onChanged: (String value) {
              howtoCook[index] = value;
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
      ingredient.add("");
    });
  }

  _onDeletehowtoCook(index) {
    setState(() {
      howtoCook.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: _formKey,
        child: Column(
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
            Text(
              "ส่วนผสม",
              style: lableStyle,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _dynamicIngredient(),
            ),
            TextButton(
                onPressed: () => _addIngredient(), child: Text("เพิ่มส่วนผสม")),
            Text(
              "วิธีการทำ",
              style: lableStyle,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _dynamicHowtoCook(),
            ),
            TextButton(
                onPressed: () => _addHowToCook(),
                child: Text("เพิ่มวิธีการทำ")),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                child: Text("สร้างเมนูอาหาร"),
                onPressed: () => submitCook(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
