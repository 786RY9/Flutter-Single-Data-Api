import 'package:flutter/material.dart';
import 'package:single_data_api/api_services.dart';

class ScreenWithoutModel extends StatefulWidget {
  const ScreenWithoutModel({super.key});

  @override
  State<ScreenWithoutModel> createState() => _ScreenWithoutModelState();
}

class _ScreenWithoutModelState extends State<ScreenWithoutModel> {
  dynamic singlePost;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getSinglePostWithoutModel();
  }

  Future<void> _getSinglePostWithoutModel() async {
    try {
      final value = await ApiServices().getSinglePostWithoutModel();
      setState(() {
        singlePost = value;
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Single Data API without Model'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          // Always show Hero first
          Expanded(
            child: Hero(
              tag: 'img',
              child: Material(
                color: Colors.transparent,
                child: AnimatedSwitcher(
                  duration: const Duration(
                    milliseconds: 600,
                  ), // Smooth transition duration
                  child: SizedBox(
                    width: double.infinity,
                    height: 500,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset('assets/images/api_image.jpg'),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Then show content or loading
          Expanded(
            child: Center(
              child:
                  isLoading
                      ? const CircularProgressIndicator()
                      : Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "User ID: ${singlePost['userId']}",
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              singlePost['title'],
                              style: const TextStyle(
                                color: Colors.redAccent,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              singlePost['body'],
                              style: const TextStyle(
                                color: Colors.teal,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
