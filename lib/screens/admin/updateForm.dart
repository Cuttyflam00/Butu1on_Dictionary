import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../btw_wordModel.dart';
import '../../utils/reusable_widget.dart';
import 'adminPage.dart';

class UpdateForm extends StatefulWidget {
  final Butuanon butuanonWord;
  const UpdateForm({super.key, required this.butuanonWord});

  @override
  State<UpdateForm> createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateForm> {
  final butuanonWordController = TextEditingController();

  final partOfSpeechController = TextEditingController();

  final ipaController = TextEditingController();

  final audioController = TextEditingController();

  final transEnglishController = TextEditingController();

  final transTagalogController = TextEditingController();

  final difinitionController = TextEditingController();

  final engSentencesController = TextEditingController();
  final tagSentencesController = TextEditingController();
  final btwSentencesController = TextEditingController();

  final synEnglishController = TextEditingController();

  final synTagalogController = TextEditingController();

  final antEnglishController = TextEditingController();

  final antTagalogController = TextEditingController();

  final db = FirebaseFirestore.instance;

  final _reference = FirebaseFirestore.instance.collection('butuanonWords');

  @override
  Widget build(BuildContext context) {
    butuanonWordController.text = widget.butuanonWord.btwWord;
    partOfSpeechController.text = widget.butuanonWord.partOfSpeech;
    ipaController.text = widget.butuanonWord.ipa;
    audioController.text = widget.butuanonWord.audio;
    transEnglishController.text = widget.butuanonWord.transEnglish;
    transTagalogController.text = widget.butuanonWord.transTagalog;
    difinitionController.text = widget.butuanonWord.difinition;
    engSentencesController.text = widget.butuanonWord.engSentences;
    tagSentencesController.text = widget.butuanonWord.tagSentences;
    btwSentencesController.text = widget.butuanonWord.btwSentences;
    synEnglishController.text = widget.butuanonWord.synEnglish;
    synTagalogController.text = widget.butuanonWord.synTagalog;
    antEnglishController.text = widget.butuanonWord.antEnglish;
    antTagalogController.text = widget.butuanonWord.antTagalog;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: makeDismissible(
        context,
        child: DraggableScrollableSheet(
          initialChildSize: 0.9,
          maxChildSize: 0.9,
          minChildSize: 0.4,
          builder: (_, controller) => Container(
            height: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(20))),
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
                controller: controller,
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    const Text(
                      'Add Butuanon Word',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffFD7F2C)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    formInputField(
                        hintText: 'Butuanon Word',
                        controller: butuanonWordController),
                    formInputField(
                        hintText: 'Part of Speech',
                        controller: partOfSpeechController),
                    formInputField(
                        hintText: 'IPA', controller: ipaController),
                    formInputField(
                        hintText: 'Audio',
                        textInputType: TextInputType.url,
                        controller: audioController),
                    formInputField(
                          hintText: 'Difinition',
                          controller: difinitionController),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Transalation:',
                        style: TextStyle(color: Color(0xffFD7F2C)),
                      ),
                      formInputField(
                          hintText: 'English',
                          controller: transEnglishController),
                      formInputField(
                          hintText: 'Tagalog',
                          controller: transTagalogController),
                         const SizedBox(
                      height: 10,
                    ),
                     const Text(
                      'Sentences:',
                      style: TextStyle(color: Color(0xffFD7F2C)),
                    ),
                    formInputField(
                        hintText: 'English',
                        controller: engSentencesController),
                          formInputField(
                        hintText: 'Tagalog',
                        controller: tagSentencesController),
                          formInputField(
                        hintText: 'Butuanon',
                        controller: btwSentencesController),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Synonyms:',
                      style: TextStyle(color: Color(0xffFD7F2C)),
                    ),
                    formInputField(
                        hintText: 'English',
                        controller: synEnglishController),
                    formInputField(
                        hintText: 'Tagalog',
                        controller: synTagalogController),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Antonyms:',
                      style: TextStyle(color: Color(0xffFD7F2C)),
                    ),
                    formInputField(
                        hintText: 'English',
                        controller: antEnglishController),
                    formInputField(
                        hintText: 'Tagalog',
                        controller: antTagalogController),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                            ),
                            onPressed: () {
                              Butuanon butuanon = Butuanon(
                                  btwId: widget.butuanonWord.btwId,
                                  btwWord: butuanonWordController.text,
                                  partOfSpeech: partOfSpeechController.text,
                                  ipa: ipaController.text,
                                  audio: audioController.text,
                                  transEnglish: transEnglishController.text,
                                  transTagalog: transTagalogController.text,
                                  difinition: difinitionController.text,
                                  engSentences: engSentencesController.text,
                                  tagSentences: tagSentencesController.text,
                                  btwSentences: btwSentencesController.text,
                                  synEnglish: synEnglishController.text,
                                  synTagalog: synTagalogController.text,
                                  antEnglish: antEnglishController.text,
                                  antTagalog: antTagalogController.text);

                              _reference
                                  .doc(widget.butuanonWord.btwId)
                                  .update(butuanon.toJson())
                                  .whenComplete(() {
                                log('success');
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AdminPage()));
                              });
                            },
                            child: const Text(
                              'Save',
                              style: TextStyle(fontSize: 16),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 200,
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
