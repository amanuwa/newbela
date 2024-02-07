// ignore_for_file: depend_on_referenced_packages, deprecated_member_use, empty_catches

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:video_player/video_player.dart';
import 'package:restmenus/feedback_model.dart';
import 'package:chewie/chewie.dart';
import 'package:carousel_slider/carousel_slider.dart';

class FeedMe extends StatefulWidget {
  const FeedMe({Key? key});

  @override
  State<FeedMe> createState() => _FeedMeState();
}

class _FeedMeState extends State<FeedMe> {
  List<String> lang = ["fish", "hot drinks", "Ethiopian", "france", "Arabic"];
  String selectedLang = "";
  List<FeedbackModel> feedbacks = [];

  List<dynamic> specialnames = [];
  List<dynamic> specialid = [];
  List<dynamic> specialingredients = [];
  List<dynamic> specialvideos = [];
  List<dynamic> specialprices = [];
  List<dynamic> subnames = [];
  List<dynamic> subid = [];
  List<dynamic> subingredients = [];
  List<dynamic> subvideos = [];
  List<dynamic> subprices = [];
  List jsonfeedback = [];
  List catagorylist = [];
  var catagorynumber = 0;

  late List<VideoPlayerController> _controllers;
  late List<Future<void>> _initializeVideoPlayerFutures;

  late List<ChewieController> _gridChewieControllers;
  late List<VideoPlayerController> _gridVideoControllers;

  getFeedbackFromSheet() async {
    var url = Uri.parse(
        'https://script.google.com/macros/s/AKfycbxTLRLE5HWISOoNa4Lpg_NHcdW-CysDfrWcnOCHFgD31Gx1RYr5RQf1sxuIds1UB6XM/exec');
    var response = await http.get(url);
    jsonfeedback = convert.jsonDecode(response.body);
    setState(() {
      catagorylist =
          jsonfeedback[2].map((item) => item['name'].toString()).toList();
      specialnames =
          jsonfeedback[3].map((item) => item['name'].toString()).toList();
      specialid = jsonfeedback[3].map((item) => item['id'].toString()).toList();
      specialingredients = jsonfeedback[3]
          .map((item) => item['ingredients'].toString())
          .toList();
      specialvideos =
          jsonfeedback[3].map((item) => item['video'].toString()).toList();
      specialprices =
          jsonfeedback[3].map((item) => item['price'].toString()).toList();
    });

    // print(specialvideos);
  }

  getsubcatagory(catagorynumber) async {
    subnames = await jsonfeedback[catagorynumber]
        .map((item) => item['name'].toString())
        .toList();
    subid = await jsonfeedback[catagorynumber]
        .map((item) => item['id'].toString())
        .toList();
    subingredients = await jsonfeedback[catagorynumber]
        .map((item) => item['ingredients'].toString())
        .toList();
    subvideos = await jsonfeedback[catagorynumber]
        .map((item) => item['video'].toString())
        .toList();
    subprices = await jsonfeedback[catagorynumber]
        .map((item) => item['price'].toString())
        .toList();
    setState(() {
      // initializesubVideoPlayers();
      initGridVideoPlayers();
    });
  }

  @override
  void initState() {
    super.initState();
    getFeedbackFromSheet();
    // initGridVideoPlayers();
    // initializespecialVideoPlayers();
  }

  Future<void> initGridVideoPlayers() async {
    try {
      _gridVideoControllers = subvideos
          .map((path) => VideoPlayerController.network(path)..setLooping(true))
          .toList();

      _gridChewieControllers = _gridVideoControllers
          .map(
            (controller) => ChewieController(
              videoPlayerController: controller,
            //   autoPlay: true, // Set to false to prevent autoplay
            //  looping: true,
              showControls: false,
               aspectRatio: 16 / 9,
            //   // allowMuting: true,
            //   autoInitialize: true,
            ),
          )
          .toList();

      await Future.wait(
          _gridVideoControllers.map((controller) => controller.initialize()));

      setState(() {
        // Start playing videos
        for (var controller in _gridVideoControllers) {
          controller.play();
         controller.setLooping(true);
        //  controller.initialize();
        
        }
      });
    } catch (error) {}
  }

  Future<void> initializespecialVideoPlayers() async {
    try {
      // _controllers = specialvideos
      //     .map((path) => VideoPlayerController.network(path)..setLooping(true))
      //     .toList();

      // _initializeVideoPlayerFutures =
      //     _controllers.map((controller) => controller.initialize()).toList();

      // await Future.wait(_initializeVideoPlayerFutures);

      // setState(() {
      //   for (var controller in _controllers) {
      //     controller.play();
      //     controller.setLooping(true);
      //     controller.setVolume(0.0);
      //   }
      // });
      // _subcontrollers = subvideos
      //     .map((path) => VideoPlayerController.network(path)..setLooping(true))
      //     .toList();

      // _subinitializeVideoPlayerFutures =
      //     _subcontrollers.map((controller) => controller.initialize()).toList();

      // await Future.wait(_subinitializeVideoPlayerFutures);

      // setState(() {
      //   for (var controller1 in _subcontrollers) {
      //     controller1.play();
      //     controller1.setLooping(true);
      //     controller1.setVolume(0.0);
      //   }
      // });
    } catch (error) {
      // You can add more specific error handling here if needed.
    }
  }

