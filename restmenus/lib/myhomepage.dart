// ignore_for_file: camel_case_types, duplicate_ignore


import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;

import 'dart:convert' as convert;
import 'dart:html';

import 'package:restmenus/feedback_model.dart';
import 'package:restmenus/feedme.dart';


class myhomepage extends StatefulWidget {
  const myhomepage({super.key});

  @override
  State<myhomepage> createState() => _myhomepageState();
}

// ignore: camel_case_types
class _myhomepageState extends State<myhomepage> {

 




  @override
  Widget build(BuildContext context) {
    return  Scaffold(

          

      body: FeedMe(),
    );
  }
}





//              class MultipleYouTubePlayer extends StatefulWidget {
//   @override
//   _MultipleYouTubePlayerState createState() => _MultipleYouTubePlayerState();
// }

// class _MultipleYouTubePlayerState extends State<MultipleYouTubePlayer> {
//   late List<YoutubePlayerController> _controllers;

//   @override
//   void initState() {
//     super.initState();

//     _controllers = youtubeVideoIds.map((videoId) {
//       return YoutubePlayerController(
//         initialVideoId: videoId,
//         flags: YoutubePlayerFlags(
//           autoPlay: false,
//           mute: false,
//         ),
//       );
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Multiple YouTube Players'),
//       ),
//       body: 
//       ListView.builder(
//         itemCount: _controllers.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: YoutubePlayer(
//               controller: _controllers[index],
//              // showVideoProgressIndicator: true,
//               onEnded: (metadata) {
//                 // Handle video playback completion if needed
//               },
//             ),
//           );
//         },
//       ),


//     );
//   }

//   @override
//   void dispose() {
//     for (var controller in _controllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }
// }

