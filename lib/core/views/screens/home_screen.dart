import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:josequal_papers/core/controllers/controllers.dart';
import 'package:josequal_papers/core/views/screens/details_screen.dart';
import 'package:josequal_papers/core/views/screens/favorites_screen.dart';
import 'package:josequal_papers/core/views/screens/search_screen.dart';
import 'package:josequal_papers/core/views/widgets/widgets.dart';
import 'package:josequal_papers/utils/base/consts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String id = '/HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<bool> isFaved = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      final papers = Provider.of<WallPapersController>(context, listen: false);
      await papers.loadWallPapers('office');
    }).then((_) => isFaved = List.generate(
        context.read<WallPapersController>().photos.length, (index) => false));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: AppConsts.size.height * .165,
          automaticallyImplyLeading: false,
          leading: Builder(builder: (context) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.sort));
          }),
          title: Padding(
            padding: const EdgeInsets.all(0).copyWith(top: 4.0),
            child: Text(
              'JoSequal',
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
                      controller: TextEditingController(),
                      isSecure: true,
                      isReadOnly: true,
                      isFilled: true,
                      hintText: 'Search',
                      title: '',
                      prefixWidget: const Icon(
                        Icons.search,
                        size: 26,
                      ),
                      onTap: () =>
                          Navigator.pushNamed(context, SearchScreen.id)))),
        ),
        drawer: Drawer(
          width: AppConsts.size.width * .425,
          backgroundColor: Colors.white.withOpacity(.95),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                margin: EdgeInsets.only(top: AppConsts.size.height * .085)
                    .copyWith(right: 6.0, left: 6.0),
                elevation: 2.5,
                child: ListTile(
                  onTap: () {
                    // todo => navigate to favorite.
                    Navigator.of(context).pushNamed(FavoritesScreen.id);
                  },
                  leading: const Icon(Icons.favorite),
                  trailing: const Text('Favorite'),
                ),
              ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.all(4.0),
                child: Text('Developed by Hussein Al-Awaisheh.Sr'),
              )
            ],
          ),
        ),
        body: Consumer<WallPapersController>(builder: (context, control, _) {
          return control.photos.isNotEmpty
              ? GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 0.0),
                  physics: const BouncingScrollPhysics(),
                  itemCount: control.photos.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.75,
                      mainAxisSpacing: 2.0,
                      crossAxisSpacing: 10.0,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      // todo => navigate to details screen.
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(photos: control.photos[index]),));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  '${control.photos[index].src?.landscape}',
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator.adaptive(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.black87),
                              )),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            Positioned(
                                top: -4,
                                right: -4,
                                child: IconButton(
                                    onPressed: () {
                                      !isFaved[index]
                                          ? control
                                              .add2Fav(control.photos[index])
                                          : control.removeFav(
                                              control.photos[index]);
                                      setState(() {
                                        isFaved[index] = !isFaved[index];
                                      });
                                    },
                                    icon: Icon(
                                      isFaved[index]
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isFaved[index]
                                          ? Colors.red[800]
                                          : Colors.blueGrey[900],
                                    ))),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black87),
                  ),
                );
        }),
      ),
    );
  }
}
