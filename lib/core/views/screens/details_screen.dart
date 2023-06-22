
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:josequal_papers/core/controllers/wallpapers_controller.dart';
import 'package:josequal_papers/core/models/wallpapers_model.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatelessWidget {
  static String id = '/DetailsScreen';
  final WallPaperPhotos? photos;

  const DetailsScreen({this.photos, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          CachedNetworkImage(
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
            imageUrl: '${photos?.src?.large2x}',
            placeholder: (context, url) => const Center(
                child: CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black87),
            )),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Positioned(
              top: 36,
              left: 10,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(.75),
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              )),
          Positioned(
              bottom: 10,
              right: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await context
                            .read<WallPapersController>()
                            .downloadAndSaveImage('${photos?.src?.large2x}', context)
                            .then((_) =>
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Image has been downloaded'),
                                    duration: Duration(seconds: 2),
                                  ),
                                ));
                      },
                      child: Card(
                        color: Colors.white.withOpacity(.75),
                        elevation: 1.25,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.download),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => photos != null
                          ? context
                              .read<WallPapersController>()
                              .add2Fav(photos!)
                          : log('cannot be null'),
                      child: Card(
                        color: Colors.white.withOpacity(.75),
                        elevation: 1.25,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.favorite),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
