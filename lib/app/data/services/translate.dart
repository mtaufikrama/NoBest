import 'package:flutter/material.dart';
import 'package:nobes/app/data/services/font.dart';
import 'package:nobes/app/data/services/public.dart';
import 'package:translator/translator.dart';

Future<String> translates(
  String text, {
  String? to,
}) async {
  String translate;
  try {
    var translates = await GoogleTranslator()
        .translate(text, to: to ?? Publics.controller.getBahasa.value);
    translate = translates.text;
  } catch (e) {
    translate = text;
  }
  return translate;
}

String stringTranslate(String text) {
  String? translate;
  translates(text).then(
    (value) {
      translate = value;
      if (translate != null) {
        return translate;
      } else {
        return text;
      }
    },
  );
  return translate ?? text;
}

FutureBuilder<String> translateTeks(
  String text, {
  required TextStyle style,
  String? kodeBahasa,
  required bool isCapitalized,
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
}) {
  return FutureBuilder<String>(
    future:
        translates(text, to: kodeBahasa ?? Publics.controller.getBahasa.value),
    builder: (context, snapshot) {
      if (snapshot.hasData && snapshot.data != null) {
        return Text(
          isCapitalized == false
              ? snapshot.data!.toTitleCase()
              : snapshot.data!.toUpperCase(),
          style: style,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
        );
      } else {
        return Text(
          isCapitalized == false ? text.toTitleCase() : text.toUpperCase(),
          style: style,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
        );
      }
    },
  );
}

Widget teksLanguage(
  String text, {
  String? kodeBahasa,
  required TextStyle style,
  bool isCapitalized = false,
  TextAlign? textAlign,
  int? maxLines,
  TextOverflow? overflow,
}) {
  kodeBahasa = kodeBahasa ?? Publics.controller.getBahasa.value;
  return kodeBahasa == 'en'
      ? Text(
          isCapitalized == false ? text.toTitleCase() : text.toUpperCase(),
          style: style,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
        )
      : translateTeks(
          text,
          isCapitalized: isCapitalized,
          kodeBahasa: kodeBahasa,
          style: style,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
        );
}
