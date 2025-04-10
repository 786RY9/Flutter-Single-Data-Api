import 'package:flutter/material.dart';
import 'package:single_data_api/api_services.dart';
import 'package:single_data_api/screen_without_model.dart';
import 'package:single_data_api/single_post_model.dart';

class ScreenWithModel extends StatefulWidget {
  const ScreenWithModel({super.key});

  @override
  State<ScreenWithModel> createState() => _ScreenWithModelState();
}

class _ScreenWithModelState extends State<ScreenWithModel> {
  bool isReady = false;
  SinglePostWithModel singlePostWithModel = SinglePostWithModel();

  _getSinglePost() async {
    setState(() {
      isReady = true;
    });

    try {
      final value = await ApiServices().getSinglePostWithModel();

      if (mounted) {
        setState(() {
          singlePostWithModel = value!;
          isReady = false;
        });
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          isReady = false;
        });
      }
      print(error);
    }
  }

  @override
  void initState() {
    _getSinglePost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Single Data API using Model'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: isReady
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  "User ID: ${singlePostWithModel.userId}",
                  style: const TextStyle(fontSize: 20, color: Colors.blue),
                ),
                Text(
                  singlePostWithModel.title ?? "",
                  style: const TextStyle(fontSize: 20, color: Colors.red),
                ),
                Text(
                  singlePostWithModel.body ?? "",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 33, 243, 121),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Delay navigation slightly for smooth Hero transition
                    Future.delayed(Duration(milliseconds: 200), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScreenWithoutModel(),
                        ),
                      );
                    });
                  },
                  child: const Text('Move to Screen Without Model'),
                ),
                const SizedBox(height: 15),

                // Hero image with transition customization
                Hero(
                  tag: 'img',
                  transitionOnUserGestures: true, // Optional: Allow for user gestures to trigger the transition
                  child: Material(
                    color: Colors.transparent,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 600), // Smooth transition duration
                      child: SizedBox(
                        height: 250,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            'assets/images/api_image.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
    );
  }
}
