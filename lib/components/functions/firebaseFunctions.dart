import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sporty_sam/components/functions/common.dart';
// import 'package:activity_recognition_flutter/activity_recognition_flutter.dart';
import 'package:sporty_sam/services/activity_recognition_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

Future<bool> updateUserActivity(
    ActivityEvent latestActivity, ActivityEvent preActivity, String? userID) async {
//  print(preActivity.type.toString()+"<----------->"+latestActivity.type.toString());
  final Directory directory = await getApplicationDocumentsDirectory();
  final File fileTime = File('${directory.path}/../files/fileTime.txt');
  final File logfile = File('${directory.path}/../files/logfile.txt');

  await logfile.writeAsString(DateTime.now().toString()+" activity push triggered: "+latestActivity.type.toString()+"\n",mode:FileMode.append);

  if (userID == null) return false;
  if (preActivity.type.toString() != latestActivity.type.toString()) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('healthHistory')
        .doc(dateOnly(preActivity.timeStamp).toString())
        .collection('activity')
        .doc(preActivity.timeStamp.toString())
        .set({
          "start": preActivity.timeStamp.toString(),
          "end": latestActivity.timeStamp.toString(),
          "type": preActivity.type.toString()
        })
        .then((value) => print(
            "Updated User activity firestore:" + preActivity.type.toString()))
        .catchError((error) =>
            print("Failed to Update User activity firestore: $error"));
    await fileTime.writeAsString(DateTime.now().toString());
    return true;
  } else {
    return false;
  }

}

void setDatabaseDate(String? userID) {
  FirebaseFirestore.instance
      .collection('users')
      .doc(userID)
      .collection('healthHistory')
      .doc(dateOnly(DateTime.now()).toString())
      .get()
      .then((onValue) {
    if (onValue.exists) {
      print("daily initial details already");
    } else {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('healthHistory')
          .doc(dateOnly(DateTime.now()).toString())
          .set({
            "steps": 0,
            "calIntake": 0,
            "calBurn": 0,
            "heartRate": 0,
            "activeMin": 0,
            "distance": 0,
            "sleep": 0,
            "glucose": 0,
            "weight": 0,
            "height": 0,
          })
          .then((value) => print("daily initial data added"))
          .catchError((error) => print("Failed to Update daily initial"));
    }
  });
}

Future<Map<String, double>> getActivitySummary(String? userID) async {
  double walk = 0, bicycle = 0, run = 0, still = 0, unknown = 0, sleep = 0;
  var result = await FirebaseFirestore.instance
      .collection('users')
      .doc(userID)
      .collection('healthHistory')
      .doc(dateOnly(DateTime.now()).toString())
      .collection('activity')
      .get();
//  print(result.docs.length);
  result.docs.forEach((res) {
//      print(res.get("type"));
    Duration actLength = DateTime.parse(res.get("end"))
        .difference(DateTime.parse(res.get("start")));
    if ((res.get("type") == "ActivityType.WALKING") ||
        (res.get("type") == "ActivityType.ON_FOOT"))
      walk += actLength.inSeconds;
    else if (res.get("type") == "ActivityType.RUNNING")
      run += actLength.inSeconds;
    else if (res.get("type") == "ActivityType.ON_BICYCLE")
      bicycle += actLength.inSeconds;
    else if (res.get("type") == "sleep")
      sleep += actLength.inSeconds;
    else
      still += actLength.inSeconds;
  });
  Map<String, double> summaryData = {
    "Walking": walk,
    "Running": run,
    "Cycling": bicycle,
    "Free": still,
    "sleep": sleep
  };
  print("got summary data: ");
//  print(summaryData);
  return summaryData;
}

Future<bool> fileSync(String? userID)async{
  print("filesync started");
  final Directory directory = await getApplicationDocumentsDirectory();
  final File file = File('${directory.path}/../files/example2.txt');
  final File fileTime = File('${directory.path}/../files/fileTime.txt');
  final File logfile = File('${directory.path}/../files/logfile.txt');

  await logfile.writeAsString(DateTime.now().toString()+" file sync started"+"\n",mode:FileMode.append);

  final List<String> lines= await file.readAsLines();

  await logfile.writeAsString(DateTime.now().toString()+" found backup logs from"+lines.first + " TO "+lines.last+"\n",mode:FileMode.append);

//  print(lines.length);
//  print(lines.first);
  if(lines.length>1){
//    print("aaa");
    int queueIndex=0;
    List<String> preLog=lines.first.split(',');
    List<String> nxtLog=lines.first.split(',');
    ///////////////from already backedup logs
    if(await fileTime.exists()){
      if(lines.length>1){
        final List<String> lastBackup= await fileTime.readAsLines();
        late DateTime backupTime = DateTime.parse(lastBackup.first);
          DateTime nextTime= DateTime.parse(lines[queueIndex].split(',').first);
          while(backupTime.isAfter(nextTime) && queueIndex<lines.length-1){
            queueIndex++;
            nextTime= DateTime.parse(lines[queueIndex].split(',').first);
          }
        await logfile.writeAsString(DateTime.now().toString()+" last backup found "+backupTime.toString()+"\n",mode:FileMode.append);


      }
    }
    else{
      queueIndex=1;
    }
    int lent=lines.length;
    await logfile.writeAsString(DateTime.now().toString()+" skipped already backup logs: $queueIndex out of $lent"+"\n",mode:FileMode.append);
    ////////////////////////////start to push
    for(int i=queueIndex;i<lines.length;i++){
//      print("bbb");
      nxtLog=lines[i].split(',');
      while(preLog[1]==nxtLog[1] && i<lines.length-1){
        i++;
        nxtLog=lines[i].split(',');
      }
      //send to db
      // prelog time as the start time
      // nxtlog time as the end time
      // prelog activity is the activity
      ActivityEvent preActivity = new ActivityEvent.fromCSVline(preLog.join(","));
      ActivityEvent nxtActivity = new ActivityEvent.fromCSVline(nxtLog.join(","));
      await updateUserActivity(nxtActivity, preActivity, userID);
      //
      preLog=nxtLog;
    }
  }
  await logfile.writeAsString(DateTime.now().toString()+" file sync done"+"\n",mode:FileMode.append);
  await file.writeAsString("");
  print("filesync ended");
  return true;
}