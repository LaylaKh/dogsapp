import 'package:dio/dio.dart';
import 'package:dogsapp/dio_settings.dart';
import 'package:dogsapp/dogs_model.dart';
import 'package:dogsapp/error_model.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String image = 'https://images.dog.ceo/breeds/papillon/n02086910_10147.jpg';
  String errorText = '';
  @override
  void initState() {
    getRandomImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: getRandomImage,
        child: const Icon(Icons.refresh),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Dog app'),
      ),
      body: Center(
        child: errorText == ''
            ? image == ''
                ? const CircularProgressIndicator()
                : Image.network(
                    image,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error, size: 100, color: Colors.red),
                  )
            : Text(
                errorText,
                style: const TextStyle(fontSize: 30
                ),
                textAlign: TextAlign.center,
              ), 
      ),
    );
  }

  Future<void> getRandomImage() async {

    final Dio dio = DioSettings().dio;
    
    try {
      final Response response =
          await dio.get('https://dog.ceo/api/breeds/image/random');
      final DogsModel model = DogsModel.fromJson(response.data);
      image = model.message ?? '';
      // print(response.data);
    } catch (e) {
      if (e is DioException) {
        final ErrorModel errorModel = ErrorModel.fromJson(
            e.response?.data); //пользователь видит какая ошибка
        errorText = errorModel.message ?? 'Ошибка';
      } else {
        errorText = 'Error';
      }
    }
    setState(() {});
  }
}
