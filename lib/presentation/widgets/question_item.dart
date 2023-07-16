import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:smartup/core/styles/colors.dart';
import 'package:smartup/core/values/dimens.dart';
import 'package:smartup/data/course/model/question_list_response.dart';
import 'package:smartup/presentation/widgets/gap.dart';


class QuestionItem extends StatefulWidget {
  final QuestionData questionData;
  final Function(String answer) optionSelected;
  final int page;
  const QuestionItem({super.key, required this.questionData, required this.page, required this.optionSelected});

  @override
  State<QuestionItem> createState() => _QuestionItemState();
}

class _QuestionItemState extends State<QuestionItem> {
  String? selectedOption;

  @override
  void initState() {
    setState(() {
      selectedOption = widget.questionData.studentAnswer;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var questionData = widget.questionData;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Soal Nomor ${widget.page+1}"),
        if(questionData.questionTitleImg != null) Container(margin: const EdgeInsets.only(top: Dimens.d16), child: CachedNetworkImage(imageUrl: questionData.questionTitleImg!)),
        if(questionData.questionTitle != null) Container(margin: const EdgeInsets.only(top: Dimens.d16), child: HtmlWidget(questionData.questionTitle ?? "")),
        const Gap(),
        Card(
          margin: const EdgeInsets.symmetric(vertical: Dimens.d8),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: selectedOption == "A" ? colorScheme(context).primaryContainer : colorScheme(context).surfaceVariant,
          child: InkWell(
            onTap: (){
              widget.optionSelected.call("A");
              setState(() {
                selectedOption = "A";
              });
            },
            child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(Dimens.d16),
            child: Column(
              children: [
                Row(children: [const Text("A"), const Gap(w: Dimens.d16,), Expanded(child: HtmlWidget(questionData.optionA ?? ""))],),
                if(questionData.optionAImg != null) Container(margin: const EdgeInsets.only(top: Dimens.d4),child: CachedNetworkImage(imageUrl: questionData.optionAImg!)),
              ],
            ),),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(vertical: Dimens.d8),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: selectedOption == "B" ? colorScheme(context).primaryContainer : colorScheme(context).surfaceVariant,
          child: InkWell(
            onTap: (){
              widget.optionSelected.call("B");
              setState(() {
                selectedOption = "B";
              });
            },
            child: Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(Dimens.d16),
              child: Column(
                children: [
                  Row(children: [const Text("B"), const Gap(w: Dimens.d16,), Expanded(child: HtmlWidget(questionData.optionB ?? ""))],),
                  if(questionData.optionBImg != null) Container(margin: const EdgeInsets.only(top: Dimens.d4),child: CachedNetworkImage(imageUrl: questionData.optionBImg!)),
                ],
              ),
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(vertical: Dimens.d8),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: selectedOption == "C" ? colorScheme(context).primaryContainer : colorScheme(context).surfaceVariant,
          child: InkWell(
            onTap: (){
              widget.optionSelected.call("C");
              setState(() {
                selectedOption = "C";
              });
            },
            child: Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(Dimens.d16),
              child: Column(
                children: [
                  Row(children: [const Text("C"), const Gap(w: Dimens.d16,), Expanded(child: HtmlWidget(questionData.optionC ?? ""))],),
                  if(questionData.optionCImg != null) Container(margin: const EdgeInsets.only(top: Dimens.d4),child: CachedNetworkImage(imageUrl: questionData.optionCImg!)),
                ],
              ),
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(vertical: Dimens.d8),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: selectedOption == "D" ? colorScheme(context).primaryContainer : colorScheme(context).surfaceVariant,
          child: InkWell(
            onTap: (){
              widget.optionSelected.call("D");
              setState(() {
                selectedOption = "D";
              });
            },
            child: Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(Dimens.d16),
              child: Column(
                children: [
                  Row(children: [const Text("D"), const Gap(w: Dimens.d16,), Expanded(child: HtmlWidget(questionData.optionD ?? ""))],),
                  if(questionData.optionDImg != null) Container(margin: const EdgeInsets.only(top: Dimens.d4),child: CachedNetworkImage(imageUrl: questionData.optionDImg!)),
                ],
              ),
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(vertical: Dimens.d8),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: selectedOption == "E" ? colorScheme(context).primaryContainer : colorScheme(context).surfaceVariant,
          child: InkWell(
            onTap: (){
              widget.optionSelected.call("E");
              setState(() {
                selectedOption = "E";
              });
            },
            child: Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(Dimens.d16),
              child: Column(
                children: [
                  Row(children: [const Text("E"), const Gap(w: Dimens.d16,), Expanded(child: HtmlWidget(questionData.optionE ?? ""))],),
                  if(questionData.optionEImg != null) Container(margin: const EdgeInsets.only(top: Dimens.d4),child: CachedNetworkImage(imageUrl: questionData.optionEImg!)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
