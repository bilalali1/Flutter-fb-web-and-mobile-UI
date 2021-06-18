import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';
import '../data/data.dart';
import '../widgets/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../widgets/circle_button.dart';
import '../config/palette.dart';




class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), //if you click on text field then you can click on any where on mobile screen to get rid of textfield
      child: Scaffold(
        body: SafeArea(
          child:
          Responsive(
            mobile: HomeMobileScreen(scrollController: _trackingScrollController),
            desktop: HomeDesktopScreen(scrollController: _trackingScrollController),

          ),
        ),
      ),
    );
  }
}


class HomeMobileScreen extends StatelessWidget {
final TrackingScrollController scrollController;

  const HomeMobileScreen({Key key,
    @required this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverAppBar(
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            title: Text('facebook',
              style: const TextStyle(
                color: Palette.facebookBlue,
                fontWeight: FontWeight.bold,
                fontSize: 28.0,
                letterSpacing: -1.2,
              ),
            ),
            centerTitle: false,
            floating: true,

            actions:[
              CircleButton(icon: Icons.search, iconSize: 30, onPressed: ()=> print('search'),  ),
              CircleButton(icon: MdiIcons.facebookMessenger, iconSize: 30, onPressed: ()=> print('search'),  ),
            ]

        ),
        SliverToBoxAdapter(
          child: CreatePostContainer(currentUser: currentUser,),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(0.0,10.0,0.0,5.0),
          sliver: SliverToBoxAdapter(
            child: Rooms(
                onlineUsers: onlineUsers
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(0.0,5.0,0.0,5.0),
          sliver: SliverToBoxAdapter(
            child: Stories(
                currentUser: currentUser,
                stories: stories
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                ( ctx, index){
              final Post post = posts[index];
              return PostContainer(post: post);
            },
            childCount: posts.length,
          ),
        )
      ],
    );
  }
}


class HomeDesktopScreen extends StatelessWidget {
  final TrackingScrollController scrollController;

  const HomeDesktopScreen({Key key,
    @required this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child:  Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: MoreOptionsList(currentUser: currentUser),
              ),
            ),
          ),
    ),

        const Spacer(),
        Container(
          width: 600.0,
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(0.0,20.0,0.0,10.0),
                sliver: SliverToBoxAdapter(
                  child: Stories(
                      currentUser: currentUser,
                      stories: stories
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: CreatePostContainer(currentUser: currentUser,),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(0.0,10.0,0.0,5.0),
                sliver: SliverToBoxAdapter(
                  child: Rooms(
                      onlineUsers: onlineUsers
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      ( ctx, index){
                    final Post post = posts[index];
                    return PostContainer(post: post);
                  },
                  childCount: posts.length,
                ),
              )
            ],
          ),
        ),
        const Spacer(),
        Flexible(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ContactList(users: onlineUsers),
              ),
              ),
            )),

      ],
    );
  }
}
