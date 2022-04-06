import 'dart:async';
import 'dart:typed_data';
import 'package:***REMOVED***/domain/services/connections_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ImageCachingService extends GetxService {
  final box = GetStorage('imagesBox');

  Future<Uint8List> getImage({required String url}) async {
    List? data = box.read(url);

    if (data is List) {
      List<int> intList = data.cast<int>().toList();
      return Uint8List.fromList(intList);
    }

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Uint8List image = response.bodyBytes;
      box.write(url, image);
      return image;
    } else {
      throw Exception('Error');
    }
  }

  cacheImage({required String url}) async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Uint8List image = response.bodyBytes;
      await box.write(url, image);
      return image;
    } else {
      throw Exception('Error');
    }
  }
}

class CachedImage extends StatefulWidget {
  final String Url;
  final double width;
  final double height;
  const CachedImage({
    Key? key,
    required this.Url,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  State<CachedImage> createState() => _CachedImageState();
}

class _CachedImageState extends State<CachedImage> {
  ImageCachingService imageCachingService = Get.find();
  ConnectionService connectionService = Get.find();

  StreamSubscription? sub;

  Uint8List? imageData;
  bool error = false;

  @override
  void initState() {
    super.initState();

    // Reload on connection resume
    sub = connectionService.hasConnectionStream.listen((event) {
      if (event && error) {
        load();
      }
    });
    load();
  }

  load() async {
    setState(() {
      error = false;
    });
    try {
      Uint8List d = await imageCachingService.getImage(url: widget.Url);
      if (mounted) {
        setState(() {
          imageData = d;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          error = true;
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (sub is StreamSubscription) sub!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Builder(builder: (_) {
        if (error) {
          return GestureDetector(
            onTap: () => load(),
            child: Center(
              child: Text('Error'),
            ),
          );
        }
        if (imageData == null) {
          return Center(child: CircularProgressIndicator());
        }
        if (imageData is Uint8List) {
          return Image.memory(
            imageData!,
            width: widget.width,
            height: widget.height,
          );
        }

        return SizedBox();
      }),
    );
  }
}
