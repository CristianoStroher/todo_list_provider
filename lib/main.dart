import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/services/app_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // name: "todo",
      options: const FirebaseOptions(
          appId: '1:803868805505:android:c0b3f6e6fabf65f9310080',
          messagingSenderId: '297855924061',
          projectId: 'todo-list-provider-d3e0c',
          apiKey: 'AIzaSyDeO8OEebuMdR1eZhbugs0FlXBOP782-Gk'));
 
 
  runApp(const AppModule());
}
