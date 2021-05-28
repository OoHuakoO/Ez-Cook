import 'package:client/model/foods.dart';
import 'package:flutter/material.dart';
import '../function/getFood.dart';

class SearchPage extends SearchDelegate<String> {
  List<dynamic> foods = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {}

  @override
  Widget buildSuggestions(BuildContext context) {
    // foods = [];
    print(query);
    // fetchFoods().then((value) => {
    //       if (query != "" || query != null)
    //         {
    //           value.forEach((element) {
    //             if (element.nameFood.startsWith(query)) {
    //               foods.add(element);
    //             }
    //           })
    //         }
    //       else
    //         {
    //           value.forEach((element) {
    //             foods.add(element);
    //           })
    //         }
    //     });

    return FutureBuilder(
      future: fetchFoods(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            // ignore: missing_return
            itemBuilder: (context, index) {
              // Text("${index + 1} ${snapshot.data[index].nameFood}");
              print(snapshot.data[index].nameFood.startsWith(query));

              if (query != "") {
                if (snapshot.data[index].nameFood.startsWith(query)) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                          leading:
                              Image.network(snapshot.data[index].imageFood),
                          title: Text("${snapshot.data[index].nameFood}"),
                          subtitle: Text(
                              "เวลาในการทำ ${snapshot.data[index].timeCook} นาที")),
                    ),
                  );
                }
              } else {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                        leading: Image.network(snapshot.data[index].imageFood),
                        title: Text("${snapshot.data[index].nameFood}"),
                        subtitle: Text(
                            "เวลาในการทำ ${snapshot.data[index].timeCook} นาที")),
                  ),
                );
              }
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    // return ListView.builder(
    //   itemCount: foods.length,
    //   itemBuilder: (context, index) {
    //     return Card(
    //       child: Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: ListTile(
    //             leading: Image.network(foods[index].imageFood),
    //             title: Text("${foods[index].nameFood}"),
    //             subtitle: Text("เวลาในการทำ ${foods[index].timeCook} นาที")),
    //       ),
    //     );
    //   },
    // );
  }
}
