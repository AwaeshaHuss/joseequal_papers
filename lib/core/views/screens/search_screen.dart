
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:josequal_papers/core/controllers/controllers.dart';
import 'package:josequal_papers/core/views/widgets/widgets.dart';
import 'package:josequal_papers/utils/base/consts.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  static String id = '/SearchScreen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WallPapersController>(context, listen: true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: AppConsts.size.height * .165,
        // automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(0).copyWith(top: 4.0),
          child: Text(
            'Search',
            style: GoogleFonts.raleway(
              fontWeight: FontWeight.w500,
              letterSpacing: 1.5,
            ),
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(AppConsts.size.height * .01),
            child: Padding(
                padding: const EdgeInsets.all(2.0)
                    .copyWith(left: 6.0, right: 6.0, bottom: 4.0),
                child: CustomTextField(
                    controller: controller,
                    isSecure: false,
                    isReadOnly: false,
                    isFilled: true,
                    hintText: '',
                    title: '',
                    prefixWidget: const Icon(
                      Icons.search,
                      size: 26,
                    ),
                    onChanged: (schema) async{
                     provider.photos.clear();
                     await provider.loadWallPapers(schema.toString().trim());
                          setState(() {});
                    }))),
      ),
      body: Consumer<WallPapersController>(
          builder: (context, control, _) => control.photos.isNotEmpty
              ? GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 0.0),
                  physics: const BouncingScrollPhysics(),
                  itemCount: control.photos.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.75,
                      mainAxisSpacing: 2.0,
                      crossAxisSpacing: 10.0,
                      crossAxisCount: 1),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: CachedNetworkImage(
                        imageUrl: '${control.photos[index].src?.landscape}',
                        placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator.adaptive(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.black87),
                        )),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
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
