import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:music_player/src/helpers/helpers.dart';
import 'package:music_player/src/models/audio_player_model.dart';
import 'package:music_player/src/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:assets_audio_player/assets_audio_player.dart';


class MusicPlayerPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Background(),
          Column(
            children: <Widget>[
              CustomAppBar(),
              ImagenDiscoDuracion(),
              TituloPlay(),
              Expanded(child: Lyrics(),),
            ],
          ),
        ],
      )
   );
  }
}

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: double.infinity ,
      height: screenSize.height *0.68,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft:Radius.circular(60)),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.center,
          colors:[
            Color(0xff33333E),
            Color(0xff201E28)
          ] )
      ),

    );
  }
}

class Lyrics extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final lyrics = getLyrics();
    return Container(
      child: ListWheelScrollView(
        itemExtent: 42,
        physics: BouncingScrollPhysics(),
        diameterRatio: 1.5, 
        children: lyrics.map((linea) => Text(linea, style: TextStyle(fontSize: 20, color: Colors.white.withOpacity(0.6)))).toList(),
      ),
    );
  }
}

class TituloPlay extends StatefulWidget{

  @override
  _TituloPlayState createState() => _TituloPlayState();
}

class _TituloPlayState extends State<TituloPlay> with SingleTickerProviderStateMixin{
  bool isPlaying = false;
  bool firstTime = true;
  AnimationController controller;

  final assetAudioPlayer = AssetsAudioPlayer();
 
  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: Duration(microseconds: 500));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void open(){
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context, listen: false);
    assetAudioPlayer.open(Audio('assets/Breaking-Benjamin-Far-Away.mp3'));
    assetAudioPlayer.currentPosition.listen((duration) {
      audioPlayerModel.currentPlaceInSong = duration;
    });
    assetAudioPlayer.current.listen((playingAudio) { 
      audioPlayerModel.songDuration = playingAudio.audio.duration;
    });
  }

  @override
  Widget build(BuildContext context) {
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      margin: EdgeInsets.only(top:20),
      child: Row(children: <Widget>[
        Column(children: <Widget>[
          Text(
            'Far Away',
            style: TextStyle(fontSize: 30, color: Colors.white.withOpacity(0.8)),
          ),
          Text(
            '-Breaking Benjamin-',
            style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.5)),
          ),
        ],),
        Spacer(),
        FloatingActionButton(
          elevation: 0,
          highlightElevation: 0,
          backgroundColor: Color(0xffF8CB51),
          child: AnimatedIcon(
            icon: AnimatedIcons.play_pause, 
            progress: controller,
          ),
          onPressed: (){
            if(this.isPlaying){
              controller.reverse();
              this.isPlaying=false;
              audioPlayerModel.controller.stop();
              
            }else{
              controller.forward();
              this.isPlaying=true;
              audioPlayerModel.controller.repeat();
            }

            if(firstTime){
              this.open();
              firstTime=false;
            }else{
              assetAudioPlayer.playOrPause();
            }

          })
      ],),
    );
  }
}

class ImagenDiscoDuracion extends StatelessWidget {
  const ImagenDiscoDuracion({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal:30),
      margin: EdgeInsets.only(top: 40),
      child: Row(children: <Widget>[
        ImagenDisco(),
        SizedBox(width: 20),
        BarraProgreso(),
        SizedBox(width: 20),

      ],),
    );
  }
}

class BarraProgreso extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
     final audioPlayerModel = Provider.of<AudioPlayerModel>(context);
     final percentage = audioPlayerModel.percentage;
    return Expanded(
      child: Container(
        child: Column(children: <Widget>[
          Text(
            audioPlayerModel.songTotalDuration,
            style: TextStyle(
              color: Colors.white.withOpacity(0.4),
            ),
          ),
          SizedBox(height: 10),
          Stack(children: <Widget>[
            Container(
              width:3,
              height: 230,
              color: Colors.white.withOpacity(0.1),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width:3,
                height: 230*percentage ,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ],),
           SizedBox(height: 10),
          Text(
           audioPlayerModel.currentSecond,
            style: TextStyle(
              color: Colors.white.withOpacity(0.4),
            ),
          ),
        ],),
      ),
    );
  }
}

class ImagenDisco extends StatelessWidget {
  const ImagenDisco({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);
    return Container(
    padding: EdgeInsets.all(20),
    height: 230,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(200),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
         SpinPerfect(
            animate: false,
            duration: Duration(seconds: 10),
            infinite: true,
            manualTrigger: true,
            controller: (animationController) => audioPlayerModel.controller=animationController,
            child: Image(image: AssetImage('assets/aurora.jpg'),)
          ),

          Container(
            width:25,
            height: 25,
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(100),
            ),
          ),

          Container(
            width:18,
            height: 18,
            decoration: BoxDecoration(
              color: Color(0xff1c1c25),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ],
      ),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(200),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        colors: [
          Color(0xff484750),
          Color(0xff1E1C24),
        ]
      ),
    ),    
      );
  }
}