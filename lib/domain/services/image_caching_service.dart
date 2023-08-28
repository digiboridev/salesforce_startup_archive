import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:salesforce.startup/domain/services/connections_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart' as pp;

class ImageCachingService extends GetxService {
  Future<Uint8List> getImage({required Uri url}) async {
    Directory appDocDir = await pp.getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    File file = File('$appDocPath${url.path}');

    bool exist = await file.exists();

    if (exist) {
      return await file.readAsBytes();
    }

    var response = await http.get(url);

    if (response.statusCode == 200) {
      Uint8List image = response.bodyBytes;
      await file.create(recursive: true);
      await file.writeAsBytes(image);
      return image;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future cacheBunch({required List<Uri> uris}) async {
    await Future.forEach(uris, (Uri uri) async {
      try {
        Directory appDocDir = await pp.getApplicationDocumentsDirectory();
        String appDocPath = appDocDir.path;

        File file = File('$appDocPath${uri.path}');

        bool exist = await file.exists();

        if (!exist) {
          var response = await http.get(uri);

          if (response.statusCode == 200) {
            Uint8List image = response.bodyBytes;
            await file.create(recursive: true);
            await file.writeAsBytes(image);
            print('Cached image : ' + uri.path);
            return;
          }
        }
      } catch (e) {
        print('Image caching error: ' + uri.path);
        print(e);
      }
    });
  }
}

class CachedImage extends StatefulWidget {
  final String Url;
  final double width;
  final double height;
  final BoxFit? boxFit;
  const CachedImage({Key? key, required this.Url, required this.width, required this.height, this.boxFit}) : super(key: key);

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
      Uint8List d = await imageCachingService.getImage(url: Uri.parse(widget.Url));
      if (mounted) {
        setState(() {
          imageData = d;
        });
      }
    } catch (e) {
      print(e);
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
              child: Text('Loading error'),
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
            fit: widget.boxFit,
            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
              return GestureDetector(
                onTap: () => load(),
                child: Center(
                  child: Text('Image broken'),
                ),
              );
            },
          );
        }

        return SizedBox();
      }),
    );
  }
}
