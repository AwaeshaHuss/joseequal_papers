import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:josequal_papers/core/controllers/wallpapers_controller.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});
  static String id = '/FavoritesScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(0).copyWith(top: 4.0),
          child: Text(
            'Favorites',
            style: GoogleFonts.raleway(
              fontWeight: FontWeight.w500,
              letterSpacing: 1.5,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<WallPapersController>(
          builder: (context, control, _) => control.favorite_photos.isNotEmpty
              ? GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 0.0),
                  physics: const BouncingScrollPhysics(),
                  itemCount: control.favorite_photos.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.75,
                      mainAxisSpacing: 2.0,
                      crossAxisSpacing: 10.0,
                      crossAxisCount: 1),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CachedNetworkImage(
                            imageUrl: '${control.favorite_photos[index].src?.landscape}',
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator.adaptive(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.black87),
                            )),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                          Positioned(
                            top: 20,
                            right: 20,
                            child: Icon(Icons.favorite, color: Colors.red[900],))
                        ],
                      ),
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black87),
                  ),
                )),
    );
  }
}
