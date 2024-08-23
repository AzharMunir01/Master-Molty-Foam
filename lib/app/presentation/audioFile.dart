// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';
//
// class FileListScreen extends StatefulWidget {
//   @override
//   _FileListScreenState createState() => _FileListScreenState();
// }
//
// class _FileListScreenState extends State<FileListScreen> {
//   List<FileSystemEntity> files = [];
//   AudioPlayer audioPlayer = AudioPlayer();
//   String? currentPlaying;
//
//   @override
//   void initState() {
//     super.initState();
//     // requestPermissions().then((_) {
//       getFiles().then((fetchedFiles) {
//         setState(() {
//           files = fetchedFiles;
//         });
//       });
//     // });
//   }
//   Future<List<FileSystemEntity>> getFiles() async {
//     final directory = Directory('/storage/emulated/0/Download/molty');
//     if (await directory.exists()) {
//       return directory.listSync().where((item) => item.path.endsWith('.mp3')).toList();
//     }
//     return [];
//   }
//   void playAudio(String path) async {
//     if (currentPlaying != null) {
//       await audioPlayer.stop();
//     }
//     try {
//       await audioPlayer.play(DeviceFileSource(path));
//       setState(() {
//         currentPlaying = path;
//       });
//     } catch (e) {
//       print("Error playing audio: $e");
//     }
//   }
//
//   void stopAudio() async {
//     await audioPlayer.stop();
//     setState(() {
//       currentPlaying = null;
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Call Recordings'),
//       ),
//       body: ListView.builder(
//         itemCount: files.length,
//         itemBuilder: (context, index) {
//           String fileName = files[index].path.split('/').last;
//           return ListTile(
//             title: Text(fileName),
//             onTap: () {
//               if (currentPlaying == files[index].path) {
//                 stopAudio();
//               } else {
//                 playAudio(files[index].path);
//               }
//             },
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';

class FileListScreen extends StatefulWidget {
  @override
  _FileListScreenState createState() => _FileListScreenState();
}

class _FileListScreenState extends State<FileListScreen> {
  List<FileSystemEntity> files = [];
  AudioPlayer audioPlayer = AudioPlayer();
  String? currentPlaying;
  Duration currentPosition = Duration();
  Duration totalDuration = Duration();

  @override
  void initState() {
    super.initState();
    requestPermissions().then((_) {
      getFiles().then((fetchedFiles) {
        setState(() {
          files = fetchedFiles;
        });
      });
    });

    audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        currentPosition = position;
      });
    });

    audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        totalDuration = duration;
      });
    });

    audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        currentPlaying = null;
        currentPosition = Duration();
      });
    });
  }

  Future<void> requestPermissions() async {
    await Permission.storage.request();
  }

  Future<List<FileSystemEntity>> getFiles() async {
    final directory = Directory('/storage/emulated/0/Download/molty');
    if (await directory.exists()) {
      return directory.listSync().where((item) => item.path.endsWith('.mp3')).toList();
    }
    return [];
  }

  void playAudio(String path) async {
    if (currentPlaying != null) {
      await audioPlayer.stop();
    }
    try {
      await audioPlayer.play(DeviceFileSource(path));
      setState(() {
        currentPlaying = path;
      });
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  void pauseAudio() async {
    await audioPlayer.pause();
  }

  void stopAudio() async {
    await audioPlayer.stop();
    setState(() {
      currentPlaying = null;
      currentPosition = Duration();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Call Recordings'),
      ),
      body: ListView.builder(
        itemCount: files.length,
        itemBuilder: (context, index) {
          String fileName = files[index].path.split('/').last;
          bool isPlaying = currentPlaying == files[index].path;
          return Container(
            margin: EdgeInsets.all(10),
             color: Colors.grey.withOpacity(0.5),
            padding: EdgeInsets.all(10),
            child: ListTile(
            title: Text(fileName),
            trailing: IconButton(
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
              onPressed: () {
                if (isPlaying) {
                  pauseAudio();
                } else {
                  playAudio(files[index].path);
                }
              },
            ),
            subtitle: isPlaying
                ? Column(
              children: [
                LinearProgressIndicator(
                  value: totalDuration.inSeconds > 0
                      ? currentPosition.inSeconds / totalDuration.inSeconds
                      : 0.0,
                ),
                Text(
                  "${currentPosition.toString().split('.').first} / ${totalDuration.toString().split('.').first}",
                  style: TextStyle(fontSize: 12.0),
                ),
              ],
            )
                : null,
          ),);
        },
      ),
    );
  }
}
