import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tik_tok_ui/constant/data.dart';
import 'package:tik_tok_ui/theme/colors.dart';
import 'package:tik_tok_ui/widgets/header_home_page.dart';
import 'package:tik_tok_ui/widgets/column_social_icon.dart';
import 'package:tik_tok_ui/widgets/left_panel.dart';
import 'package:tik_tok_ui/widgets/tik_tok_icons.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    print('dfdf000');
    _tabController = TabController(
      length: Provider.of<Data>(context).items.length,
      vsync: this,
    );
    print('dfdf');
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getBody();
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return RotatedBox(
      quarterTurns: 1,
      child: TabBarView(
        controller: _tabController,
        children:
            List.generate(Provider.of<Data>(context).items.length, (index) {
          return VideoPlayerItem(
            videoUrl: Provider.of<Data>(context).items[index]['videoUrl'],
            size: size,
            name: Provider.of<Data>(context).items[index]['name'],
            caption: Provider.of<Data>(context).items[index]['caption'],
            songName: Provider.of<Data>(context).items[index]['songName'],
            profileImg: Provider.of<Data>(context).items[index]['profileImg'],
            likes: Provider.of<Data>(context).items[index]['likes'],
            comments: Provider.of<Data>(context).items[index]['comments'],
            shares: Provider.of<Data>(context).items[index]['shares'],
            albumImg: Provider.of<Data>(context).items[index]['albumImg'],
          );
        }),
      ),
    );
  }
}

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  final String name;
  final String caption;
  final String songName;
  final String profileImg;
  final String likes;
  final String comments;
  final String shares;
  final String albumImg;
  VideoPlayerItem(
      {Key key,
      @required this.size,
      this.name,
      this.caption,
      this.songName,
      this.profileImg,
      this.likes,
      this.comments,
      this.shares,
      this.albumImg,
      this.videoUrl})
      : super(key: key);

  final Size size;

  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  VideoPlayerController _videoController;
  bool isShowPlaying = false;

  @override
  void initState() {
    super.initState();

    _videoController = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((value) {
        _videoController.play();
        setState(() {
          isShowPlaying = false;
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }

  Widget isPlaying() {
    return _videoController.value.isPlaying && !isShowPlaying
        ? Container()
        : Icon(
            Icons.play_arrow,
            size: 80,
            color: white.withOpacity(0.5),
          );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _videoController.value.isPlaying
              ? _videoController.pause()
              : _videoController.play();
        });
      },
      child: RotatedBox(
        quarterTurns: -1,
        child: Container(
            height: widget.size.height,
            width: widget.size.width,
            child: Stack(
              children: <Widget>[
                Container(
                  height: widget.size.height,
                  width: widget.size.width,
                  decoration: BoxDecoration(color: black),
                  child: Stack(
                    children: <Widget>[
                      VideoPlayer(_videoController),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(),
                          child: isPlaying(),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: widget.size.height,
                  width: widget.size.width,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 20, bottom: 10),
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          HeaderHomePage(),
                          Expanded(
                              child: Row(
                            children: <Widget>[
                              LeftPanel(
                                size: widget.size,
                                name: "${widget.name}",
                                caption: "${widget.caption}",
                                songName: "${widget.songName}",
                              ),
                              RightPanel(
                                size: widget.size,
                                likes: "${widget.likes}",
                                comments: "${widget.comments}",
                                shares: "${widget.shares}",
                                profileImg: "${widget.profileImg}",
                                albumImg: "${widget.albumImg}",
                              )
                            ],
                          ))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

class RightPanel extends StatelessWidget {
  final String likes;
  final String comments;
  final String shares;
  final String profileImg;
  final String albumImg;
  const RightPanel({
    Key key,
    @required this.size,
    this.likes,
    this.comments,
    this.shares,
    this.profileImg,
    this.albumImg,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: size.height,
        child: Column(
          children: <Widget>[
            Container(
              height: size.height * 0.3,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  getProfile(profileImg),
                  getIcons(TikTokIcons.heart, likes, 35.0),
                  getIcons(TikTokIcons.chat_bubble, comments, 35.0),
                  getIcons(TikTokIcons.reply, shares, 25.0),
                  getAlbum(albumImg)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
