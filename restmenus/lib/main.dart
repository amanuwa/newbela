// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, camel_case_types

// ignore: depend_on_referenced_packages
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:restmenus/myhomepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(

      // ignore: await_only_futures
      await EasyLocalization(
        
        
        supportedLocales: const [
    Locale("en", "US"),
    Locale("am", "ET"),
    Locale("de", "AT"),
  ],
   path: "assets",
    child: const Local_translate()));
}

class Local_translate extends StatefulWidget {
  const Local_translate({Key? key}) : super(key: key);

  @override
  State<Local_translate> createState() => _Local_translateState();
}

class _Local_translateState extends State<Local_translate> {
  @override
  Widget build(BuildContext context) { 
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: myhomepage(),
      debugShowCheckedModeBanner: false,
    );
  }
}



