import 'dart:convert';

import 'package:flutter/material.dart';

class AddCook extends StatefulWidget {
  @override
  _AddCookState createState() => _AddCookState();
}

class _AddCookState extends State<AddCook> {
  List<Map<String, dynamic>> _ingredientArray;
  List<Map<String, dynamic>> _howtoCookArray;
  int _timeCook;
  String _categoryCook;
  int _count;
  String _result;

  final List<int> _timeCookOption = [10, 20, 30, 45, 60];
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
    _count = 3;
    _result = '';
    _ingredientArray = [
      {"id": 0, "text": ""},
      {"id": 1, "text": ""},
      {"id": 2, "text": ""}
    ];
    _howtoCookArray = [
      {"id": 0, "text": ""},
      {"id": 1, "text": ""},
      {"id": 2, "text": ""}
    ];
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle inputStyle = TextStyle(
      fontSize: 18,
      color: Colors.blue[900],
    );
    final TextStyle lableStyle = TextStyle(
      fontSize: 18,
      color: Colors.grey[900],
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(flex: 1, child: Text("ชื่อเมนู")),
              Expanded(
                flex: 2,
                child: TextFormField(
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(flex: 1, child: Text("เวลาในการทำ")),
              Expanded(
                flex: 2,
                child: DropdownButton(
                  style: inputStyle,
                  isExpanded: true,
                  items: _timeCookOption.map((int value) {
                    return DropdownMenuItem<int>(
                        value: value,
                        child: Text(
                          '$value นาที',
                          style: lableStyle,
                        ));
                  }).toList(),
                  value: _timeCook,
                  onChanged: (value) {
                    setState(() {
                      _timeCook = value;
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(flex: 1, child: Text("ประเภทอาหาร")),
              Expanded(
                flex: 2,
                child: DropdownButton(
                  style: inputStyle,
                  isExpanded: true,
                  items: _categoryCookOption.map((String value) {
                    return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: lableStyle,
                        ));
                  }).toList(),
                  value: _categoryCook,
                  onChanged: (value) {
                    setState(() {
                      _categoryCook = value;
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "ส่วนผสม",
            style: TextStyle(fontSize: 22),
          ),
          Flexible(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _ingredientArray.length,
                  itemBuilder: (context, index) {
                    return _rowIngredient(index);
                  })),
          SizedBox(
            height: 5,
          ),
          TextButton(
            onPressed: () {
              addIngredient();
            },
            child: Text("เพิ่มส่วนผสม"),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "วิธีการทำ",
            style: TextStyle(fontSize: 22),
          ),
          Flexible(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _howtoCookArray.length,
                  itemBuilder: (context, index) {
                    return _rowHowToCook(index);
                  })),
          SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {
              addHowToCook();
            },
            child: Text("เพิ่มวิธีการทำ"),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  _rowIngredient(int index) {
    return Row(
      children: [
        Text('${index + 1}'),
        SizedBox(width: 30),
        Expanded(child: TextFormField(
          onChanged: (val) {
            _onTextUpdateIngredient(index, val);
          },
        )),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            _onDeleteIngredient(index);
          },
        )
      ],
    );
  }

  addIngredient() {
    var c = _count;
    Map<String, dynamic> json = {'id': c, 'text': ''};
    _ingredientArray.add(json);
    setState(() {
      _count++;
      _result = _prettyPrint(_ingredientArray);
    });
  }

  _onTextUpdateIngredient(int key, String val) {
    int foundKey = -1;
    for (var map in _ingredientArray) {
      if (map.containsKey('id')) {
        if (map['id'] == key) {
          foundKey = key;
          break;
        }
      }
    }
    if (foundKey != -1) {
      _ingredientArray.removeWhere((map) {
        return map['id'] == foundKey;
      });
    }
    Map<String, dynamic> json = {'id': key, 'text': val};
    _ingredientArray.add(json);
    setState(() {
      _result = _prettyPrint(_ingredientArray);
    });
    print(_ingredientArray);
  }

  _onDeleteIngredient(int key) {
    _ingredientArray.removeWhere((map) {
      return map['id'] == key;
    });
    setState(() {
      _result = _prettyPrint(_ingredientArray);
    });
  }

  String _prettyPrint(jsonObject) {
    var encoder = JsonEncoder.withIndent('    ');
    return encoder.convert(jsonObject);
  }

  _rowHowToCook(int index) {
    return Row(
      children: [
        Text('${index + 1}'),
        SizedBox(width: 30),
        Expanded(child: TextFormField(
          onChanged: (val) {
            _onTextUpdateHowtoCook(index, val);
          },
        )),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            _onDeleteHowToCook(index);
          },
        )
      ],
    );
  }

  addHowToCook() {
    var c = _count;
    Map<String, dynamic> json = {'id': c, 'text': ''};
    _howtoCookArray.add(json);
    // setState(() {
    //   _count++;
    //   _result = _prettyPrint(_ingredientArray);
    // });
  }

  _onTextUpdateHowtoCook(int key, String val) {
    int foundKey = -1;
    for (var map in _howtoCookArray) {
      if (map.containsKey('id')) {
        if (map['id'] == key) {
          foundKey = key;
          break;
        }
      }
    }
    if (foundKey != -1) {
      _howtoCookArray.removeWhere((map) {
        return map['id'] == foundKey;
      });
    }
    Map<String, dynamic> json = {'id': key, 'text': val};
    _howtoCookArray.add(json);
    print(_howtoCookArray);
  }

  _onDeleteHowToCook(int key) {
    _howtoCookArray.removeWhere((map) {
      return map['id'] == key;
    });
    setState(() {
      _result = _prettyPrint(_howtoCookArray);
    });
  }
}
