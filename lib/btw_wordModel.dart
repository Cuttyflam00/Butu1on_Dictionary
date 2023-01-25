import 'dart:convert';

Butuanon butuanonFromJson(String str) => Butuanon.fromJson(json.decode(str));

String butuanonToJson(Butuanon data) => json.encode(data.toJson());

class Butuanon {
  Butuanon({
    this.btwId,
    required this.btwWord,
    required this.partOfSpeech,
    required this.ipa,
    required this.audio,
    required this.transEnglish,
    required this.transTagalog,
    required this.difinition,
    required this.engSentences,
    required this.tagSentences,
    required this.btwSentences,
    required this.synEnglish,
    required this.synTagalog,
    required this.antEnglish,
    required this.antTagalog,
  });

  String? btwId = '';
  final String btwWord;
  final String partOfSpeech;
  final String ipa;
  final String audio;
  final String transEnglish;
  final String transTagalog;
  final String difinition;
  final String engSentences;
  final String tagSentences;
  final String btwSentences;
  final String synEnglish;
  final String synTagalog;
  final String antEnglish;
  final String antTagalog;

  static Butuanon fromJson(Map<String, dynamic> json) => Butuanon(
      btwId: json['btwId'],
      btwWord: json['btwWord'],
      partOfSpeech: json['partOfSpeech'],
      ipa: json['ipa'],
      audio: json['audio'],
      transEnglish: json['transEnglish'],
      transTagalog: json['transTagalog'],
      difinition: json['difinition'],
      engSentences: json['engSentences'],
      tagSentences: json['tagSentences'],
      btwSentences: json['btwSentences'],
      synEnglish: json['synEnglish'],
      synTagalog: json['synTagalog'],
      antEnglish: json['antEnglish'],
      antTagalog: json['antTagalog']);

  Map<String, dynamic> toJson() => {
        "btwId": btwId,
        "btwWord": btwWord,
        "partOfSpeech": partOfSpeech,
        "ipa": ipa,
        "audio": audio,
        "transEnglish": transEnglish,
        "transTagalog": transTagalog,
        "difinition": difinition,
        "engSentences": engSentences,
        "tagSentences": tagSentences,
        "btwSentences": btwSentences,
        "synEnglish": synEnglish,
        "synTagalog": synTagalog,
        "antEnglish": antEnglish,
        "antTagalog": antTagalog,
      };
}
