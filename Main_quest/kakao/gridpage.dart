import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; 

void main() {
  runApp(const MyApp());
}

class Photo {
  final int id;
  final String title;
  final String url;
  final String description;

  Photo(this.id, this.title, this.description, this.url);
}

final List<Photo> dummyPhotos = [
  Photo(1, 'Joy', "a yellow emotion who often takes the lead in Riley's emotional life, and is reluctant to accept any influences that could detract from Riley's happiness",
      'https://static.wikia.nocookie.net/pixar/images/7/7c/Inside_Out_Character_Poster_Joy.jpg/revision/latest/scale-to-width-down/1000?cb=20150103032205'),
  Photo(2, 'Sadness', "a blue emotion who helps Riley process upsetting experiences",
      'https://static.wikia.nocookie.net/pixar/images/9/9c/Inside_Out_2_Character_Poster_-_Sadness.jpg/revision/latest/scale-to-width-down/1000?cb=20240313170238'),
  Photo(3, 'Anger',  "a red emotion who also governs aspects of Riley's hockey game when she plays aggressively",
      'https://static.wikia.nocookie.net/pixar/images/5/55/Inside_Out_2_Character_Poster_-_Anger.jpg/revision/latest/scale-to-width-down/1000?cb=20240313170321'),
  Photo(4, 'Anxiety', "a new orange emotion who catastrophizes every situation, with the stated intention of averting bad outcomes for Riley",
      'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FWf8sg%2FbtsICmlzokk%2FgjMHLl8oJjm47h7nOI50fk%2Fimg.jpg'),
  Photo(5, 'Disgust', "a green emotion who deals with visceral aversion as well as gut reactions like responding to body language",
      'https://static.wikia.nocookie.net/pixar/images/b/b6/Inside_Out_2_Character_Poster_-_Disgust.jpg/revision/latest/scale-to-width-down/1000?cb=20240313170449'),
  Photo(6, 'Embarrassment', " new pink emotion who, in response to Riley's embarassment, hides his face inside a hoodie",
      'https://static.wikia.nocookie.net/pixar/images/b/bf/Inside_Out_2_Character_Poster_-_Embarrassment.jpg/revision/latest/scale-to-width-down/1000?cb=20240313170618'),
  Photo(7, 'Ennui',  "a new indigo emotion with a French accent who expresses Riley's boredom and also deflects uncomfortable situations with sarcasm, feigned disinterest, or taciturn responses",
      'https://static.wikia.nocookie.net/pixar/images/b/bd/Inside_Out_2_Character_Poster_-_Ennui.jpg/revision/latest/scale-to-width-down/1000?cb=20240313170655'),
  Photo(8, 'Envy',  " new cyan emotion who motivates Riley to pursue what others have",
      'https://static.wikia.nocookie.net/pixar/images/6/6c/Inside_Out_2_Character_Poster_-_Envy.jpg/revision/latest/scale-to-width-down/1000?cb=20240313170731'),
  Photo(9, 'Fear',  "a purple emotion responsible for protecting Riley from threats in the physical world",
      'https://static.wikia.nocookie.net/pixar/images/9/90/Inside_Out_2_Character_Poster_-_Fear.jpg/revision/latest/scale-to-width-down/1000?cb=20240313170408'),
];

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/Grid',
      routes: {
        '/Grid': (context) => const GridPage(),
        '/Image': (context) =>
            ImagePage(id: dummyPhotos[0].id), // Default id, update as needed
      },
    );
  }
}

class GridPage extends StatelessWidget {
  const GridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Gridview'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 한 행에 세 개의 사진을 배치
          crossAxisSpacing: 10.0, // 가로 간격
          mainAxisSpacing: 10.0, // 세로 간격
          childAspectRatio: 9 / 16,
        ),
        itemCount: dummyPhotos.length,
        itemBuilder: (context, index) {
          final photo = dummyPhotos[index];
          return AspectRatio(
            aspectRatio: 9 / 16,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ImagePage(key: UniqueKey(), id: photo.id),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(photo.url),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ImagePage extends StatelessWidget {
  final int id;

  const ImagePage({super.key, required this.id});

  Future<String> askGemini(String imageUrl) async {
    final apiKey = 'AIzaSyDKmvnlG1rCmNs7L7n3oEluJYihOGfPaik';
    final apiUrl = 'https://gemini.googleapis.com/v1/images:annotate?key=$apiKey';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "requests": [
          {
            "image": {
              "source": {
                "imageUri": imageUrl,
              }
            },
            "features": [
              {
                "type": "LABEL_DETECTION",
                "maxResults": 10,
              }
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      // 실제 응답에 따라 적절히 수정
      return 'Gemini의 응답: ${result['responses'][0]['labelAnnotations'][0]['description']}';
    } else {
      return 'Gemini 응답 오류: ${response.reasonPhrase}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final photo = dummyPhotos.firstWhere((photo) => photo.id == id);

    return Scaffold(
      appBar: AppBar(
        title: Text(photo.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 400,
                child: Image.network(photo.url, fit: BoxFit.contain),
              ),
              const SizedBox(height: 10),
              Text(
                photo.title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                photo.description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String response = await askGemini(photo.url);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Gemini의 응답'),
                        content: Text(response),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('닫기'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Gemini에게 물어보기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}