  // Future<void> initializesubVideoPlayers() async {
  //   try {
  //     _subcontrollers = subvideos
  //         .map((path) => VideoPlayerController.network(path)..setLooping(true))
  //         .toList();

  //     _subinitializeVideoPlayerFutures =
  //         _subcontrollers.map((controller) => controller.initialize()).toList();

  //     await Future.wait(_subinitializeVideoPlayerFutures);

  //     setState(() {
  //       for (var controller in _subcontrollers) {
  //         controller.play();
  //         controller.setLooping(true);
  //         controller.setVolume(0.0);
  //       }
  //     });
  //   } catch (error) {
  //     print('Error initializing video players: $error');

  //     // You can add more specific error handling here if needed.
  //   }
  // }

  int focusedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double wdth = MediaQuery.of(context).size.width;
    double hight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: hight * 0.09,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(2, 8, 2, 2),
                    height: hight * 0.3,
                    width: wdth * 0.25,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLPT2nwd__DulLQ4ZjrIHE2MhXYjUwhrANXg&usqp=CAU",
                        ),
                        alignment: Alignment.topLeft,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(1, 20, 1, 0),
                    width: wdth * 0.5,
                    height: hight * 0.3,
                    alignment: Alignment.topLeft,
                    child: Text(
                      " \t\t\t\t\t\t\t\t\t\t\t\t\t WELCOME TO  \n \t\t HAILE GRAND ADDIS ABEBA  \n \t\t\t\t\t\t\t\t\t\t\t\t\t FOOD MENU",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: wdth * 0.03,
                        color: const Color.fromARGB(255, 12, 56, 92),
                      ),
                    ),
                  ),
                  Container(
                    width: wdth * 0.2,
                    height: hight * 0.3,
                    margin: const EdgeInsets.only(left: 5),
                    child: DropdownButton<String>(
                      items: lang
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: wdth * 0.03,
                                    color:
                                        const Color.fromARGB(255, 12, 56, 92),
                                  ),
                                ),
                              ))
                          .toList(),
                      hint: const Text('english'),
                      onChanged: (value) {
                        setState(() {
                          selectedLang = value.toString();
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_drop_down_sharp,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              width: wdth,
              height: hight * 0.3,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: catagorylist.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    onPressed: () {
                      print('catagoryindex' + '$index');

                      setState(() {
                        catagorynumber = index;
                        getsubcatagory(catagorynumber);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 12, 56, 92),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 5.0,
                    ),
                    child: Center(
                      child: Text(
                        catagorylist[index],
                        style: TextStyle(
                          fontSize: wdth * 0.03,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              height: hight * 0.58,
              width: wdth,
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(5),
                        //color: Colors.amber,
                        height: hight * 0.03,
                        width: wdth * 0.33,
                        child: Text(
                          'House Special',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: wdth * 0.04,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        child: Text(
                          ('${focusedIndex}\t\tof\t\t${specialnames.length}'),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      // Container(
                      //   child: Text(
                      //     (specialnames[index]),
                      //     style: TextStyle(fontWeight: FontWeight.bold),
                      //   ),
                      // )
                    ],
                  ),
                  Container(
                    width: wdth,
                    height: hight * 0.3,
                    // margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    color: const Color.fromARGB(255, 12, 56, 92),
                    child: Container(
                      child: CarouselSlider.builder(
                        itemCount: specialvideos.length,
                        options: CarouselOptions(
                          //   height: MediaQuery.of(context).size.height * 0.29,
                          // viewportFraction: 0.8,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: false,
                          autoPlay: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              focusedIndex = index;
                            });
                          },
                        ),
                        itemBuilder: (context, index, realIndex) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(
                                  specialnames[index],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                height: hight * 0.2,
                                // padding: EdgeInsets.all(50),
                                // margin: const EdgeInsets.symmetric(
                                //     horizontal: 5.0),
                                // color:
                                //     const Color.fromARGB(255, 12, 56, 92),
                                child: GestureDetector(
                                  
                                  child: Listener(
                                    onPointerDown: (event) {
                                      print('tabbed index$focusedIndex');


                                      setState(() {
                                        showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(specialnames[focusedIndex]),
                  content: Container(
                    height: hight*0.6,
                    width:wdth*0.6 ,
                    child: Column(
                      children: [
                        Container(
                          height: hight*0.25,
                          width: wdth*0.5,
                         // color: Colors.red,
                        child: Chewie(
                                      key: UniqueKey(),
                                      controller: ChewieController(
                                        videoPlayerController:
                                            VideoPlayerController.network(
                                                specialvideos[focusedIndex]),
                                        autoPlay: index == focusedIndex,
                                        looping: true,
                                        showControls:
                                            false, // Set to false to hide controls
                                        aspectRatio: 16 /
                                            9, // Adjust aspect ratio as needed
                                        allowMuting: true,
                                        // Allow muting the video
                                        // Show mute icon
                                        autoInitialize: true,
                                        // Other ChewieController options as needed
                                      ),
                                    ),
                        ),
                         Container(
                          height: hight*0.3,
                          width: wdth*0.5,
                         child: Text(specialingredients[focusedIndex]),
                         )
                    
                      ],
                     
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Dismiss the dialog
                      
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
                                      });




                                    },
                                    child: Chewie(
                                      key: UniqueKey(),
                                      controller: ChewieController(
                                        videoPlayerController:
                                            VideoPlayerController.network(
                                                specialvideos[index]),
                                        autoPlay: index == focusedIndex,
                                        looping: true,
                                        showControls:
                                            false, // Set to false to hide controls
                                        aspectRatio: 16 /
                                            9, // Adjust aspect ratio as needed
                                        allowMuting: true,
                                        // Allow muting the video
                                        // Show mute icon
                                        autoInitialize: true,
                                        // Other ChewieController options as needed
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                // margin: EdgeInsets.all(10),
                                child: Text(
                                  specialprices[index],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),



                        
                  ),
////////////////////////////////
                  Container(
                    margin: const EdgeInsets.all(5),
                    width: wdth,
                    height: hight * 0.4,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 5.0,
                      ),
                      itemCount: subvideos.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                         
                          child: Listener(
            //                 onPointerDown: (event) {
            //                   print('tabbed index$index');
                              
            //                           setState(() {
            //                             showDialog(
            //   context: context,
            //   builder: (BuildContext context) {
            //     return AlertDialog(
            //       title: Text(subnames[index]),
            //       content: Container(
            //         height: hight*0.6,
            //         width:wdth*0.6 ,
            //         child: Column(
            //           children: [
            //             Container(
            //               height: hight*0.25,
            //               width: wdth*0.5,
            //              // color: Colors.red,
            //              child: Chewie(
            //                       //key: UniqueKey(),
            //                       controller: _gridChewieControllers[index]),
            //             ),
            //              Container(
            //               height: hight*0.3,
            //               width: wdth*0.5,
            //              child: Text(subprices[index]),
            //              )
                    
            //           ],
                     
            //         ),
            //       ),
            //       actions: [
            //         TextButton(
            //           onPressed: () {
            //             Navigator.of(context).pop(); // Dismiss the dialog
                      
            //           },
            //           child: Text('OK'),
            //         ),
            //       ],
            //     );
            //   },
            // );
            //                           });

            //                 },




                            child: Column(
                          
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    width: wdth,
                                    decoration: const BoxDecoration(
                                        color:  Color.fromARGB(255, 12, 56, 92),
                                      borderRadius:  BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                           topRight: Radius.circular(20)
                                      )
                                    ),
                                    //color: const Color.fromARGB(255, 12, 56, 92),
                                    child: Center(
                                      child: Text(
                                        subnames[index],
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 8,
                                    child: Container(
                                        width: wdth,
                                        color:
                                            const Color.fromARGB(255, 12, 56, 92),
                                         child: Chewie(
                                  //key: UniqueKey(),
                                  controller: _gridChewieControllers[index]),
                                        )),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    width: wdth,
                                     decoration: const BoxDecoration(
                                        color:  Color.fromARGB(255, 12, 56, 92),
                                      borderRadius:  BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                           bottomRight: Radius.circular(20)
                                      )
                                    ),
                                    child: Center(
                                      child: Text(
                                        subprices[index],
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    width: wdth,
                    height: hight * 0.1,
                    // color: Colors.black,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            width: wdth * 0.2,
                            height: hight * 0.1,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              'assets/logo.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Container(
                           // color: Colors.amber,
                            width: wdth ,
                            height: hight * 0.1,
                           child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                            Container(
                              alignment: Alignment.center,
                              
                              child: Text(' Digital menu by pioneer plc',style: TextStyle(
                                fontWeight: FontWeight.bold,fontSize: wdth*0.03
                              ),),
                            ),
                             Container(
                               alignment: Alignment.topLeft,
                               child: Text(' Contact us :',style: TextStyle(
                                fontWeight: FontWeight.bold,fontSize: wdth*0.03
                                                           ),),
                             ),
                           ]),
                          ),
                        )

                      ],
                    ),
                  )
                  //        Container(child: ,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class VideoPlayerItem extends StatefulWidget {
//   final VideoPlayerController controller;

//   const VideoPlayerItem({Key? key, required this.controller});

//   @override
//   _VideoPlayerItemState createState() => _VideoPlayerItemState();
// }

// class _VideoPlayerItemState extends State<VideoPlayerItem> {
//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: widget.controller.value.aspectRatio,
//       child: VideoPlayer(widget.controller),
//     );
//   }
// }
