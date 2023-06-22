import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:josequal_papers/core/models/models.dart';
import 'package:josequal_papers/utils/base/consts.dart';

class WallPapersController extends ChangeNotifier {
  List<WallPaperPhotos> photos = [];
  List<WallPaperPhotos> favorite_photos = [];

  Future loadWallPapers(String schema) async {
    final url = Uri.parse('${AppConsts.searchUrl}$schema');
    final headers = {
      'Authorization': AppConsts.APIKey,
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      // Request was successful
      List photos = body['photos'];
      for (var photo in photos) {
        this.photos.add(WallPaperPhotos.fromJson(photo));
        log('=======url=========\n${photo['src']['original']}');
      }
    } else {
      // Request failed
      log('Request failed with status code: ${response.statusCode}');
    }
    notifyListeners();
  }

  add2Fav(WallPaperPhotos photo) {
    favorite_photos.add(photo);
    notifyListeners();
    log('added to fav');
  }

  removeFav(WallPaperPhotos photo) {
    favorite_photos.remove(photo);
    notifyListeners();
     log('removed from fav');
  }

  Future<void> downloadAndSaveImage(String imageUrl, context) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        final result = await ImageGallerySaver.saveImage(response.bodyBytes);
        if (result['isSuccess']) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Added to favorite'),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          log('Failed to save image: ${result['errorMessage']}');
        }
      } else {
        log('Failed to download image: ${response.statusCode}');
      }
    } catch (e) {
      log('Error while downloading image: $e');
    }
  }
}
